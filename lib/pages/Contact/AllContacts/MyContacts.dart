import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MyContacts extends StatefulWidget {
  const MyContacts({super.key});

  @override
  State<MyContacts> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyContacts> {
  List<Map<String, String>> menuItems = [
    {'name': 'Buyer leads', 'value': 'Buyer leads'},
    {'name': 'Res Tenant leads', 'value': 'Res Tenant leads'},
    {'name': 'Com Tenant leads', 'value': 'Com Tenant leads'},
    {'name': 'PMS Owner Leads', 'value': 'PMS Owner leads'},
    {'name': 'Brokerage Owner Leads', 'value': 'Brokerage Owner leads'},
    {'name': 'Owner Agreement', 'value': 'Owner Agreement'},
    {'name': 'Tenant Agreement', 'value': 'Tenant agreement'},
    {'name': 'Interview', 'value': 'Interview'},
    {'name': 'Commercial Owner Leads', 'value': 'Commercial Owner leads'},
    {'name': 'Commercial', 'value': 'Commercial'},
    {'name': 'HIBROKER', 'value': 'HIBROKER'},
    {'name': 'Employee', 'value': 'Employee'},
    {'name': 'Bangalore Realtors', 'value': 'Bangalore Realtors'},
    {'name': 'Owner Number', 'value': 'Owner Number'},
    {'name': 'Owner Lead', 'value': 'Owner lead'},
    {'name': 'PMS', 'value': 'PMS'},
    {'name': 'Tenant Lead', 'value': 'Tenant lead'},
    {'name': 'HR', 'value': 'HR'},
  ];

  List<Map<String, String>> menuItems2 = [
    {'name': 'Export', 'value': 'Export'},
    {'name': 'Import', 'value': 'Import'},
    {'name': 'Advanced Search', 'value': 'Advanced Search'},
    {'name': 'Create Group', 'value': 'Create Group'},
    {'name': 'Videos', 'value': 'Videos'},
  ];

  String isSelected = "home";
  List<dynamic> contacts = [];
  int _offset = 0;
  final int _limit = 50;
  bool _isLoading = false;
  List<dynamic> filterContacts = [];
  String? sortBy;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchPage();
  }

  void _fetchPage() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final url = Uri.parse('${Environment.apiUrl}api/get/contactlist/data');

    try {
      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"offset": _offset, "limit": _limit}));
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        List<dynamic> newContacts = dataResponse["contacts"];

        setState(() {
          contacts.addAll(newContacts);
          filterContacts.addAll(newContacts);
          _offset += _limit;
          _isLoading = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _fetchPage();
    }
  }

  void setUserId(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  void _showAllData() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filterContacts = List.from(contacts);
      } else {
        filterContacts = contacts.where((contact) {
          String firstname = (contact['firstname'] ?? '').toLowerCase();
          String mobile = (contact['mobile'] ?? '').toLowerCase();
          return firstname.contains(query) || mobile.contains(query);
        }).toList();
      }
    });
  }

  void _sortContacts({required String field, required bool ascending}) {
    setState(() {
      filterContacts.sort((a, b) {
        var valueA = a[field] ?? '';
        var valueB = b[field] ?? '';

        if (valueA is String && valueB is String) {
          return ascending
              ? valueA.toLowerCase().compareTo(valueB.toLowerCase())
              : valueB.toLowerCase().compareTo(valueA.toLowerCase());
        } else if (valueA is num && valueB is num) {
          return ascending
              ? valueA.compareTo(valueB)
              : valueB.compareTo(valueA);
        }
        return 0;
      });
    });
  }

  void _sortContactsDate({required String field, required bool ascending}) {
    setState(() {
      filterContacts.sort((a, b) {
        var valueA = a[field];
        var valueB = b[field];

        var dateFormat = DateFormat('yyyy-MMM-dd hh:mm a');

        DateTime? dateA = valueA != null ? dateFormat.parse(valueA) : null;
        DateTime? dateB = valueB != null ? dateFormat.parse(valueB) : null;

        if (dateA != null && dateB != null) {
          return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
        }

        return 0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Container(
            color: Colors.white,
            child: Padding(
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
                            });
                          },
                          child: Icon(
                            size: 24,
                            Icons.home,
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
                            Navigator.pushNamed(context, "/createContact");
                          },
                          child: Icon(
                            size: 25,
                            Icons.add,
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
                                  isSelected = "folder";
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
                                    size: 21,
                                    Icons.folder,
                                    color: isSelected == "folder"
                                        ? const Color(0xff6546D2)
                                        : Colors.black,
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              )),
                        ),
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
                                      size: 21,
                                      Icons.format_list_bulleted_outlined,
                                      color: isSelected == "menu"
                                          ? const Color(0xff6546D2)
                                          : Colors.black,
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ))),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Color(0xff6546d2), width: 1)),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: Color(0xff6546d2), width: 1),
                          ),
                          hintText: 'Search...',
                          hintStyle: const TextStyle(fontSize: 14),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              print("Hello");
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _showAllData();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Color(0xff6546d2),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: const Text(
                                  "Search",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          )),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "All Contact's",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "Total Records: 862",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color(0xff6546d2)),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  minimumSize: WidgetStateProperty.all(
                                      const Size(10, 0)),
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 7)),
                                ),
                                onPressed: () {
                                  showMenu(
                                    color: Colors.white,
                                    context: context,
                                    position: const RelativeRect.fromLTRB(
                                        195, 285, 105, 0),
                                    items: [
                                      PopupMenuItem(
                                        onTap: () {
                                          sortBy = "createdAt";
                                        },
                                        height: 10,
                                        value: "Option 1",
                                        child: const Text("Created Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          sortBy = "updatedAt";
                                        },
                                        value: "Option 2",
                                        child: const Text("Updated Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          sortBy = "name";
                                        },
                                        height: 10,
                                        value: "Option 3",
                                        child: const Text("Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  ).then((value) {
                                    if (value != null) {
                                      print("Selected: $value");
                                    }
                                  });
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Sort By'),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FilledButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color(0xff6546d2)),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  minimumSize: WidgetStateProperty.all(
                                      const Size(10, 0)),
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 7)),
                                ),
                                onPressed: () {
                                  showMenu(
                                    color: Colors.white,
                                    context: context,
                                    position: const RelativeRect.fromLTRB(
                                        300, 288, 0, 0),
                                    items: [
                                      PopupMenuItem(
                                        onTap: () {
                                          if (sortBy == "name") {
                                            _sortContacts(
                                                field: 'firstname',
                                                ascending: false);
                                          } else {
                                            _sortContactsDate(
                                                field: sortBy == "createdAt"
                                                    ? "created_at"
                                                    : "updated_at",
                                                ascending: false);
                                          }
                                        },
                                        height: 10,
                                        value: "Option 1",
                                        child: const Text(
                                          "Decending",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        height: 45,
                                        onTap: () {
                                          if (sortBy == "name") {
                                            _sortContacts(
                                                field: 'firstname',
                                                ascending: true);
                                          } else {
                                            _sortContactsDate(
                                                field: sortBy == "createdAt"
                                                    ? "created_at"
                                                    : "updated_at",
                                                ascending: true);
                                          }
                                        },
                                        value: "Option 2",
                                        child: const Text("Ascending",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  ).then((value) {
                                    if (value != null) {
                                      print("Selected: $value");
                                    }
                                  });
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Order By'),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ...filterContacts.map((res) {
                              return GestureDetector(
                                onTap: () {
                                  setUserId(res["id"]);
                                  Navigator.pushNamed(
                                      context, "/contactDetails");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFDFAFF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Container(
                                              width: 55,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/user_avatar.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              print('Image icon pressed');
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  res['firstname'].length > 20
                                                      ? res['firstname']
                                                              .substring(
                                                                  0, 20) +
                                                          "..."
                                                      : res['firstname'],
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  (res["mobile_prefix"] ?? "") +
                                                      "-" +
                                                      (res['mobile'] ?? "N/A"),
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff6546D2),
                                                  ),
                                                ),
                                                Text(
                                                  res['email'] != null
                                                      ? res['email'].length > 25
                                                          ? res['email']
                                                                  .substring(
                                                                      0, 25) +
                                                              "..."
                                                          : res["email"]
                                                      : "N/A",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff6546D2),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                res['user'] != null
                                                    ? res['user']["name"]
                                                    : "N/A",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffAF7BF3),
                                                ),
                                              ),
                                              Text(
                                                DateFormat("d MMM yyyy").format(
                                                  DateFormat(
                                                          "d MMM yyyy hh:mm a")
                                                      .parse(
                                                          res["created_atnew"]),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color.fromARGB(
                                                      255, 145, 143, 143),
                                                ),
                                              ),
                                              Text(
                                                DateFormat("hh:mm a").format(
                                                  DateFormat(
                                                          "d MMM yyyy hh:mm a")
                                                      .parse(
                                                          res["created_atnew"]),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color.fromARGB(
                                                      255, 145, 143, 143),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            if (_isLoading)
                              Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                  color: const Color(0xff6546D2),
                                  size: 35,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
