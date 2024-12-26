import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TransferContactList extends StatefulWidget {
  const TransferContactList({super.key});

  @override
  State<TransferContactList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TransferContactList> {
  String isSelected = "home";
  List<dynamic> contacts = [];
  int _offset = 0;
  final int _limit = 50;
  bool _isLoading = false;
  List<dynamic> filterContacts = [];
  String? sortBy;
  int? selectedContact;
  bool _isFolder = false;
  int? _currentFolderId;
  int? totalContacts;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int? selectedContactId;
  List<dynamic> _selectedContacts = [];
  Map<int, bool> isUserCheckedMap = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPage();
    });
  }

  void setArrayContactList(List<String> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('contactList', data);
  }

  void _fetchPage() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
    final url = Uri.parse(
        '${Environment.apiUrl}api/get/contactlist/data?db_name=${_dbName}');

    try {
      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"offset": _offset, "limit": _limit}));
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        setState(() {
          totalContacts = dataResponse["totalContacts"];
        });
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

  void _showAllData() async {
    String query = _searchController.text.toLowerCase();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final String? _dbName = prefs.getString('dbName');
    final url = Uri.parse('${Environment.apiUrl}api/get/contactlist/by/search');

    setState(() {
      _isLoading = true;
    });

    if (query.isEmpty) {
      filterContacts = (contacts);
      setState(() {
        _offset = 0;
      });
    }
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
            {"offset": _offset, "normal_search": query, "db_name": _dbName}),
      );
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        setState(() {
          totalContacts = dataResponse["totalContacts"];
        });
        List<dynamic> newContacts = dataResponse["contacts"];
        print("My Contacts ${dataResponse["contacts"]}");

        setState(() {
          filterContacts = (newContacts);
          _offset += _limit;
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to fetch search results");
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        _isLoading = false;
        filterContacts = [];
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
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
                              setState(() {
                                _offset = 0;
                              });
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "All Contact's",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "Total Records: ${totalContacts}",
                                style: const TextStyle(fontSize: 12),
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
                                        195, 295, 105, 0),
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
                                        onTap: () {},
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
                                        onTap: () {},
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
                      padding: const EdgeInsets.all(5),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ...filterContacts.map((res) {
                              return GestureDetector(
                                onTap: () {
                                  setUserId(res["id"]);
                                  selectedContact = res["id"];
                                  Navigator.pushNamed(
                                      context, "/contactDetails");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: selectedContact == res["id"]
                                        ? const Color(0xffE6E4FD)
                                        : const Color(0xffFDFAFF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        child: Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          checkColor: Colors.white,
                                          fillColor: WidgetStateProperty
                                              .resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                              return states.contains(
                                                      WidgetState.selected)
                                                  ? const Color(0xFF6546D2)
                                                  : Colors.white;
                                            },
                                          ),
                                          value: isUserCheckedMap[res["id"]] ??
                                              false,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (isUserCheckedMap[res['id']] ==
                                                  true) {
                                                isUserCheckedMap[res['id']] =
                                                    false;
                                                _selectedContacts
                                                    .remove(res['id']);
                                              } else {
                                                isUserCheckedMap[res['id']] =
                                                    true;
                                                _selectedContacts
                                                    .add(res['id']);
                                                selectedContact = res['id'];
                                              }

                                              setArrayContactList(
                                                  _selectedContacts
                                                      .map((e) => e.toString())
                                                      .toList());

                                              print(
                                                  "_selectedContacts $_selectedContacts");
                                            });
                                          },
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
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
                                      ),

                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              res['firstname'].length > 20
                                                  ? res['firstname']
                                                          .substring(0, 20) +
                                                      "..."
                                                  : res['firstname'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "${res["mobile_prefix"] ?? ""}-${res['mobile'] ?? "N/A"}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xff6546D2),
                                              ),
                                            ),
                                            Text(
                                              res['email'] != null &&
                                                      res['email'].length > 25
                                                  ? res['email']
                                                          .substring(0, 25) +
                                                      "..."
                                                  : res["email"] ?? "N/A",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xff6546D2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Date Section
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              res['user']?["name"] ?? "N/A",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffAF7BF3),
                                              ),
                                            ),
                                            Text(
                                              DateFormat("d MMM yyyy").format(
                                                DateFormat("d MMM yyyy hh:mm a")
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
                                                DateFormat("d MMM yyyy hh:mm a")
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
