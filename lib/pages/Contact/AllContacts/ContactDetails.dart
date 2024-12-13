import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = "home";
                          Navigator.pushNamed(context, "/allContact");
                        });
                      },
                      child: Icon(
                        size: 24,
                        Icons.arrow_back,
                        color: isSelected == "home"
                            ? const Color(0xff6546D2)
                            : Colors.black,
                      ),
                    )),
                  ),
                  Expanded(
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = "contact";
                        });
                      },
                      child: Icon(
                        size: 25,
                        Icons.history,
                        color: isSelected == "contact"
                            ? Colors.black
                            : Colors.black,
                      ),
                    )),
                  ),
                  Expanded(
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = "contact";
                        });
                      },
                      child: Icon(
                        size: 26,
                        Icons.edit_note,
                        color: isSelected == "contact"
                            ? const Color(0xff6546D2)
                            : Colors.black,
                      ),
                    )),
                  ),
                  Expanded(
                    child: Center(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = "menu";
                              });
                              showMenu(
                                color: Colors.white,
                                context: context,
                                position: const RelativeRect.fromLTRB(
                                    220, 150, 15, 0),
                                items: menuItems.map((item) {
                                  return PopupMenuItem(
                                    height: 35,
                                    value: item['value'],
                                    child: Text(
                                      item['name']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  );
                                }).toList(),
                              ).then((value) {
                                if (value != null) {
                                  if (value == "Export") {
                                    Navigator.pushNamed(
                                        context, "/exportContact");
                                  } else if (value == "Import") {
                                    Navigator.pushNamed(
                                        context, "/importContact");
                                  } else if (value == "Advanced Search") {
                                    Navigator.pushNamed(
                                        context, "/advanceSearch");
                                  } else if (value == "Create Group") {
                                    Navigator.pushNamed(
                                        context, "/createGroup");
                                  }
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  size: 19,
                                  Icons.format_list_bulleted_outlined,
                                  color: isSelected == "menu"
                                      ? const Color(0xff6546D2)
                                      : Colors.black,
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ))),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = "folder";
                            });
                            showMenu(
                                    color: Colors.white,
                                    context: context,
                                    position: const RelativeRect.fromLTRB(
                                        220, 150, 15, 0),
                                    items: menuItems2.map((item) {
                                      return PopupMenuItem(
                                        height: 35,
                                        value: item['value'],
                                        child: Text(
                                          item['name']!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                      );
                                    }).toList())
                                .then((value) {
                              if (value != null) {
                                print("Selected: $value");
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 20,
                                Icons.share_sharp,
                                color: isSelected == "folder"
                                    ? const Color(0xff6546D2)
                                    : Colors.black,
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
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
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff06C270),
                                        borderRadius: BorderRadius.circular(3)),
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: const Icon(
                                      Icons.share_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff4B2DB9),
                                        borderRadius: BorderRadius.circular(3)),
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: const Icon(
                                      Icons.create_sharp,
                                      color: Colors.white,
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
                    const Text(
                      "Arun Kumar Sharma",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                    const Text(
                      "91-9831713109",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 21),
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
                      child: const Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_phone,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "+91-9831713109",
                                        style: TextStyle(
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
                                      Icon(
                                        Icons.email_sharp,
                                        color: Color(0xff565871),
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "tamal.infosyst@gmail.com",
                                        style: TextStyle(
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
                                      Icon(
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
                                              "ALL EMPLOYEES",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            Text(
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
                                      Icon(
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
                                              "Developer",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            Text(
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
                                      Icon(
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
                                              "02 Sep 2024 08:30 PM",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            Text(
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
                                      Icon(
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
                                            Text(
                                              "residential",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            Text(
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
                                      Icon(
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
                                              "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            Text(
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
                                      Icon(
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
                                              "GM E City Town",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff565871),
                                              ),
                                            ),
                                            Text(
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
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 10, 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
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
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 10, 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
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
                                                      "Sealdah",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "Kolkata",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "Sonarpur",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "743330",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "res Tenant Leads",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "04 Sep 2024 11:39 AM",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "04 Sep 2024 11:39 AM",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
                                              Icon(
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
                                                      "Pavitra",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff565871),
                                                      ),
                                                    ),
                                                    Text(
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
