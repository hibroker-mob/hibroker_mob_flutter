import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DocumentInfo extends StatefulWidget {
  const DocumentInfo({super.key});

  @override
  State<DocumentInfo> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DocumentInfo> {
  String? myFile;
  String? myFileName;
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _selectedTimeController = TextEditingController();
  Future<void> pickFile(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        myFile = result.files.single.path;
        myFileName = result.files.single.name;
      });
    }
  }

  TimeOfDay? selectedTime;

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
        _dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 25, 22, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Documets",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Aadhar Card"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Pan Card"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Agreement"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Passport"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Driving License"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Pan Card"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Employee Id"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Cancelled Cheque/Passbook"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Voted Id"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Other Document"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff6546d2)),
                    ),
                    onPressed: () => pickFile('Aadhar'),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file chosen",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text("Schedule Date"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _dobController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  hintText: "yyyy-mm-dd",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_outlined,
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
            const Text("Schedule Time"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _selectedTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  hintText: "hh:mm",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
          ],
        ),
      ),
    );
  }
}
