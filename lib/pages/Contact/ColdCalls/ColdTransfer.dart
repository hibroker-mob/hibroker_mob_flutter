import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactHeader.dart';

enum SingingCharacter { lafayette, jefferson, jefferson2 }

class ColdTransfer extends StatefulWidget {
  const ColdTransfer({super.key});

  @override
  State<ColdTransfer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ColdTransfer> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _aniversaryController = TextEditingController();
  SingingCharacter? _character = SingingCharacter.lafayette;
  bool sendMessage_Assignee = true;
  bool sendEmail_Assignee = true;
  bool stayOn = true;
  bool sendMessage_Customer = true;
  bool sendEmail_Customer = true;
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
                            "Transfer Contact",
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
                              Text("Transfer Type"),
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
                            height: 10,
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(-10.0, -13.0, 0.0),
                            child: RadioListTile<SingingCharacter>(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text(
                                'Customer Transfer',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: SingingCharacter.jefferson,
                              groupValue: _character,
                              onChanged: (SingingCharacter? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(-10.0, -35.0, 0.0),
                            child: RadioListTile<SingingCharacter>(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text(
                                'Cold Calling Transfer',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: SingingCharacter.lafayette,
                              groupValue: _character,
                              onChanged: (SingingCharacter? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -51.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text("Folder"),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: DropdownButtonFormField<String>(
                                    style: const TextStyle(color: Colors.black),
                                    value: executiveValue,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: .5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                    ),
                                    isExpanded: true,
                                    dropdownColor: Colors.white,
                                    hint: const Text(
                                      'Select the folder',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 117, 116, 116)),
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
                              ],
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -35.0, 0.0),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 10,
                                  ),
                                ),
                                Text(
                                  "OR",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -40.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text("Branch"),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: DropdownButtonFormField<String>(
                                    style: const TextStyle(color: Colors.black),
                                    value: executiveValue,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: .5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                    ),
                                    isExpanded: true,
                                    dropdownColor: Colors.white,
                                    hint: const Text(
                                      'Select the branch',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 117, 116, 116)),
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
                              ],
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -40.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text("Assign To"),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: DropdownButtonFormField<String>(
                                    style: const TextStyle(color: Colors.black),
                                    value: executiveValue,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: .5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                    ),
                                    isExpanded: true,
                                    dropdownColor: Colors.white,
                                    hint: const Text(
                                      'Select the user',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 117, 116, 116)),
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
                              ],
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -21.0, 0.0),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 10,
                                  ),
                                ),
                                Text(
                                  "OR",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -25.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text("Permission"),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: DropdownButtonFormField<String>(
                                    style: const TextStyle(color: Colors.black),
                                    value: executiveValue,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: .5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                    ),
                                    isExpanded: true,
                                    dropdownColor: Colors.white,
                                    hint: const Text(
                                      'Select the type',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 117, 116, 116)),
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
                              ],
                            ),
                          ),
                          Container(
                              transform:
                                  Matrix4.translationValues(-12.0, -16.0, 0.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          checkColor: Colors.white,
                                          fillColor: WidgetStateProperty
                                              .resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                              if (states.contains(
                                                  WidgetState.selected)) {
                                                return const Color(0xFF6546D2);
                                              }
                                              return Colors.white;
                                            },
                                          ),
                                          value: sendMessage_Assignee,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              sendMessage_Assignee = value!;
                                            });
                                          }),
                                      const Text(
                                        "Send Message to Assignee",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -7.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: WidgetStateProperty
                                                .resolveWith<Color>(
                                              (Set<WidgetState> states) {
                                                if (states.contains(
                                                    WidgetState.selected)) {
                                                  return const Color(
                                                      0xFF6546D2);
                                                }
                                                return Colors.white;
                                              },
                                            ),
                                            value: sendEmail_Assignee,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                sendEmail_Assignee = value!;
                                              });
                                            }),
                                        const Text(
                                          "Send Email to Assignee",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -15.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: WidgetStateProperty
                                                .resolveWith<Color>(
                                              (Set<WidgetState> states) {
                                                if (states.contains(
                                                    WidgetState.selected)) {
                                                  return const Color(
                                                      0xFF6546D2);
                                                }
                                                return Colors.white;
                                              },
                                            ),
                                            value: stayOn,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                stayOn = value!;
                                              });
                                            }),
                                        const Text(
                                          "Stay on this list after submit",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -21.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: WidgetStateProperty
                                                .resolveWith<Color>(
                                              (Set<WidgetState> states) {
                                                if (states.contains(
                                                    WidgetState.selected)) {
                                                  return const Color(
                                                      0xFF6546D2);
                                                }
                                                return Colors.white;
                                              },
                                            ),
                                            value: sendMessage_Customer,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                sendMessage_Customer = value!;
                                              });
                                            }),
                                        const Text(
                                          "Send Message to Customer",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -29.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: WidgetStateProperty
                                                .resolveWith<Color>(
                                              (Set<WidgetState> states) {
                                                if (states.contains(
                                                    WidgetState.selected)) {
                                                  return const Color(
                                                      0xFF6546D2);
                                                }
                                                return Colors.white;
                                              },
                                            ),
                                            value: sendEmail_Customer,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                sendEmail_Customer = value!;
                                              });
                                            }),
                                        const Text(
                                          "Send Email to Customer",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            transform: Matrix4.translationValues(0, -25, 0),
                            child: Row(
                              children: [
                                FilledButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              const Color(0xff06C270)),
                                    ),
                                    onPressed: () {},
                                    child: const Text('Transfer')),
                                const SizedBox(
                                  width: 5,
                                ),
                                FilledButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
