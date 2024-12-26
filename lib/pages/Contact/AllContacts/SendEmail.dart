import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactDetailsHeader.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({super.key});

  @override
  State<SendEmail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SendEmail> {
  List<Map<String, String>> menuItems = [
    {"name": "Export", "value": "Export"},
    {"name": "Import", "value": "Import"},
    {"name": "Advanced Search", "value": "Advanced Search"},
    {"name": "Create Group", "value": "Create Group"},
    {"name": "Properties", "value": "Properties"},
    {"name": "Requirements", "value": "Requirements"},
    {"name": "Send Email", "value": "Send Email"},
    {"name": "Send SMS", "value": "Send SMS"},
    {"name": "Send Whatsapp", "value": "Send Whatsapp"},
    {"name": "Email T & C", "value": "Email T & C"},
  ];

  List<Map<String, String>> menuItems2 = [
    {'name': 'Lead', 'value': 'Lead'},
    {'name': 'Owner', 'value': 'Owner'},
    {'name': 'Tenant', 'value': 'Tenant'},
    {'name': 'Vendor', 'value': 'Vendor'},
  ];
  String isSelected = "home";
  HtmlEditorController ckController = HtmlEditorController();

  TimeOfDay? selectedTime;
  final TextEditingController _selectedTimeController = TextEditingController();
  final TextEditingController _scheduleDateController = TextEditingController();

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null && time != selectedTime) {
      setState(() {
        selectedTime = time;

        _selectedTimeController.text = time.format(context);
      });
    }
  }

  Future<void> _selectScheduleDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff6546d2),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff6546d2),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _scheduleDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
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
                        "Send Email",
                        style: TextStyle(
                          fontSize: 25,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 1.4,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Subject"),
                      const SizedBox(height: 10),
                      const SizedBox(
                        height: 45,
                        child: TextField(
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
                            hintText: 'Enter Subject',
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
                      const SizedBox(height: 10),
                      const Text("Body"),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: Colors.black,
                            width: .5,
                          ),
                        ),
                        child: SizedBox(
                          child: HtmlEditor(
                            controller: ckController,
                            htmlEditorOptions: const HtmlEditorOptions(
                              adjustHeightForKeyboard: true,
                              hint: "Your text here...",
                            ),
                            htmlToolbarOptions: const HtmlToolbarOptions(
                              toolbarType: ToolbarType.nativeGrid,
                              renderBorder: true,
                              gridViewHorizontalSpacing: 2,
                            ),
                            // otherOptions: const OtherOptions(height: 350),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xff9b87e2), width: 1)),
                        child: const Padding(
                            padding: EdgeInsets.all(7),
                            child: Text(
                              'Schedule',
                              style: TextStyle(
                                  color: Color(0xff9b87e2),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _scheduleDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: .5),
                            ),
                            hintText: "yyyy-mm-dd",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_month_outlined,
                                  color: Colors.black54),
                              onPressed: () {
                                _selectScheduleDate(context);
                              },
                            ),
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _selectedTimeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: .5),
                            ),
                            hintText: "hh:mm",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.alarm,
                                  color: Colors.black54),
                              onPressed: () {
                                _pickTime(context);
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
