import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactHeader.dart';
import 'package:hibroker/pages/Contact/AllContacts/TransferContactList.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Transfer> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _aniversaryController = TextEditingController();
  int? _transferType = 1;
  String? tabName = "Contacts";
  bool sendMessage_Assignee = false;
  bool sendEmail_Assignee = false;
  bool stayOn = false;
  bool sendMessage_Customer = false;
  bool sendEmail_Customer = false;
  int? permission;
  int? folderName;
  int? branchName;
  int? assignee;
  List<dynamic> _folders = [];
  List<dynamic> _branches = [];
  List<dynamic> _assignees = [];
  List<String> _contactList = [];
  List<dynamic> _permissionValues = [
    {'name': 'Private', 'value': 0},
    {'name': 'Branch', 'value': 1},
  ];
  bool loading = false;

  void _fetchSelectedContacts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? myContacts = prefs.getStringList('contactList');
    print("myContacts ${myContacts}");
    _contactList = myContacts!;
  }

  void setFolderValue(int? folder) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('folder', folder ?? 0);
  }

  void setBranchValue(int? branch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('branch', branch ?? 0);
  }

  void setAssigneeValue(int? assignee) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('assignee', assignee ?? 0);
  }

  void fetchFolders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
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

  void fetchBraches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
   final String? _dbName = prefs.getString('dbName');
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

  void fetchAssignees() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
   final String? _dbName = prefs.getString('dbName');
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

  void clearSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('contactList');
  }

  void submitTransferGroup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
    print("_dbName $_dbName");
    final url = Uri.parse(
        '${Environment.apiUrl}api/contact-grouptransfer?db_name=${_dbName}');
    print("URl ${url}");

    final requestBody = jsonEncode({
      "contact_ids": _contactList,
      "transfer_folder": folderName,
      "transfer_branch": branchName,
      "transfer_user": assignee,
      "transfer_type_status": _transferType ?? 0,
      "transferType": permission,
      "send_message_to_assignee": sendMessage_Assignee == true ? 1 : 0,
      "send_email_to_assignee": sendEmail_Assignee == true ? 1 : 0,
      "send_message_to_customer": sendMessage_Customer == true ? 1 : 0,
      "send_email_to_customer": sendEmail_Customer == true ? 1 : 0
    });
    print("requestBody ${requestBody}");
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: requestBody,
      );
      print("response ${response}");
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        if (dataResponse["success"] == true) {
          toastification.show(
              context: context,
              type: ToastificationType.success,
              style: ToastificationStyle.minimal,
              title: const Text(
                'Transfered Successfully',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
              ),
              autoCloseDuration: const Duration(seconds: 4),
              primaryColor: Colors.green,
              backgroundColor: Colors.white,
              description: const Text(
                "Group has been transfered succesfully",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ));
          Navigator.pushNamed(context, "/allContact");
        } else {
          toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.minimal,
              title: const Text(
                'Transfer Failed',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
              ),
              autoCloseDuration: const Duration(seconds: 4),
              primaryColor: Colors.red,
              backgroundColor: Colors.white,
              description: const Text(
                "Group transfered has been failed. Try again",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ));
        }
      } else {
        setState(() {
          loading = false;
        });
        toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            title: const Text(
              'Transfer Failed',
              style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
            ),
            autoCloseDuration: const Duration(seconds: 4),
            primaryColor: Colors.red,
            backgroundColor: Colors.white,
            description: const Text(
              "Group transfered has been failed. Try again",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ));
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          title: const Text(
            'Transfer Failed',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          description: const Text(
            "Group transfered has been failed. Try again",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
          ));
      print("Error ${error}");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

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
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ContactHeader(),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabName = "Contacts";
                          clearSharedPref();
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: tabName == "Contacts"
                                  ? const Color(0xff6546d2)
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.group_add,
                                  color: tabName == "Contacts"
                                      ? Colors.white
                                      : const Color(0xff8C91B6),
                                  size: 33,
                                ),
                              ),
                              Text(
                                "Contacts",
                                style: TextStyle(
                                  color: tabName == "Contacts"
                                      ? Colors.white
                                      : const Color(0xff8C91B6),
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabName = "Transfer";
                          fetchFolders();
                          fetchBraches();
                          fetchAssignees();
                          _fetchSelectedContacts();
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: tabName == "Transfer"
                                  ? const Color(0xff6546d2)
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.group,
                                  color: tabName == "Transfer"
                                      ? Colors.white
                                      : const Color(0xff8C91B6),
                                  size: 33,
                                ),
                              ),
                              Text(
                                "Transfer",
                                style: TextStyle(
                                  color: tabName == "Transfer"
                                      ? Colors.white
                                      : const Color(0xff8C91B6),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )),
                    )),
                  ],
                ),
                if (tabName == "Contacts")
                  const Expanded(child: TransferContactList())
                else
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Transfer Contact",
                              style: TextStyle(
                                  fontSize: 25,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationThickness: 1.4),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              children: [
                                Text("Transfer Type"),
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
                            Container(
                              transform:
                                  Matrix4.translationValues(-10.0, -13.0, 0.0),
                              child: RadioListTile<int>(
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text(
                                  'Customer Transfer',
                                  style: TextStyle(fontSize: 13),
                                ),
                                value: 1,
                                groupValue: _transferType,
                                onChanged: (int? value) {
                                  setState(() {
                                    _transferType = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(-10.0, -35.0, 0.0),
                              child: RadioListTile<int>(
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text(
                                  'Cold Calling Transfer',
                                  style: TextStyle(fontSize: 13),
                                ),
                                value: 2,
                                groupValue: _transferType,
                                onChanged: (int? value) {
                                  setState(() {
                                    _transferType = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -51.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text("Folder"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    child: DropdownButtonFormField<int>(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      value: folderName,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: .5),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                      ),
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      hint: const Text(
                                        'Select the folder',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 116, 116)),
                                      ),
                                      onChanged: (int? value) {
                                        setState(() {
                                          folderName = value;
                                          setFolderValue(value);
                                        });
                                      },
                                      items: _folders
                                          .map<DropdownMenuItem<int>>(
                                              (dynamic state) {
                                        final id = state['id'];
                                        final name = state['folder_name'];
                                        return DropdownMenuItem<int>(
                                          value: id,
                                          child: Text(name),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -35.0, 0.0),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 10,
                                    ),
                                  ),
                                  Text(
                                    "OR",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      indent: 10,
                                      endIndent: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -40.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text("Branch"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    child: DropdownButtonFormField<int>(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      value: branchName,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: .5),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                      ),
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      hint: const Text(
                                        'Select the branch',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 116, 116)),
                                      ),
                                      onChanged: (int? value) {
                                        setState(() {
                                          branchName = value;
                                          setBranchValue(value);
                                        });
                                      },
                                      items: _branches
                                          .map<DropdownMenuItem<int>>(
                                              (dynamic state) {
                                        final id = state['id'];
                                        final name = state['branch_name'];
                                        return DropdownMenuItem<int>(
                                          value: id,
                                          child: Text(name),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -40.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text("Assign To"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    child: DropdownButtonFormField<int>(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      value: assignee,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: .5),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                      ),
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      hint: const Text(
                                        'Select the user',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 116, 116)),
                                      ),
                                      onChanged: (int? value) {
                                        setState(() {
                                          assignee = value;
                                          setAssigneeValue(value);
                                        });
                                      },
                                      items: _assignees
                                          .map<DropdownMenuItem<int>>(
                                              (dynamic state) {
                                        final id = state['id'];
                                        final name = state['name'];
                                        return DropdownMenuItem<int>(
                                          value: id,
                                          child: Text(name),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -21.0, 0.0),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 10,
                                    ),
                                  ),
                                  Text(
                                    "OR",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      indent: 10,
                                      endIndent: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -25.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text("Permission"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    child: DropdownButtonFormField<int>(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      value: permission,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: .5),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                      ),
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      hint: const Text(
                                        'Select the type',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 116, 116)),
                                      ),
                                      onChanged: (int? value) {
                                        setState(() {
                                          permission = value;
                                        });
                                      },
                                      items: _permissionValues
                                          .map<DropdownMenuItem<int>>(
                                              (dynamic state) {
                                        final id = state['value'];
                                        final name = state['name'];
                                        return DropdownMenuItem<int>(
                                          value: id,
                                          child: Text(name),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                transform: Matrix4.translationValues(
                                    -12.0, -16.0, 0.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: WidgetStateProperty
                                                .resolveWith<Color>(
                                              (Set<WidgetState> states) {
                                                if (states.contains(
                                                    WidgetState.selected)) {
                                                  return const Color(
                                                      0xFF6546D2);
                                                }
                                                return Colors.white;
                                              },
                                            ),
                                            value: sendMessage_Assignee,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                sendMessage_Assignee = value!;
                                              });
                                            }),
                                        const Text(
                                          "Send Message to Assignee",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, -7.0, 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: WidgetStateProperty
                                                  .resolveWith<Color>(
                                                (Set<WidgetState> states) {
                                                  if (states.contains(
                                                      WidgetState.selected)) {
                                                    return const Color(
                                                        0xFF6546D2);
                                                  }
                                                  return Colors.white;
                                                },
                                              ),
                                              value: sendEmail_Assignee,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  sendEmail_Assignee = value!;
                                                });
                                              }),
                                          const Text(
                                            "Send Email to Assignee",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, -15.0, 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: WidgetStateProperty
                                                  .resolveWith<Color>(
                                                (Set<WidgetState> states) {
                                                  if (states.contains(
                                                      WidgetState.selected)) {
                                                    return const Color(
                                                        0xFF6546D2);
                                                  }
                                                  return Colors.white;
                                                },
                                              ),
                                              value: stayOn,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  stayOn = value!;
                                                });
                                              }),
                                          const Text(
                                            "Stay on this list after submit",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, -21.0, 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: WidgetStateProperty
                                                  .resolveWith<Color>(
                                                (Set<WidgetState> states) {
                                                  if (states.contains(
                                                      WidgetState.selected)) {
                                                    return const Color(
                                                        0xFF6546D2);
                                                  }
                                                  return Colors.white;
                                                },
                                              ),
                                              value: sendMessage_Customer,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  sendMessage_Customer = value!;
                                                });
                                              }),
                                          const Text(
                                            "Send Message to Customer",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, -29.0, 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: WidgetStateProperty
                                                  .resolveWith<Color>(
                                                (Set<WidgetState> states) {
                                                  if (states.contains(
                                                      WidgetState.selected)) {
                                                    return const Color(
                                                        0xFF6546D2);
                                                  }
                                                  return Colors.white;
                                                },
                                              ),
                                              value: sendEmail_Customer,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  sendEmail_Customer = value!;
                                                });
                                              }),
                                          const Text(
                                            "Send Email to Customer",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              transform: Matrix4.translationValues(0, -25, 0),
                              child: Row(
                                children: [
                                  loading == true
                                      ? FilledButton(
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    const Color(0xff06C270)),
                                          ),
                                          onPressed: () {},
                                          child: LoadingAnimationWidget
                                              .fourRotatingDots(
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        )
                                      : FilledButton(
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    const Color(0xff06C270)),
                                          ),
                                          onPressed: () {
                                            submitTransferGroup();
                                          },
                                          child: const Text('Transfer')),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FilledButton(
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                const Color(0xffFF2929)),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/allContact");
                                      },
                                      child: const Text('Cancel')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ))
              ],
            )));
  }
}
