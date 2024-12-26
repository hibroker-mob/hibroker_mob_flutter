import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:call_e_log/call_log.dart';
import 'package:toastification/toastification.dart';
import 'package:cron/cron.dart';

class Recordings extends StatefulWidget {
  const Recordings({super.key});

  @override
  State<Recordings> createState() => _MyWidgetState();
}

// Timer? _timer;

class _MyWidgetState extends State<Recordings> {
  List<File> _audioFiles = [];
  String _directoryPath = '';
  bool isClicked = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool loading = false;
  List<CallLogEntry> _callLogs = [];
  List<CallLogEntry> filterCallLogs = [];
  List<Map<String, dynamic>> callLogDetails = [];
  List<dynamic> _dbRecordings = [];
  bool isStart = false;
  int? activeAudioId;
  bool isStartDirAudio = false;
  int? _dirIndex;
  bool saveReloading = false;
  final List<String> audioFileExtensions = [
    '.mp3',
    '.wav',
    '.m4a',
    '.aac',
    '.ogg',
    '.amr',
    '.aa',
    '.aax',
    '.act',
    '.aiff',
    '.alac',
    '.ape',
    '.au',
    '.awb',
    '.dss',
    '.dvf',
    '.flac',
    '.gsm',
    '.m4b',
    '.m4p',
    '.mmf',
    '.mpc',
    '.msv',
    '.nmf',
    '.opus',
    '.ra',
    '.rm',
    '.raw',
    '.rf6A',
    '.sln',
    '.tta',
    '.voc',
    '.vox',
    '.wma',
    '.wv',
    '.webm',
    '.8svx',
    '.cda'
  ];

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
    // startRepeatingTask();
  }

  Future<void> checkAndRequestPermissions() async {
    if (Platform.isAndroid) {
      final androidVersion = int.parse(
          Platform.version.split(' ')[0].replaceAll(RegExp('[^0-9]'), ''));

      if (androidVersion >= 33) {
        await _requestPermission(Permission.audio, "audio");
        await _requestPermission(Permission.photos, "photos");
      } else if (androidVersion >= 29) {
        await _requestPermission(Permission.storage, "storage");

        if (androidVersion >= 30) {
          if (!await Permission.manageExternalStorage.isGranted) {
            print("Requesting manageExternalStorage permission");
            var status = await Permission.manageExternalStorage.request();
            if (!status.isGranted) {
              print("Manage external storage permission denied!");
              openAppSettings();
            }
          }
        }
      } else {
        await _requestPermission(Permission.storage, "storage");
      }
    }

    final phonePermission = await Permission.phone.request();
    if (!phonePermission.isGranted) {
      _showPermissionDialog(
        "Permission Denied",
        "Please grant permission to access call logs.",
      );
    }
    fetchRecordings();
  }

  Future<void> fetchRecordings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final int? USERID = prefs.getInt("USERID");
    final String? _dbName = prefs.getString('dbName');
    print("_dbName ${_dbName}");
    final url = Uri.parse(
        '${Environment.apiUrl}api/call-recordings/user/${USERID}?db_name=${_dbName}');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        print("DB Recordings ${dataResponse.length}");
        setState(() {
          _dbRecordings = dataResponse.toList();
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  Future<void> _requestPermission(Permission permission, String name) async {
    var status = await permission.status;
    if (status.isDenied) {
      print("Requesting $name permission");
      await permission.request();
    }
  }

  void _showPermissionDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchCallLogs() async {
    setState(() {
      loading = true;
    });
    try {
      Iterable<CallLogEntry> logs = await CallLog.get();
      setState(() {
        _callLogs = logs.toList();
        filterCallLogs = logs.toList();
        print("All Call Logs: ${logs.toList()}");
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
      print("Error $error");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  String normalizePhoneNumber(String phoneNumber) {
    RegExp regExp = RegExp(r'^(?:\+?91|91)?(\d{10})$');
    var match = regExp.firstMatch(phoneNumber);
    if (match != null) {
      return match.group(1)!;
    }
    return phoneNumber;
  }

  Future<void> printAudioFilesDetails(List<File> audioFiles) async {
    await fetchCallLogs();

    callLogDetails.clear();

    for (File file in audioFiles) {
      try {
        String fileName = p.basename(file.path);
        FileStat fileStat = await file.stat();
        DateTime createdDate = fileStat.changed;

        String cleanedFileName = cleanFileName(fileName);

        String normalizedFileName = normalizePhoneNumber(cleanedFileName);

        List<CallLogEntry> matchingLogs = _callLogs
            .where(
              (log) =>
                  (normalizePhoneNumber(log.name ?? "") ==
                      normalizedFileName) ||
                  (normalizePhoneNumber(log.number ?? "") ==
                      normalizedFileName),
            )
            .toList();

        for (var log in matchingLogs) {
          Map<String, dynamic> logDetails = {
            'fileName': cleanedFileName,
            'callType': log.callType == CallType.incoming
                ? 'Incoming'
                : log.callType == CallType.outgoing
                    ? 'Outgoing'
                    : log.callType == CallType.missed
                        ? "Missed"
                        : log.callType == CallType.rejected
                            ? "Decline"
                            : "",
            'dateTime': createdDate,
            'filePath': file.path,
            'personName': log.name?.isNotEmpty == true ? log.name : "Unknown",
            'contactNumber': log.number ?? "Unknown"
          };

          if (!callLogDetails.any((logEntry) =>
              logEntry['fileName'] == cleanedFileName &&
              logEntry['callType'] == logDetails['callType'])) {
            callLogDetails.add(logDetails);
          }
        }
      } catch (e) {
        print('Error reading file details for ${file.path}: $e');
      }
    }

    print('Call Log Details: $callLogDetails');
  }

  String cleanFileName(String filePath) {
    String baseName = p.basename(filePath);
    String nameWithoutExtension = baseName.split('.').first;
    if (nameWithoutExtension.startsWith('Call recording')) {
      String afterPrefix = nameWithoutExtension
          .replaceFirst(RegExp(r'Call recording(\s[+-])?'), '')
          .trim();
      int underscoreIndex = afterPrefix.indexOf('_');
      if (underscoreIndex != -1) {
        return afterPrefix.substring(0, underscoreIndex).trim();
      } else {
        return afterPrefix.split(RegExp(r'\s@|\s')).first.trim();
      }
    } else if (nameWithoutExtension.startsWith('Audio from')) {
      return nameWithoutExtension.replaceFirst('Audio from', '').trim();
    } else if (nameWithoutExtension.contains('Ref')) {
      return nameWithoutExtension.split('Ref').first.trim();
    }

    return nameWithoutExtension;
  }

  String _formatDateTime(String dateTime) {
    try {
      final DateTime parsedDate = DateTime.parse(dateTime);
      final String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
      final String formattedTime = DateFormat('HH:mm').format(parsedDate);
      return '$formattedDate $formattedTime';
    } catch (e) {
      return 'Invalid Date';
    }
  }

  Future<void> pickDirectory() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null) {
      setState(() {
        _directoryPath = directoryPath;
        _audioFiles = [];
      });

      final audioFiles = await getAudioFiles(directoryPath);
      if (audioFiles.length > 0) {
        printAudioFilesDetails(audioFiles);
      }
      setState(() {
        _audioFiles = audioFiles;
        print("audioFiles ${audioFiles}");
      });
    }
  }

  void clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('_dirPath');
  }

  Future<List<File>> getAudioFiles(String directoryPath) async {
    Directory directory = Directory(directoryPath);

    List<File> audioFiles = [];
    setState(() {
      loading = true;
    });
    try {
      audioFiles = directory
          .listSync()
          .where((file) =>
              file is File &&
              audioFileExtensions.any((ext) => file.path.endsWith(ext)))
          .map((item) => File(item.path))
          .toList();
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error getting audio files: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }

    return audioFiles;
  }

  void playAudio(String filePath) async {
    print("filePath ${filePath}");
    try {
      if (filePath.startsWith('https')) {
        print("True");
        await _audioPlayer.play(UrlSource(filePath));
      } else {
        await _audioPlayer.play(DeviceFileSource(filePath));
      }
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void stopAudio() async {
    try {
      await _audioPlayer.stop();
      print("Audio stopped");
    } catch (e) {
      print("Error stopping audio: $e");
    }
  }

  void storedRecordings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
    final int? USERID = prefs.getInt("USERID");
    final url = Uri.parse(
        '${Environment.apiUrl}api/call-recordings?db_name=${_dbName}');
    setState(() {
      saveReloading = true;
    });
    try {
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        });

      for (var i = 0; i < callLogDetails.length; i++) {
        final log = callLogDetails[i];

        request.fields.addAll({
          "records[$i][user_id]": USERID.toString(),
          "records[$i][caller_name]": log['personName'] == "Unknown"
              ? "Unknown"
              : log['personName'] ?? 'Unknown',
          "records[$i][caller_number]": log['contactNumber'] ?? 'N/A',
          "records[$i][call_type]": log['callType'] ?? 'Unknown',
          "records[$i][date_time]": log['dateTime']?.toString() ?? '',
        });

        final filePath = log['filePath'];

        if (filePath != null && filePath.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath(
            'records[$i][file_name]',
            filePath,
          ));
        } else {
          print("No file path available for ${log['fileName']}");
        }
      }
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          prefs.setString('_dirPath', _directoryPath ?? "");
          _directoryPath = "";
          print("_directoryPath ${_directoryPath}");
          callLogDetails = [];
        });
        fetchRecordings();
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
          title: const Text(
            'Recording Uploaded',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.green,
          backgroundColor: Colors.white,
          description: const Text(
            "Great!! Recording uploaded successfully",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
          ),
        );
      } else {
        print("response ${responseBody}");
        setState(() {
          saveReloading = false;
        });
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          title: const Text(
            'Recording upload failed',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          description: const Text(
            "Recording upload has been failed. Try again ",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
          ),
        );
        print("Failed to upload: ${response.statusCode}");
      }
    } catch (error) {
      setState(() {
        saveReloading = false;
      });
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
        title: const Text(
          'Recording upload failed',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
        ),
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        description: const Text(
          "Recording upload has been failed. Try again ",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
        ),
      );
      print("Error: $error");
    } finally {
      setState(() {
        saveReloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            storedRecordings();
          },
          backgroundColor: const Color(0xff6546D2),
          child: saveReloading == false
              ? const Icon(Icons.add, color: Colors.white)
              : LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 25,
                ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff6546D2),
          title: const Text(
            'Property Management Company',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.email_outlined),
              color: Colors.white,
              onPressed: () {
                print('Message icon pressed');
              },
            ),
            IconButton(
              icon: Container(
                width: 45,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.zero,
                  image: DecorationImage(
                    image: AssetImage('assets/images/user_avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onPressed: () {
                print('Image icon pressed');
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        drawer: const DashboardDrawer(),
        body: RefreshIndicator(
          onRefresh: fetchRecordings,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Call Records",
                  style: TextStyle(
                      fontSize: 25,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 1.4),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () {
                      setState(() {
                        isClicked = true;
                        // clear();
                      });
                    },
                    child: const Text('Recording Setting'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isClicked == true)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xff6546d2)),
                      ),
                      onPressed: () {
                        pickDirectory();
                      },
                      child: const Text('Recording Directory'),
                    ),
                  ),
                if (isClicked)
                  const Center(
                    child: Text('(Select a directory to load audio files)',
                        style: TextStyle(fontSize: 13)),
                  ),
                const SizedBox(
                  height: 15,
                ),
                if (_directoryPath.isEmpty && _dbRecordings.length > 0)
                  Expanded(
                    child: ListView.separated(
                      itemCount: _dbRecordings.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        thickness: .5,
                      ),
                      itemBuilder: (context, index) {
                        final log = _dbRecordings[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Caller_Name: ${log["caller_name"]}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "Caller_Number: ${log["caller_number"]}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "Call_Type: ${log["call_type"]}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "Date & Time: ${_formatDateTime(log["created_at"])}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (!isStart ||
                                          activeAudioId != log["id"]) {
                                        print("Clicked: Play Audio");
                                        playAudio(
                                            '${Environment.audioLink}${log["file_name"]}');
                                        setState(() {
                                          isStart = true;
                                          activeAudioId = log["id"];
                                        });
                                      } else {
                                        stopAudio();
                                        setState(() {
                                          isStart = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      child:
                                          isStart && activeAudioId == log["id"]
                                              ? const Icon(
                                                  Icons.pause_outlined,
                                                  color: Colors.green,
                                                  size: 30.0,
                                                )
                                              : const Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.green,
                                                  size: 30.0,
                                                ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                else if (_dbRecordings.length == 0)
                  Expanded(
                    child: Center(
                      child: Image.network(
                        "https://img.freepik.com/premium-vector/no-data-concept-illustration_86047-488.jpg?semt=ais_hybrid",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (_directoryPath.isNotEmpty)
                  Text(
                    "Path: $_directoryPath",
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  )
                else
                  const Text(""),
                if (_directoryPath.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                if (_directoryPath.isNotEmpty) const Divider(),
                if (loading)
                  Expanded(
                      child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color(0xff6546D2), size: 47),
                  ))
                else if (_directoryPath.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      itemCount: _audioFiles.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        thickness: .5,
                      ),
                      itemBuilder: (context, index) {
                        final file = _audioFiles[index];
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 3, 10, 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  file.path.split('/').last.length > 40
                                      ? "${file.path.split('/').last.substring(0, 40)}..."
                                      : file.path.split('/').last,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (!isStartDirAudio ||
                                        _dirIndex != index) {
                                      print("Clicked: Play Audio");
                                      playAudio(file.path);
                                      setState(() {
                                        isStartDirAudio = true;
                                        _dirIndex = index;
                                      });
                                    } else {
                                      stopAudio();
                                      setState(() {
                                        isStartDirAudio = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    child: isStartDirAudio && _dirIndex == index
                                        ? const Icon(
                                            Icons.pause_outlined,
                                            color: Colors.green,
                                            size: 30.0,
                                          )
                                        : const Icon(
                                            Icons.play_arrow,
                                            color: Colors.green,
                                            size: 30.0,
                                          ),
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
