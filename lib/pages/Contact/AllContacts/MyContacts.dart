import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';

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
                              print("Searching....");
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
                                      const PopupMenuItem(
                                        height: 10,
                                        value: "Option 1",
                                        child: Text("Created Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      const PopupMenuItem(
                                        value: "Option 2",
                                        child: Text("Updated Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      const PopupMenuItem(
                                        height: 10,
                                        value: "Option 3",
                                        child: Text("Name",
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
                                      const PopupMenuItem(
                                        height: 10,
                                        value: "Option 1",
                                        child: Text(
                                          "Decending",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: "Option 2",
                                        child: Text("Ascending",
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
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/contactDetails");
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE6E4FD),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Arun Kumar Sharma",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "91-9831713109",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2)),
                                                ),
                                                Text("arun.infosyst@gmail.com",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Pavitra",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffAF7BF3)),
                                              ),
                                              Text(
                                                "Dec 04, 2024",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                              Text(
                                                "05:48 PM",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/contactDetails");
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFDFAFF),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Arun Kumar Sharma",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "91-9831713109",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2)),
                                                ),
                                                Text("arun.infosyst@gmail.com",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Pavitra",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffAF7BF3)),
                                              ),
                                              Text(
                                                "Dec 04, 2024",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                              Text(
                                                "05:48 PM",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/contactDetails");
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFDFAFF),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Arun Kumar Sharma",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "91-9831713109",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2)),
                                                ),
                                                Text("arun.infosyst@gmail.com",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Pavitra",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffAF7BF3)),
                                              ),
                                              Text(
                                                "Dec 04, 2024",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                              Text(
                                                "05:48 PM",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/contactDetails");
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFDFAFF),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Arun Kumar Sharma",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "91-9831713109",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2)),
                                                ),
                                                Text("arun.infosyst@gmail.com",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Pavitra",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffAF7BF3)),
                                              ),
                                              Text(
                                                "Dec 04, 2024",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                              Text(
                                                "05:48 PM",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/contactDetails");
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFDFAFF),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Arun Kumar Sharma",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "91-9831713109",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2)),
                                                ),
                                                Text("arun.infosyst@gmail.com",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6546D2),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Pavitra",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffAF7BF3)),
                                              ),
                                              Text(
                                                "Dec 04, 2024",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                              Text(
                                                "05:48 PM",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 145, 143, 143)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))))
                ],
              ),
            )));
  }
}
