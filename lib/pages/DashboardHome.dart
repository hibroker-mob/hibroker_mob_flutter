import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum SampleItem {
  itemOne,
  itemTwo,
}

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DashboardHome> {
  String? typeValue;
  String? executiveValue;
  SampleItem? selectedItem;
  bool isShowAll = true;
  Map<String, dynamic> _dasboardData = {};
  List<Map<String, dynamic>> dashBoardCardArray = [];

  List<Map<String, dynamic>> dashBoardCardArray2 = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final int? USERID = prefs.getInt("USERID");
    print("Loaded token: $token");
     print("USERID: $USERID");
    if (token != null) {
      setState(() {
        fetchDashBoardData(token);
      });
    }
  }

  Future<void> fetchDashBoardData(token) async {
    final Url = Uri.parse('${Environment.apiUrl}api/dashboard-counts');

    try {
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Url, headers: headers);
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        setState(() {
          _dasboardData = dataResponse;
          updateDashboardCardArray();
          updateDashboardCardArray2();
        });
        print("Dashboard data: $_dasboardData");
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
    }
  }

  void updateDashboardCardArray() {
    dashBoardCardArray = [
      {
        'name': 'Total Leads',
        'value': _dasboardData["data"]["leads_total"],
        "icon": "assets/images/add2.png",
      },
      {
        'name': 'Total Requirement',
        'value': _dasboardData["data"]["requirements_total"],
        "icon": "assets/images/add2.png",
      },
      {
        'name': 'Total Site Visits',
        'value': _dasboardData["data"]["site_visits_total"],
        "icon": "assets/images/add2.png",
      },
      {
        'name': 'Total Tickets',
        'value': _dasboardData["data"]["tickets_total"],
        "icon": "assets/images/add2.png",
      },
      {
        'name': 'New Leads',
        'value': _dasboardData["data"]["leads_new"],
        "icon": "assets/images/bell.png"
      },
      {
        'name': 'New Requirement',
        'value': _dasboardData["data"]["requirements_new"],
        "icon": "assets/images/bell.png"
      },
      {
        'name': 'New Site Visits',
        'value': _dasboardData["data"]["site_visits_new"],
        "icon": "assets/images/bell.png"
      },
      {
        'name': 'New Tickets',
        'value': _dasboardData["data"]["tickets_pending"],
        "icon": "assets/images/bell.png"
      },
      {
        'name': 'In Progress Leads',
        'value': _dasboardData["data"]["leads_in_progress"],
        "icon": "assets/images/correct.png"
      },
      {
        'name': 'In Progress Requirements',
        'value': _dasboardData["data"]["requirements_in_progress"],
        "icon": "assets/images/correct.png"
      },
      {
        'name': 'In Progress Site Visits',
        'value': _dasboardData["data"]["site_visits_in_progress"],
        "icon": "assets/images/correct.png"
      },
      {
        'name': 'In Progress Tickets',
        'value': _dasboardData["data"]["tickets_in_progress"],
        "icon": "assets/images/correct.png"
      },
      {
        'name': 'Qualified Leads',
        'value': _dasboardData["data"]["leads_qualified"],
        "icon": "assets/images/correct2.png"
      },
      {
        'name': 'Served Requirements',
        'value': _dasboardData["data"]["requirements_served"],
        "icon": "assets/images/correct2.png"
      },
      {
        'name': 'Qualified Site Visits',
        'value': _dasboardData["data"]["site_visits_qualified"],
        "icon": "assets/images/correct2.png"
      },
      {
        'name': 'Closed Tickets',
        'value': _dasboardData["data"]["tickets_closed"],
        "icon": "assets/images/correct2.png"
      },
      {
        'name': 'Disqualified Leads',
        'value': _dasboardData["data"]["leads_disqualified"],
        "icon": "assets/images/cancel.png"
      },
      {
        'name': 'Unserved Requirements',
        'value': _dasboardData["data"]["requirements_unserved"],
        "icon": "assets/images/cancel.png"
      },
      {
        'name': 'Disqualified Site Visits',
        'value': _dasboardData["data"]["site_visits_disqualified"],
        "icon": "assets/images/cancel.png"
      },
      {
        'name': 'Cancelled Tickets',
        'value': _dasboardData["data"]["tickets_cancelled"],
        "icon": "assets/images/cancel.png"
      },
      {
        'name': 'All Vacants',
        'value': _dasboardData["data"]["total_vacant"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Vacant PMS',
        'value': _dasboardData["data"]["vacant_pms"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Vacant Brokerage',
        'value': _dasboardData["data"]["vacant_brokerage"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Selling',
        'value': _dasboardData["data"]["selling_properties"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Advance Booked',
        'value': _dasboardData["data"]["advance_booked"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Occupied PMS',
        'value': _dasboardData["data"]["occupied_pms"],
        "icon": "assets/images/user.png",
        "hasDot": true
      },
      {
        'name': 'Move Out Request',
        'value': _dasboardData["data"]["moveout_request"],
        "icon": "assets/images/arrow.png",
        "hasDot": true
      },
      {
        'name': 'Under Notice',
        'value': _dasboardData["data"]["under_notice"],
        "icon": "assets/images/error.png",
        "hasDot": true
      },
      {
        'name': 'Renewal Due',
        'value': _dasboardData["data"]["renewal_due"],
        "icon": "assets/images/eventStart.png",
        "hasDot": true
      },
      {
        'name': 'Renewal Expired',
        'value': _dasboardData["data"]["renewal_expired"],
        "icon": "assets/images/cancelEvent.png",
        "hasDot": true
      },
      {
        'name': 'Current Month Renewal',
        'value': _dasboardData["data"]["current_month_renewals"],
        "icon": "assets/images/renew.png",
        "hasDot": true
      },
      {
        'name': 'Last Month Renewal',
        'value': _dasboardData["data"]["last_month_renewals"],
        "icon": "assets/images/renew2.png",
        "hasDot": true
      },
      {
        'name': 'Next Month Renewal',
        'value': _dasboardData["data"]["next_month_renewals"],
        "icon": "assets/images/eventStart.png",
        "hasDot": true
      },
      {
        'name': 'Owner Key Request',
        'value': _dasboardData["data"]["key_request"],
        "icon": "assets/images/key.png",
        "hasDot": true
      },
      {
        'name': 'Inactive Properties',
        'value': _dasboardData["data"]["inactive_properties"],
        "icon": "assets/images/pause.png",
        "hasDot": true
      },
    ];
  }

  void updateDashboardCardArray2() {
    dashBoardCardArray2 = [
      {
        'name': 'All Vacants',
        'value': _dasboardData["data"]["total_vacant"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Vacant PMS',
        'value': _dasboardData["data"]["vacant_pms"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Vacant Brokerage',
        'value': _dasboardData["data"]["vacant_brokerage"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Selling',
        'value': _dasboardData["data"]["selling_properties"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Advance Booked',
        'value': _dasboardData["data"]["advance_booked"],
        "icon": "assets/images/house.png",
        "hasDot": true
      },
      {
        'name': 'Occupied PMS',
        'value': _dasboardData["data"]["occupied_pms"],
        "icon": "assets/images/user.png",
        "hasDot": true
      },
      {
        'name': 'Move Out Request',
        'value': _dasboardData["data"]["moveout_request"],
        "icon": "assets/images/arrow.png",
        "hasDot": true
      },
      {
        'name': 'Under Notice',
        'value': _dasboardData["data"]["under_notice"],
        "icon": "assets/images/error.png",
        "hasDot": true
      },
      {
        'name': 'Renewal Due',
        'value': _dasboardData["data"]["renewal_due"],
        "icon": "assets/images/eventStart.png",
        "hasDot": true
      },
      {
        'name': 'Renewal Expired',
        'value': _dasboardData["data"]["renewal_expired"],
        "icon": "assets/images/cancelEvent.png",
        "hasDot": true
      },
      {
        'name': 'Current Month Renewal',
        'value': _dasboardData["data"]["current_month_renewals"],
        "icon": "assets/images/renew.png",
        "hasDot": true
      },
      {
        'name': 'Last Month Renewal',
        'value': _dasboardData["data"]["last_month_renewals"],
        "icon": "assets/images/renew2.png",
        "hasDot": true
      },
      {
        'name': 'Next Month Renewal',
        'value': _dasboardData["data"]["next_month_renewals"],
        "icon": "assets/images/eventStart.png",
        "hasDot": true
      },
      {
        'name': 'Owner Key Request',
        'value': _dasboardData["data"]["key_request"],
        "icon": "assets/images/key.png",
        "hasDot": true
      },
      {
        'name': 'Inactive Properties',
        'value': _dasboardData["data"]["inactive_properties"],
        "icon": "assets/images/pause.png",
        "hasDot": true
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff8f7fd),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dashboard",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 27),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (isShowAll == true)
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowAll = false;
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "View Less",
                            style: TextStyle(fontSize: 13),
                          ),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.black,
                            size: 25,
                          )
                        ],
                      ))
                else
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowAll = true;
                      });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "View More",
                          style: TextStyle(fontSize: 13),
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                isShowAll == true
                    ? Column(
                        children: dashBoardCardArray.map((card) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.1, color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 18, 0, 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        card['value'].toString(),
                                        style: const TextStyle(fontSize: 27),
                                      ),
                                      Text(
                                        card['name'],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      card["hasDot"] == true
                                          ? Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      50.0, 0.0, 0.0),
                                              child: Image(
                                                image: AssetImage(card['icon']),
                                                width: 41,
                                                height: 41,
                                              ),
                                            )
                                          : Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      -22.0, 0.0, 0.0),
                                              child: Image(
                                                image: AssetImage(card['icon']),
                                                width: 41,
                                                height: 41,
                                              ),
                                            ),
                                      if (card["hasDot"] == true)
                                        Transform.translate(
                                          offset: const Offset(0.0, -20.0),
                                          child: PopupMenuButton<SampleItem>(
                                            padding: const EdgeInsets.fromLTRB(
                                                50, 0, 0, 0),
                                            color: Colors.white,
                                            initialValue: selectedItem,
                                            onSelected: (SampleItem item) {
                                              setState(() {
                                                selectedItem = item;
                                              });
                                            },
                                            itemBuilder: (BuildContext
                                                    context) =>
                                                <PopupMenuEntry<SampleItem>>[
                                              const PopupMenuItem<SampleItem>(
                                                value: SampleItem.itemOne,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.visibility,
                                                      color: Colors.black54,
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text('View'),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem<SampleItem>(
                                                value: SampleItem.itemTwo,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.download_sharp,
                                                      color: Colors.black54,
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text('Export'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : Column(
                        children: dashBoardCardArray2.map((card) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.1, color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 18, 0, 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        card['value'].toString(),
                                        style: const TextStyle(fontSize: 27),
                                      ),
                                      Text(
                                        card['name'],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      card["hasDot"] == true
                                          ? Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      50.0, 0.0, 0.0),
                                              child: Image(
                                                image: AssetImage(card['icon']),
                                                width: 41,
                                                height: 41,
                                              ),
                                            )
                                          : Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      -22.0, 0.0, 0.0),
                                              child: Image(
                                                image: AssetImage(card['icon']),
                                                width: 41,
                                                height: 41,
                                              ),
                                            ),
                                      if (card["hasDot"] == true)
                                        Transform.translate(
                                          offset: const Offset(0.0, -20.0),
                                          child: PopupMenuButton<SampleItem>(
                                            padding: const EdgeInsets.fromLTRB(
                                                50, 0, 0, 0),
                                            color: Colors.white,
                                            initialValue: selectedItem,
                                            onSelected: (SampleItem item) {
                                              setState(() {
                                                selectedItem = item;
                                              });
                                            },
                                            itemBuilder: (BuildContext
                                                    context) =>
                                                <PopupMenuEntry<SampleItem>>[
                                              const PopupMenuItem<SampleItem>(
                                                value: SampleItem.itemOne,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.visibility,
                                                      color: Colors.black54,
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text('View'),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem<SampleItem>(
                                                value: SampleItem.itemTwo,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.download_sharp,
                                                      color: Colors.black54,
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text('Export'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                const SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ));
  }
}
