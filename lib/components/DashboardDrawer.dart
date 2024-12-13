import 'package:flutter/material.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DashboardDrawer> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 255,
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Home",
              style: TextStyle(color: Color(0xff555770)),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  const Icon(
                    Icons.dashboard_outlined,
                    color: Color(0xff8C91B6),
                    size: 20.0,
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Dashboard',
                        style:
                            TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/dashboardHome");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
            child: Text(
              "Data Management",
              style: TextStyle(color: Color(0xff555770)),
            ),
          ),
          Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                cardColor: Colors.transparent,
              ),
              child: ExpansionTile(
                childrenPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.supervisor_account_outlined,
                  color: Color(0xff8C91B6),
                ),
                title: const Text(
                  'Contact',
                  style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                ),
                trailing: _isExpanded
                    ? const Icon(Icons.arrow_drop_down,
                        color: Color(0xff8C91B6))
                    : const Icon(Icons.arrow_drop_up_outlined,
                        color: Color(0xff8C91B6)),
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _isExpanded = expanded;
                  });
                },
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F7FD),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                              transform:
                                  Matrix4.translationValues(0.0, 10.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person_add_alt_1_outlined,
                                      color: Color.fromARGB(255, 3, 3, 3),
                                      size: 20.0,
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: const Text(
                                          'CREATE CONTACTS',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                              fontSize: 13),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, "/createContact");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.contacts_outlined,
                                  color: Color.fromARGB(255, 3, 3, 3),
                                  size: 20.0,
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text(
                                      'ALL CONTACTS',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 3, 3, 3),
                                          fontSize: 13),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, "/allContact");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -10.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.local_phone_outlined,
                                    color: Color.fromARGB(255, 3, 3, 3),
                                    size: 20.0,
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        'COLD CALLS',
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 3, 3, 3),
                                            fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, "/coldCalls");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Container(
            transform: Matrix4.translationValues(0, -5, 0),
            child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  cardColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.call,
                    color: Color(0xff8C91B6),
                    size: 22,
                  ),
                  title: const Text(
                    'Call Recording',
                    style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                  ),
                  trailing: _isExpanded
                      ? const Icon(Icons.arrow_drop_down,
                          color: Color(0xff8C91B6))
                      : const Icon(Icons.arrow_drop_up_outlined,
                          color: Color(0xff8C91B6)),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _isExpanded = expanded;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F7FD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, 5.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.wifi_calling_3_outlined,
                                      color: _isExpanded
                                          ? const Color.fromARGB(255, 3, 3, 3)
                                          : const Color(0xff8C91B6),
                                      size: 20.0,
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          "CALL LOGS",
                                          style: TextStyle(
                                              color: _isExpanded
                                                  ? const Color.fromARGB(
                                                      255, 3, 3, 3)
                                                  : const Color(0xff8C91B6),
                                              fontSize: 12.9),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, "/callLogs");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -4.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.spatial_audio_off_outlined,
                                      color: _isExpanded
                                          ? const Color.fromARGB(255, 3, 3, 3)
                                          : const Color(0xff8C91B6),
                                      size: 20.0,
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          "RECORDINGS",
                                          style: TextStyle(
                                              color: _isExpanded
                                                  ? const Color.fromARGB(
                                                      255, 3, 3, 3)
                                                  : const Color(0xff8C91B6),
                                              fontSize: 12.9),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, "/recordings");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.signpost_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Lead',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_add_alt_1_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'CREATE LEAD',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.supervisor_account_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 22.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            ' ALL LEADS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.domain_verification,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MY LEADS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'TODAY FOLLOWUP',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -14.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'OPEN',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -20.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'BACKLOG',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -27.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.query_builder,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'RETENTION',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -8.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.wysiwyg,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Requirements',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'CREATE',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            ' ALL REQUIREMENTS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MY REQUIREMENTS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'TODAY FOLLOWUP',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -14.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'OPEN',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -20.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'BACKLOG',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -8.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.web_sharp,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Sites Visits',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'SCHEDULE VISIT',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            ' ALL VISITS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MY VISITS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'REQUESTED VISITS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -14.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'TODAY VISITS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -20.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'ACCEPTED VISITS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'REJECTED VISITS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'BACKLOG VISITS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.home_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Property',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'CREATE PROPERTY',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'BACKLOG',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'PENDING PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'TODAY FOLLOWUP',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -14.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MY PROPERTIES',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -17.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'AVAILABLE PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'ALL PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'SALE PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'LEASED PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'INACTIVE PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'REJECTED PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.document_scanner_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Documents',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'CREATE',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'GENERAL DOCS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'CUSTOMER DOCS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'GENERAL DEL DOCS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -14.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'CUSTOM DEL DOCS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.newspaper,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Agreements',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 4.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "OWNER'S AGREEMENTS",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -3.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            "TENANT'S AGREEMENTS",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.newspaper,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Inspections',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 2.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "LIST",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.home_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'PMS',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'VACANT PMS',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'OCCUPIED',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MOVEOUT REQUEST',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'UNDER NOTICE',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -14.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'OWNER KEY REQUEST',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -17.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'RENEWAL DUE',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'RENEWAL EXPIRED',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_reset,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 21.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'INACTIVE PROPERTY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -12.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.broken_image,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Brokerage',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 4.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "VACANT PROPERTY",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -3.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            "OCCUPIED",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
            child: Text(
              "Users",
              style: TextStyle(color: Color(0xff555770)),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.supervised_user_circle_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Buyer/Tenant',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 15.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'ALL TENANT',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 6.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'PENDING TENANT',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'VERIFIED TENANT',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'REJECTED TENANT',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.person_outline,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Owner',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 15.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'ALL OWNER',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 6.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'PENDING OWNER',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'VERIFIED OWNER',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'REJECTED OWNER',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.question_answer_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Tickets',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 17.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'RAISE TICKET',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'ALL TICKETS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'PENDING TICKETS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -5.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'IN PROGRESS TICKET',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -12.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'CLOSED TICKET',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -18.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MY TICKET',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
            child: Text(
              "Billing",
              style: TextStyle(color: Color(0xff555770)),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.payments_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Invoice',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 15.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'CREATE INVOICE',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 6.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MANAGE INVOICE',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MANAGE RECURRING INVOICE',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'MANAGE VENDOR',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -1.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.assignment_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'E-Stamp',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 15.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'CREATE E-STAMP',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'CREATE E-SIGN',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'E-STAMP LIST',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'WALLET HISTORY',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 7, 0, 5),
            child: Text(
              "Communication",
              style: TextStyle(color: Color(0xff555770)),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, 5.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.content_paste_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Templete',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 2.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "ALL TEMPLETES",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.wechat_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Communication',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 2.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "MAIL BOX",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Container(
              transform: Matrix4.translationValues(0.0, -2.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.spatial_audio_off_outlined,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Campaign',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 6.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.supervisor_account_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "ALL GROUP",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -3.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.spatial_audio_off_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "ALL CAMPAIGN",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 7, 0, 5),
            child: Text(
              "User Management",
              style: TextStyle(color: Color(0xff555770)),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, 5.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.person_outline,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'User Management',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "USER LIST",
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 12.9),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
            child: Text(
              "Control Panel",
              style: TextStyle(color: Color(0xff555770)),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, 5.0, 0.0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    cardColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.settings,
                      color: Color(0xff8C91B6),
                    ),
                    title: const Text(
                      'Setup',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    trailing: _isExpanded
                        ? const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8C91B6))
                        : const Icon(Icons.arrow_drop_up_outlined,
                            color: Color(0xff8C91B6)),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _isExpanded = expanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F7FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 17.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_to_photos_outlined,
                                        color: _isExpanded
                                            ? const Color.fromARGB(255, 3, 3, 3)
                                            : const Color(0xff8C91B6),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'DEMO VIDEOS',
                                            style: TextStyle(
                                                color: _isExpanded
                                                    ? const Color.fromARGB(
                                                        255, 3, 3, 3)
                                                    : const Color(0xff8C91B6),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 7.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'PERMISSION ACCESS',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, 1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 23,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'SCHEMES',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -5.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'FAQ',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -12.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'PROPERTY CONTENT',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -15.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'REAL ESTATE CRM CONTENT',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -13.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.folder_outlined,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'WHATSAPP MESSAGE',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Color(0xff8C91B6),
                  size: 20.0,
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Configuration',
                      style: TextStyle(color: Color(0xff8C91B6), fontSize: 14),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
