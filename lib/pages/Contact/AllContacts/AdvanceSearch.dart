import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdvanceSchedule extends StatefulWidget {
  const AdvanceSchedule({super.key});

  @override
  State<AdvanceSchedule> createState() => _MyWidgetState();
}

final TextEditingController _dobController = TextEditingController();
final TextEditingController _aniversaryController = TextEditingController();
final TextEditingController _keyWordController = TextEditingController();
final TextEditingController _searchController = TextEditingController();
final TextEditingController _localityController = TextEditingController();
final TextEditingController _prosDateFrom = TextEditingController();
final TextEditingController _prosDateTo = TextEditingController();
final TextEditingController _createdDateFrom = TextEditingController();
final TextEditingController _createdDateTo = TextEditingController();

class _MyWidgetState extends State<AdvanceSchedule> {
  final List<Map<String, dynamic>> _permissions = [
    {'name': 'Private', 'value': 1},
    {'name': 'Branch', 'value': 2},
  ];
  List<dynamic> _sources = [];
  List<dynamic> _branches = [];
  List<dynamic> _assignees = [];
  List<dynamic> _customerTypes = [];
  List<dynamic> _contactTypes = [];
  List<dynamic> cities = [];
  List<dynamic> localities = [];
  int? sourceValue;
  int? branchValue;
  int? assigneeValue;
  int? customerType;
  int? contactType;
  int? permissionValue;
  String? keyword = _keyWordController.text.trim();
  String? myCity;
  String? myLocality;

  @override
  void initState() {
    super.initState();
    fetchFolders();
    fetchBranches();
    fetchAssignes();
    fetchCustomerTypes();
  }

