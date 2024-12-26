import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactDetailsHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key});

  @override
  State<ContactDetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ContactDetails> {
  List<Map<String, String>> menuItems = [
    {"name": "Export", "value": "Export"},
    {"name": "Import", "value": "Import"},
    {"name": "Advanced Search", "value": "Advanced Search"},
    {"name": "Create Group", "value": "Create Group"},
    {"name": "Properties", "value": "Properties"},
    {"name": "Requirements", "value": "Requirements"},
    {"name": "Send Email", "value": "Send Email"},
    {"name": "Send SMS", "value": "Send SMS"},
    {"name": "Send Whatsapp", "value": "Send Whatsapp"},
    {"name": "Email T & C", "value": "Email T & C"},
  ];

  List<Map<String, String>> menuItems2 = [
    {'name': 'Lead', 'value': 'Lead'},
    {'name': 'Owner', 'value': 'Owner'},
    {'name': 'Tenant', 'value': 'Tenant'},
    {'name': 'Vendor', 'value': 'Vendor'},
  ];
  String isSelected = "home";
  bool _isExpanded = false;
  bool _isExpandedOtherPersonal = false;
  bool _isExpandedDocument = false;
  int? USERID;
  Map<String, dynamic> contact_details = {};

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  void fetchUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
    USERID = prefs.getInt("userId");
    print("USERID ${USERID}");
    if (USERID != null) {
      final url = Uri.parse(
          '${Environment.apiUrl}api/get-contact-details-by-id?db_name=${_dbName}');
      try {
        final response = await http.post(url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json"
            },
            body: jsonEncode({"contact_id": USERID}));
        if (response.statusCode == 201) {
          final dataResponse = jsonDecode(response.body);
          setState(() {
            contact_details = dataResponse["contact"];
            print("contact_details ${contact_details}");
          });
        }
      } catch (error) {
        print("Error: $error");
      }
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
            children: [
              const Contactdetailsheader(),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100, 15, 100, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(3)),
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: const Icon(
                                  Icons.block,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff00CFDE),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: const Icon(
                                  Icons.note,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffFF7A29),
                                    borderRadius: BorderRadius.circular(3)),
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: const Icon(
                                  Icons.autorenew_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/createLead");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff06C270),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 5, 15, 5),
                                      child: const Icon(
                                        Icons.share_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        "/createContact",
                                        arguments: {
                                          "USERID": USERID,
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff4B2DB9),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 5, 15, 5),
                                      child: const Icon(
                                        Icons.create_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${contact_details["firstname"] ?? ""}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      "+${contact_details['mobile_prefix'] ?? ''}-${contact_details['mobile'] ?? ''}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 21),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff2E2138),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: const Text(
                                    "Service Provider",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff2E2138),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: const Text(
                                    "Others",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff2E2138),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: const Text(
                                    "HOUSING",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(125, 10, 125, 0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_phone,
                            color: Color(0xff6546D2),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          const Icon(
                            Icons.email_sharp,
                            color: Color(0xff6546D2),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          const Icon(
                            Icons.search_sharp,
                            color: Color(0xff6546D2),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Image.asset(
                            "assets/images/whatsapp.png",
                            height: 21,
                            width: 25,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(width: .5, color: Colors.black)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 10, 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.local_phone,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "+${contact_details['mobile_prefix'] ?? ''}-${contact_details['mobile'] ?? ''}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xff565871),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email_sharp,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "${contact_details["email"]}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color(0xff565871),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${contact_details["branch"] != null ? contact_details["branch"]["branch_name"] : ""}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            const Text(
                                              "(Branch)",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_search,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${contact_details["contact_type"] != null ? contact_details["contact_type"]["contact_type"] : ""}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            const Text(
                                              "(Assign to)",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_sharp,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${contact_details["created_at"]}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            const Text(
                                              "(Assign date)",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.map_outlined,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${contact_details["remark"] ?? ""}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xff565871),
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "(Remark)",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.format_list_bulleted_outlined,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${contact_details["uin"] ?? ""}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            const Text(
                                              "(Unique number)",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.search,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${contact_details["keywords"] ?? ""}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            const Text(
                                              "(Keywords)",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpansionPanelList(
                      elevation: 1,
                      expandedHeaderPadding: EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          backgroundColor:
                              const Color.fromARGB(255, 245, 241, 241),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return const ListTile(
                              title: Text(
                                "Business Details",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                      width: .5, color: Colors.black)),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 10, 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.house_outlined,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${contact_details["company"] ?? ""}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff565871),
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Comapany Name)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.factory,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${contact_details["website"] ?? ""}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff565871),
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Business Domain)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.flag,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["business"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Business Type)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.business_center,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["designation"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Designation)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.public,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["website"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Website)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.fax,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["fax"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(FAX)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.map,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["bank_address"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Business Address)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_pin,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["bank_city"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(City)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.near_me_sharp,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["bank_locality"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Locality)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.fiber_pin,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["pincode"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Pincode)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .account_balance_wallet_outlined,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["ac_no"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Bank Account Name)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.account_balance,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["bank"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Bank Name)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.code_off_outlined,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["ifsc"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(IFSC)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: _isExpanded,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpansionPanelList(
                      elevation: 1,
                      expandedHeaderPadding: EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedOtherPersonal = !_isExpandedOtherPersonal;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          backgroundColor:
                              const Color.fromARGB(255, 245, 241, 241),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return const ListTile(
                              title: Text(
                                "Address and other personal details",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                      width: .5, color: Colors.black)),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 10, 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.map,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      "${contact_details["address"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    )),
                                                    const Text(
                                                      "(Address)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_pin,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["city"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(City)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.near_me_sharp,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["locality"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Locality)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.fiber_pin,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["pincode"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Pin)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.folder_open_sharp,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["folder"] != null ? contact_details["folder"]["folder_name"] : ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Folder)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.cake_outlined,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["dob"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Date Of Birth)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_month,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["anniversary"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Aniversary Date)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["updated_user"] != null ? contact_details["updated_user"]["name"] : ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Updated By)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.date_range,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["updated_at"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Updated Date)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.date_range_outlined,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["created_at"] ?? ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Created Date)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: Color(0xff565871),
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${contact_details["user"] != null ? contact_details["user"]["name"] : ""}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "(Created By)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: _isExpandedOtherPersonal,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpansionPanelList(
                      elevation: 1,
                      expandedHeaderPadding: EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedDocument = !_isExpandedDocument;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          backgroundColor:
                              const Color.fromARGB(255, 245, 241, 241),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return const ListTile(
                              title: Text(
                                "Documents",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            );
                          },
                          body: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                      width: .5, color: Colors.black)),
                              width: double.infinity,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 10, 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Agreement",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Bank Proof",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Aadhar Card",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "PAN Card",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Passport",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Driving Lisence",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Employee id",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Cancelled Cheque/Passbook",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Voter ID",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Other Document",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff565871),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: _isExpandedDocument,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
