import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class LeadSave extends StatefulWidget {
  const LeadSave({super.key});

  @override
  State<LeadSave> createState() => _MyWidgetState();
}

final TextEditingController _keyWordController = TextEditingController();

class _MyWidgetState extends State<LeadSave> {
  String keyword = _keyWordController.text.trim();
  int? _character = 1;
  String? executiveValue;
  int? folderName;
  int? sourceName;
  int? branchName;
  int? assignee;
  List<dynamic> _folders = [];
  List<dynamic> _sources = [];
  List<dynamic> _branches = [];
  List<dynamic> _assignees = [];
  bool isDocument = false;
  bool isSubscribe = true;
  String? myFile;
  String? myFileName;

  Future<void> pickFile(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        myFile = result.files.single.path;
        myFileName = result.files.single.name;
        setFilePathAndName(myFile, myFileName);
        print("myFile ${myFile}");
        print("myFileName ${myFileName}");
      });
    }
  }

  void setFolderValue(int? folder) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('folder', folder ?? 0);
  }

  void setSourceValue(int? source) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('source', source ?? 0);
  }

  void setBranchValue(int? branch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('branch', branch ?? 0);
  }

  void setAssigneeValue(int? assignee) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('assignee', assignee ?? 0);
  }

  void setFilePathAndName(String? path, name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('path', path ?? "");
    await prefs.setString('fileName', name ?? "");
  }

  void setSaveType(int? type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('saveType', type!);
  }

  void setKeywords(String? keyword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('keyword', keyword!);
  }

  void setConfidential(bool? confidential) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('confidential', confidential ?? false);
  }

  void setSubscribe(bool? subscribe) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('subscribe', subscribe ?? false);
  }

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  void fetchAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
    int? _folder = prefs.getInt('folder');
    int? _source = prefs.getInt('source');
    int? _branch = prefs.getInt('branch');
    int? _assignee = prefs.getInt('assignee');
    bool? _confidential = prefs.getBool('confidential');
    bool? _subscribe = prefs.getBool('subscribe');
    String? _myFile = prefs.getString("path");
    String? _filename = prefs.getString("fileName");

    if (_folder != null) {
      folderName = _folder;
    }
    if (_source != null) {
      sourceName = _source;
    }

    if (_branch != null) {
      branchName = _branch;
    }
    if (_assignee != null) {
      assignee = _assignee;
    }

    if (_confidential != null) {
      isDocument = _confidential;
    }

    if (_subscribe != null) {
      isSubscribe = _subscribe;
    }

    if (_myFile != null) {
      myFile = _myFile;
      if (myFile != null) {
        myFileName = _filename;
        print("_myFile ${_myFile}");
        print("_filename ${_filename}");
      }
    }
    if (token != null) {
      fetchFolders(token, _dbName);
      fetchSources(token, _dbName);
      fetchBraches(token, _dbName);
      fetchAssignees(token, _dbName);
    }
  }

  void fetchFolders(token, _dbName) async {
    final url = Uri.parse(
        '${Environment.apiUrl}api/contact-creation-data?db_name=${_dbName}');

    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          _folders = dataResponse["data"]["folders"];
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchSources(token, _dbName) async {
    final url = Uri.parse(
        '${Environment.apiUrl}api/contact-creation-data?db_name=${_dbName}');

    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          _sources = dataResponse["data"]["sources"];
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchBraches(token, _dbName) async {
    final url = Uri.parse(
        '${Environment.apiUrl}api/contact-creation-data?db_name=${_dbName}');

    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          _branches = dataResponse["data"]["branches"];
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchAssignees(token, _dbName) async {
    final url = Uri.parse(
        '${Environment.apiUrl}api/contact-creation-data?db_name=${_dbName}');

    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          _assignees = dataResponse["data"]["users"];
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text("Folder"),
            SizedBox(
              width: 5,
            ),
            Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: DropdownButtonFormField<int>(
            style: const TextStyle(color: Colors.black),
            value: folderName,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: const Text(
              'Select the folder',
              style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
            ),
            onChanged: (int? value) {
              setState(() {
                folderName = value;
                setFolderValue(value);
              });
            },
            items: _folders.map<DropdownMenuItem<int>>((dynamic state) {
              final id = state['id'];
              final name = state['folder_name'];
              return DropdownMenuItem<int>(
                value: id,
                child: Text(name),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Text("Source"),
            SizedBox(
              width: 5,
            ),
            Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: DropdownButtonFormField<int>(
            style: const TextStyle(color: Colors.black),
            value: sourceName,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: const Text(
              'Select the source',
              style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
            ),
            onChanged: (int? value) {
              setState(() {
                sourceName = value;
                setSourceValue(value);
              });
            },
            items: _sources.map<DropdownMenuItem<int>>((dynamic state) {
              final id = state['id'];
              final name = state['source_name'];
              return DropdownMenuItem<int>(
                value: id,
                child: Text(name),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Text("Branch"),
            SizedBox(
              width: 5,
            ),
            Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: DropdownButtonFormField<int>(
            style: const TextStyle(color: Colors.black),
            value: branchName,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: const Text(
              'Select the branch',
              style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
            ),
            onChanged: (int? value) {
              setState(() {
                branchName = value;
                setBranchValue(value);
              });
            },
            items: _branches.map<DropdownMenuItem<int>>((dynamic state) {
              final id = state['id'];
              final name = state['branch_name'];
              return DropdownMenuItem<int>(
                value: id,
                child: Text(name),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Text("Assignee"),
            SizedBox(
              width: 5,
            ),
            Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: DropdownButtonFormField<int>(
            style: const TextStyle(color: Colors.black),
            value: assignee,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: const Text(
              'Select the Assignee',
              style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
            ),
            onChanged: (int? value) {
              setState(() {
                assignee = value;
                setAssigneeValue(value);
              });
            },
            items: _assignees.map<DropdownMenuItem<int>>((dynamic state) {
              final id = state['id'];
              final name = state['name'];
              return DropdownMenuItem<int>(
                value: id,
                child: Text(name),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Keywords"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: TextField(
            controller: _keyWordController,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: 'Enter keywords',
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 128, 124, 124),
                  fontWeight: FontWeight.w400),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontSize: 13,
            ),
            onChanged: (value) {
              setKeywords(value);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Text("Type"),
            SizedBox(
              width: 5,
            ),
            Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                transform: Matrix4.translationValues(-11.0, 0.0, 0.0),
                child: RadioListTile<int>(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('Private', style: TextStyle(fontSize: 15)),
                  value: 1,
                  groupValue: _character,
                  onChanged: (int? value) {
                    setState(() {
                      _character = value;
                      setSaveType(value);
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                transform: Matrix4.translationValues(-50.0, 0.0, 0.0),
                child: RadioListTile<int>(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    'Branch',
                    style: TextStyle(fontSize: 15),
                  ),
                  value: 2,
                  groupValue: _character,
                  onChanged: (int? value) {
                    setState(() {
                      _character = value;
                      setSaveType(value);
                      print("_character ${value}");
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            transform: Matrix4.translationValues(-12.0, 0.0, 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        checkColor: Colors.white,
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color(0xFF6546D2);
                            }
                            return Colors.white;
                          },
                        ),
                        value: isDocument,
                        onChanged: (bool? value) {
                          setState(() {
                            isDocument = value!;
                            setConfidential(value);
                          });
                        }),
                    const Text(
                      "SMS notification to Assignee",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color(0xFF6546D2);
                              }
                              return Colors.white;
                            },
                          ),
                          value: isSubscribe,
                          onChanged: (bool? value) {
                            setState(() {
                              isSubscribe = value!;
                              setSubscribe(value);
                            });
                          }),
                      const Text(
                        "SMS notification to Contact",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color(0xFF6546D2);
                              }
                              return Colors.white;
                            },
                          ),
                          value: isSubscribe,
                          onChanged: (bool? value) {
                            setState(() {
                              isSubscribe = value!;
                              setSubscribe(value);
                            });
                          }),
                      const Text(
                        "Email notification to Assignee",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color(0xFF6546D2);
                              }
                              return Colors.white;
                            },
                          ),
                          value: isSubscribe,
                          onChanged: (bool? value) {
                            setState(() {
                              isSubscribe = value!;
                              setSubscribe(value);
                            });
                          }),
                      const Text(
                        "Email notification to Contact",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color(0xFF6546D2);
                              }
                              return Colors.white;
                            },
                          ),
                          value: isSubscribe,
                          onChanged: (bool? value) {
                            setState(() {
                              isSubscribe = value!;
                              setSubscribe(value);
                            });
                          }),
                      const Text(
                        "Terms and condition shared",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 4, 12, 9)),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text('Previous')),
                      FilledButton(
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xff06C270)),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {},
                          child: const Text('Submit'))
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
