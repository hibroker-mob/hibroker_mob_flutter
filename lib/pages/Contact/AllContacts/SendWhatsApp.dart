import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactDetailsHeader.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class SendWhatsApp extends StatefulWidget {
  const SendWhatsApp({super.key});

  @override
  State<SendWhatsApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SendWhatsApp> {
  int? sendType = 1;
  String? executiveValue;
  final List<Map<String, dynamic>> _executiveValues = [
    {'name': 'Salutation 1', 'value': 1},
    {'name': 'Salutation 2', 'value': 2},
    {'name': 'Salutation 3', 'value': 3},
  ];
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
              const Contactdetailsheader(),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Send Whatsapp",
                        style: TextStyle(
                          fontSize: 25,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 1.4,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          Text("Type"),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              transform:
                                  Matrix4.translationValues(-11.0, 0.0, 0.0),
                              child: RadioListTile<int>(
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text('Custom',
                                    style: TextStyle(fontSize: 15)),
                                value: 1,
                                groupValue: sendType,
                                onChanged: (int? value) {
                                  setState(() {
                                    sendType = value!;
                                    print(" value ${value}");
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              transform:
                                  Matrix4.translationValues(-50.0, 0.0, 0.0),
                              child: RadioListTile<int>(
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text(
                                  'Templete',
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: 2,
                                groupValue: sendType,
                                onChanged: (int? value) {
                                  setState(() {
                                    sendType = value!;
                                    print(" value ${value}");
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (sendType == 2)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Template",
                              style: TextStyle(fontSize: 15),
                            ),
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
                                  'Select a message templete',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 117, 116, 116)),
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
                              height: 10,
                            ),
                          ],
                        )
                      else
                        const Text(
                          "Content",
                          style: TextStyle(fontSize: 15),
                        ),
                      const SizedBox(height: 10),
                      const SizedBox(
                        height: 150,
                        child: TextField(
                          maxLines: 1000,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: .5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            hintText: 'Enter Msg',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 128, 124, 124),
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 13),
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
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color(0xff06C270)),
                              ),
                              onPressed: () {},
                              child: const Text('Send')),
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
                                backgroundColor: WidgetStateProperty.all<Color>(
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
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
