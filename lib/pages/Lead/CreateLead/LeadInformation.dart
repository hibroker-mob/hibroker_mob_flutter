import 'package:flutter/material.dart';

class LeadInformation extends StatefulWidget {
  const LeadInformation({super.key});

  @override
  State<LeadInformation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LeadInformation> {
  String? executiveValue;
  final List<Map<String, dynamic>> _executiveValues = [
    {'name': 'Salutation 1', 'value': 1},
    {'name': 'Salutation 2', 'value': 2},
    {'name': 'Salutation 3', 'value': 3},
  ];
  TimeOfDay? selectedTime;
  final TextEditingController _selectedTimeController = TextEditingController();
  final TextEditingController _scheduleDateController = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(0, 0);
  String? rating;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text("Contact"),
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
        SizedBox(
          height: 45,
          child: DropdownButtonFormField<String>(
            style: const TextStyle(color: Colors.black),
            value: executiveValue,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: const Text(
              'Select Contact',
              style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
            ),
            onChanged: (String? value) {
              setState(() {
                executiveValue = value;
              });
            },
            items:
                _executiveValues.map<DropdownMenuItem<String>>((dynamic state) {
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
        const Row(
          children: [
            Text("Schedule Date"),
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
        SizedBox(
          height: 45,
          child: TextField(
            controller: _scheduleDateController,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              hintText: "yyyy-mm-dd",
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        const Row(
          children: [
            Text("Schedule Time"),
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
        SizedBox(
          height: 45,
          child: TextField(
            controller: _selectedTimeController,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              hintText: "hh:mm",
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              suffixIcon: IconButton(
                icon: const Icon(Icons.alarm, color: Colors.black54),
                onPressed: () {
                  _pickTime(context);
                },
              ),
            ),
            style: const TextStyle(fontSize: 13),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          children: [
            Text("Requirement"),
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
        const SizedBox(
          height: 45,
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              hintText: 'Enter Requirement',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 128, 124, 124),
                fontWeight: FontWeight.w400,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 13),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          children: [
            Text("Followup Note"),
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
        const SizedBox(
          height: 45,
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              hintText: 'Enter Followup Note',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 128, 124, 124),
                fontWeight: FontWeight.w400,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 13),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Rating *: ${_currentRangeValues.end.round()}',
        ),
        Container(
          transform: Matrix4.translationValues(-13, 0, 0),
          child: RangeSlider(
            values: _currentRangeValues,
            max: 100,
            divisions: 100,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                rating = _currentRangeValues.end.round().toString();
              });
            },
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xff06C270)),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  setState(() {});
                },
                child: const Text('Add New Contact')),
            FilledButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xffFF7A29)),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                child: const Text('Next'))
          ],
        ),
      ],
    );
  }
}
