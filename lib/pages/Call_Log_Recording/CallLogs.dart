import 'package:flutter/material.dart';
import 'package:call_e_log/call_log.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({super.key});

  @override
  State<CallLogs> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CallLogs> {
  final TextEditingController _controller = TextEditingController();
  List<CallLogEntry> _callLogs = [];
  List<CallLogEntry> filterCallLogs = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _controller.addListener(() {
      _showAllData();
    });
  }

  void _checkPermission() async {
    PermissionStatus status = await Permission.phone.request();
    if (status.isGranted) {
      fetchCallLogs();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Permission Denied"),
            content: const Text("Please grant permission to access call logs."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void fetchCallLogs() async {
    setState(() {
      loading = true;
    });
    try {
      Iterable<CallLogEntry> logs = await CallLog.get();
      setState(() {
        _callLogs = logs.toList();
        filterCallLogs = logs.toList();
        print("All Call Logs: ${logs.toList()}");
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
      print("Error $error");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('hh:mm a').format(date);
  }

  void _filterdCallLogs() {
    String query = _controller.text.toLowerCase();
    setState(() {
      filterCallLogs = _callLogs.where((calls) {
        return calls.number != null &&
            calls.number!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showAllData() {
    String query = _controller.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filterCallLogs = _callLogs;
      }
    });
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
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Call Logs",
              style: TextStyle(
                  fontSize: 25,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 1.4),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextField(
                controller: _controller,
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xff6546d2), width: 1)),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: Color(0xff6546d2), width: 1),
                    ),
                    hintText: 'Searching by number...',
                    hintStyle: const TextStyle(fontSize: 13),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _filterdCallLogs();
                        print("Searching by number");
                      },
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Color(0xff6546d2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
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
            const SizedBox(height: 14),
            if (loading == true)
              Expanded(
                  child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: const Color(0xff6546D2), size: 47),
              ))
            else if (filterCallLogs.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: filterCallLogs.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: .5,
                  ),
                  itemBuilder: (context, index) {
                    final log = filterCallLogs[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (log.callType == CallType.incoming)
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 10, 10),
                                      child: const Icon(
                                        Icons.phone_callback,
                                        color: Colors.grey,
                                        size: 16.0,
                                      ),
                                    )
                                  else if (log.callType == CallType.outgoing)
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 10, 10),
                                      child: const Icon(
                                        Icons.phone_forwarded_outlined,
                                        color: Colors.green,
                                        size: 16.0,
                                      ),
                                    )
                                  else if (log.callType == CallType.missed)
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 10, 10),
                                      child: const Icon(
                                        Icons.phone_missed,
                                        color: Colors.red,
                                        size: 16.0,
                                      ),
                                    )
                                  else if (log.callType == CallType.rejected)
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 10, 10),
                                      child: const Icon(
                                        Icons.block,
                                        color: Colors.red,
                                        size: 16.0,
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${log.name?.isNotEmpty == true ? log.name : "Unknown"}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "Number: ${log.number ?? "Unknown"}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                formatTime(log.timestamp!),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Image.network(
                    "https://img.freepik.com/premium-vector/no-data-concept-illustration_86047-488.jpg?semt=ais_hybrid",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
