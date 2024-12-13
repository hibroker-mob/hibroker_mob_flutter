import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Recordings extends StatefulWidget {
  const Recordings({super.key});

  @override
  State<Recordings> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Recordings> {
  List<File> _audioFiles = [];
  String _directoryPath = '';
  bool isClicked = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool loading = false;
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
    requestPermission();
  }

  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      final androidVersion = int.parse(
          Platform.version.split(' ')[0].replaceAll(RegExp('[^0-9]'), ''));

      if (androidVersion >= 33) {
        var audioStatus = await Permission.audio.status;
        if (audioStatus.isDenied) {
          print('Requesting audio permission');
          audioStatus = await Permission.audio.request();
        }

        var photoStatus = await Permission.photos.status;
        if (photoStatus.isDenied) {
          print('Requesting photos permission');
          photoStatus = await Permission.photos.request();
        }
      } else if (androidVersion >= 29) {
        var storageStatus = await Permission.storage.status;
        if (storageStatus.isDenied) {
          print('Requesting storage permission');
          storageStatus = await Permission.storage.request();
        }

        if (androidVersion >= 30) {
          if (await Permission.manageExternalStorage.isGranted) {
            print("Manage external storage permission granted!");
          } else {
            var managePermissionStatus =
                await Permission.manageExternalStorage.request();
            if (managePermissionStatus.isGranted) {
              print("Manage external storage permission granted!");
            } else {
              print("Manage external storage permission denied!");
              openAppSettings();
            }
          }
        }
      } else {
        // For Android versions below 10
        var status = await Permission.storage.status;
        if (status.isDenied) {
          print('Requesting storage permission');
          status = await Permission.storage.request();
        }
      }
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
      setState(() {
        _audioFiles = audioFiles;
        print("audioFiles ${audioFiles}");
      });
    }
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
    try {
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  // void storedRecordings() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? token = prefs.getString('MY_TOKEN');
  //   final url = Uri.parse('${Environment.apiUrl}api/call-recordings');

  //   try {
  //     List<String> filePaths = _audioFiles.map((file) => file.path).toList();

  //     final response = await http.post(url,
  //         headers: {
  //           "Authorization": "Bearer $token",
  //           "Content-Type": "application/json"
  //         },
  //         body: jsonEncode({
  //           "user_id": 2,
  //           'caller_name':"Tamal Naskar",
  //           "caller_number": "8348426639",
  //           "date_time": "2024-11-23 00:39:13",
  //           "call_type": "incoming",
  //           "file_name": filePaths[3]
  //         }));

  //     if (response.statusCode == 200) {
  //       final dataResponse = jsonDecode(response.body);
  //       print("Success ${dataResponse}");
  //     } else {
  //       final dataResponse = jsonDecode(response.body);
  //       print("Error ${dataResponse}");
  //     }
  //   } catch (error) {
  //     print("Error ${error}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: Padding(
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
              else if (_audioFiles.isNotEmpty)
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
                                  playAudio(file.path);
                                },
                                child: const Icon(
                                  Icons.not_started_outlined,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                              )
                            ],
                          ));
                    },
                  ),
                )
              else
                Expanded(
                  child: Center(
                    child: Image.network(
                      "https://img.freepik.com/premium-vector/no-data-concept-illustration_86047-488.jpg?semt=ais_hybrid",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