  void setSource(int source) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('source', source);
  }

  void setBranch(int branch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('branch', branch);
  }

  void setAssignee(int assignee) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('assignee', assignee);
  }

  void setPermission(int permission) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('permission', permission);
  }

  void setCustomerType(int customerType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('customerType', customerType);
  }

  void setContactType(int contactType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('contactType', contactType);
  }

  void setKeyword(String keyword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('keyword', keyword);
  }

  void setCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
  }

  void setLocality(String locality) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locality', locality);
  }

  void setIsAdvSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdvSearch', true);
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
          _sources = dataResponse["data"]["sources"];
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchBranches() async {
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

  void fetchAssignes() async {
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

  void fetchCustomerTypes() async {
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
          _customerTypes = dataResponse["data"]["customerTypes"];
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchContactTypes(id, _dbName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final url = Uri.parse(
        '${Environment.apiUrl}api/contacttype/$id?db_name=${_dbName}');
    print("url ${url}");
    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer ${token}",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);

        setState(() {
          _contactTypes = dataResponse["data"];
          print("Contact Types ${dataResponse["data"]}");
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchCities(search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        '${Environment.apiUrl}api/get-location?input=${search}&type=locality');
    final String? token = prefs.getString('MY_TOKEN');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          cities = dataResponse["data"];
          print("Cities ${dataResponse["data"]}");
          showSearchableList();
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchLocalities(search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        '${Environment.apiUrl}api/get-location?input=${search}&type=locality&city=${_searchController.text}');
    final String? token = prefs.getString('MY_TOKEN');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          localities = dataResponse["data"];
          print("localities ${dataResponse["data"]}");
          showSearchableLocalityList();
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void showSearchableList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(26.0, 10, 26.0, 26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              if (cities.length > 0)
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cities[index]["text"],
                        style: const TextStyle(fontSize: 13),
                      ),
                      onTap: () {
                        setState(() {
                          _searchController.text = cities[index]["text"];
                          myCity = cities[index]["text"];
                          setCity(cities[index]["text"]);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 0.5,
                    );
                  },
                )
              else
                Column(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      width: double.infinity,
                      height: 150,
                    ),
                    const Text(
                      "Opps!! No location found",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red),
                    )
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  void showSearchableLocalityList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(26.0, 10, 26.0, 26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              if (localities.length > 0)
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: localities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        localities[index]["text"],
                        style: const TextStyle(fontSize: 13),
                      ),
                      onTap: () {
                        setState(() {
                          _localityController.text = localities[index]["text"];
                          myLocality = localities[index]["text"];
                          setLocality(localities[index]["text"]);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 0.5,
                    );
                  },
                )
              else
                Column(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      width: double.infinity,
                      height: 150,
                    ),
                    const Text(
                      "Opps!! No location found",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red),
                    )
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectProsDateFrom(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff6546D2),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff6546D2),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _prosDateFrom.text = "${pickedDate.toLocal()}".split(' ')[0];
        print("${pickedDate.toLocal()}");
      });
    }
  }

  Future<void> _selectProsDateTo(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff6546D2),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff6546D2),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _prosDateTo.text = "${pickedDate.toLocal()}".split(' ')[0];
        print("${pickedDate.toLocal()}");
      });
    }
  }

  Future<void> _selectCreatedDateFrom(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff6546D2),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff6546D2),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _createdDateFrom.text = "${pickedDate.toLocal()}".split(' ')[0];
        print("${pickedDate.toLocal()}");
      });
    }
  }

  Future<void> _selectCreatedDateTo(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff6546D2),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff6546D2),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _createdDateTo.text = "${pickedDate.toLocal()}".split(' ')[0];
        print("${pickedDate.toLocal()}");
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
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Advanced Search",
                            style: TextStyle(
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationThickness: 1.4),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Source"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<int>(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select the source',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  sourceValue = value;
                                  setSource(value!);
                                  print("Source ${value}");
                                });
                              },
                              items: _sources
                                  .map<DropdownMenuItem<int>>((dynamic state) {
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
                            height: 15,
                          ),
                          const Text("Branch"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<int>(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select the branch',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  branchValue = value;
                                  setBranch(value!);
                                  print("branch ${value}");
                                });
                              },
                              items: _branches
                                  .map<DropdownMenuItem<int>>((dynamic state) {
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
                            height: 15,
                          ),
                          const Text("Assign to"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<int>(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select the user',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  assigneeValue = value;
                                  setAssignee(value!);
                                  print("assignee ${value}");
                                });
                              },
                              items: _assignees
                                  .map<DropdownMenuItem<int>>((dynamic state) {
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
                            height: 15,
                          ),
                          const Text("Submitted by"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<int>(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select the user',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  assigneeValue = value;
                                  setAssignee(value!);
                                  print("assignee ${value}");
                                });
                              },
                              items: _assignees
                                  .map<DropdownMenuItem<int>>((dynamic state) {
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
                            height: 15,
                          ),
                          const Text("Permission"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<int>(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select the type',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  permissionValue = value;
                                  setPermission(value!);
                                  print("permisiion ${value}");
                                });
                              },
                              items: _permissions
                                  .map<DropdownMenuItem<int>>((dynamic state) {
                                final id = state['value'];
                                final name = state['name'];
                                return DropdownMenuItem<int>(
                                  value: id,
                                  child: Text(name),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Customer Type"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<int>(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select customer type',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (int? value) async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                final String? _dbName =
                                    prefs.getString('dbName');
                                await prefs.remove('contactType');
                                setState(() {
                                  customerType = value;
                                  print("customer ${value}");
                                  setCustomerType(value!);
                                  fetchContactTypes(value, _dbName);
                                });
                              },
                              items: _customerTypes
                                  .map<DropdownMenuItem<int>>((dynamic state) {
                                final id = state['id'];
                                final name = state['customer_type'];
                                return DropdownMenuItem<int>(
                                  value: id,
                                  child: Text(name),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Contact Type"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<int>(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select contact type',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  contactType = value;
                                  setContactType(value!);
                                  print("contact ${value}");
                                });
                              },
                              items: _contactTypes
                                  .map<DropdownMenuItem<int>>((dynamic state) {
                                final id = state['id'];
                                final name = state['contact_type'];
                                return DropdownMenuItem<int>(
                                  value: id,
                                  child: Text(name),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Prospective Date From"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _aniversaryController,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                hintText: "yyyy-mm-dd",
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.black54),
                                  onPressed: () {
                                    _selectProsDateFrom(context);
                                  },
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Prospective Date To"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _dobController,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                hintText: "yyyy-mm-dd",
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.black54),
                                  onPressed: () {
                                    _selectProsDateTo(context);
                                  },
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                hintText: 'Enter Keywords',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 128, 124, 124),
                                    fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                              onChanged: (value) {
                                setKeyword(value);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("City"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              style: const TextStyle(fontSize: 14),
                              controller: _searchController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Color(0xff6546d2), width: 1)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5),
                                  ),
                                  hintText: 'Search...',
                                  hintStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      fetchCities(
                                          _searchController.text.toLowerCase());
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Color(0xff6546d2),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
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
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Locality"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              style: const TextStyle(fontSize: 14),
                              controller: _localityController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Color(0xff6546d2), width: 1)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5),
                                  ),
                                  hintText: 'Search...',
                                  hintStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      fetchLocalities(_localityController.text
                                          .toLowerCase());
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Color(0xff6546d2),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
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
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Created Date From"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _aniversaryController,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                hintText: "yyyy-mm-dd",
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.black54),
                                  onPressed: () {
                                    _selectCreatedDateFrom(context);
                                  },
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Created Date To"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _dobController,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                hintText: "yyyy-mm-dd",
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.black54),
                                  onPressed: () {
                                    _selectCreatedDateTo(context);
                                  },
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FilledButton(
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            const Color(0xff06C270)),
                                  ),
                                  onPressed: () {
                                    setIsAdvSearch();
                                    Navigator.pushNamed(context, "/allContact",
                                        arguments: {
                                          "source": sourceValue,
                                          "branch": branchValue,
                                          "assignTo": assigneeValue,
                                          "permission": permissionValue,
                                          "customerType": customerType,
                                          "contactType": contactType,
                                          "keyword": _keyWordController.text,
                                          "city": _searchController.text,
                                          "locality": _localityController.text,
                                          "prosDateFrom": _prosDateFrom.text,
                                          "prosDateTo": _prosDateTo.text,
                                          "createdDateFrom":
                                              _createdDateFrom.text,
                                          "createdDateTo": _createdDateTo.text
                                        });
                                  },
                                  child: const Text('Search')),
                              const SizedBox(
                                width: 5,
                              ),
                              FilledButton(
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            const Color(0xffFF2929)),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/allContact");
                                  },
                                  child: const Text('Cancel')),
                            ],
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
