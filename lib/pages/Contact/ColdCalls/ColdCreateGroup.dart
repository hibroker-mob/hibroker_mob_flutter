import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactHeader.dart';

class ColdCreateGroup extends StatefulWidget {
  const ColdCreateGroup({super.key});

  @override
  State<ColdCreateGroup> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ColdCreateGroup> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _aniversaryController = TextEditingController();
  String? executiveValue;
  final List<Map<String, dynamic>> _executiveValues = [
    {'name': 'Salutation 1', 'value': 1},
    {'name': 'Salutation 2', 'value': 2},
    {'name': 'Salutation 3', 'value': 3},
  ];

  Future<void> _selectDOB(BuildContext context) async {
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
        _dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectAniversary(BuildContext context) async {
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
        _aniversaryController.text = "${pickedDate.toLocal()}".split(' ')[0];
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
                            "Create Group",
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
                              Text("Name"),
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
                            height: 15,
                          ),
                          const SizedBox(
                            height: 45,
                            child: TextField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text("Templete"),
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
                            height: 15,
                          ),
                          SizedBox(
                            height: 45,
                            child: DropdownButtonFormField<String>(
                              style: const TextStyle(color: Colors.black),
                              value: executiveValue,
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
                                'Please select a message templete',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 116, 116)),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  executiveValue = value;
                                });
                              },
                              items: _executiveValues
                                  .map<DropdownMenuItem<String>>(
                                      (dynamic state) {
                                final id = state['value'].toString();
                                final name = state['name'];
                                return DropdownMenuItem<String>(
                                  value: id,
                                  child: Text(name),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Content"),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: "Template Message",
                                hintStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                filled: true,
                                fillColor: Color(0xffE9ECEF),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 3,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/contentPage");
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Change Content",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff6546D2)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  onPressed: () {},
                                  child: const Text('Submit')),
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
                                  onPressed: () {},
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
