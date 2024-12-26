import 'dart:async';
import 'dart:io';
import 'package:call_e_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:hibroker/routes/app_routes.dart';
import 'package:cron/cron.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

Timer? _timer;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  late Cron cron;
  List<CallLogEntry> _callLogs = [];
  List<CallLogEntry> filterCallLogs = [];
  List<Map<String, dynamic>> callLogDetails = [];
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

  void startCronJob() {
    cron.schedule(Schedule.parse('*/5 * * * * '), () {
      startRepeatingTask();
      print("Hello World");
    });
  }

  void startRepeatingTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final _dirPath = prefs.getString('_dirPath');
    print("_dirPath ${_dirPath}");
    _pickDirectoryTimer();
  }

  Future<void> _pickDirectoryTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final _dirPath = await prefs.getString('_dirPath');
    print("_dirPath ${_dirPath}");
    if (_dirPath != null) {
      final audioFiles = await getAudioFiles(_dirPath);
      if (audioFiles.length > 0) {
        printAudioFilesDetails(audioFiles, _dirPath);
      }
    }
  }

  Future<List<File>> getAudioFiles(String directoryPath) async {
    Directory directory = Directory(directoryPath);

    List<File> audioFiles = [];
    try {
      audioFiles = directory
          .listSync()
          .where((file) =>
              file is File &&
              audioFileExtensions.any((ext) => file.path.endsWith(ext)))
          .map((item) => File(item.path))
          .toList();
    } catch (e) {
      print("Error getting audio files: $e");
    }

    return audioFiles;
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

  Future<void> fetchCallLogs() async {
    try {
      Iterable<CallLogEntry> logs = await CallLog.get();
      setState(() {
        _callLogs = logs.toList();
        filterCallLogs = logs.toList();
        print("All Call Logs: ${logs.toList()}");
      });
    } catch (error) {
      print("Error $error");
    } finally {}
  }

  String normalizePhoneNumber(String phoneNumber) {
    RegExp regExp = RegExp(r'^(?:\+?91|91)?(\d{10})$');
    var match = regExp.firstMatch(phoneNumber);
    if (match != null) {
      return match.group(1)!;
    }
    return phoneNumber;
  }

  Future<void> printAudioFilesDetails(
      List<File> audioFiles, _directoryPath2) async {
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
    storedRecordings(_directoryPath2);

    print('Call Log Details: $callLogDetails');
  }

  void storedRecordings(_directoryPath2) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
    final int? USERID = prefs.getInt("USERID");
    final url = Uri.parse(
        '${Environment.apiUrl}api/call-recordings?db_name=${_dbName}');

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
        print("Successfully added");
      } else {
        print("Error at adding records");
      }
    } catch (error) {
      print("Error at adding records ${error}");
    }
  }

  @override
  void initState() {
    super.initState();
    cron = Cron();
    startCronJob();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Component Routings',
      initialRoute: AppRoutes.loginMail,
      routes: AppRoutes.define(),
    );
  }
}
