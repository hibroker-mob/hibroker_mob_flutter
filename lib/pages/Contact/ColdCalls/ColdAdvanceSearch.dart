import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactHeader.dart';

class ColdAdvanceSearch extends StatefulWidget {
  const ColdAdvanceSearch({super.key});

  @override
  State<ColdAdvanceSearch> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ColdAdvanceSearch> {
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
                                'Select the source',
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
                            height: 15,
                          ),
                          const Text("Assign to"),
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
                                'Select the user',
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
                            height: 15,
                          ),
                          const Text("Submitted by"),
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
                                'Select the user',
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
                            height: 15,
                          ),
                          const Text("Customer Type"),
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
                                'Select the Customer Type',
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
                            height: 15,
                          ),
                          const Text("Contact Type"),
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
                                'Select the Contact Type',
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
                                    _selectAniversary(context);
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
                                    _selectDOB(context);
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
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Locality"),
                          const SizedBox(
                            height: 10,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                hintText: 'Enter Locality',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 128, 124, 124),
                                    fontWeight: FontWeight.w400),
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
                                    _selectAniversary(context);
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
                                    _selectDOB(context);
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
                                  onPressed: () {},
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
