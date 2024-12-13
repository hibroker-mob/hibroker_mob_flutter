import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactHeader.dart';

class ColdImportContact extends StatefulWidget {
  const ColdImportContact({super.key});

  @override
  State<ColdImportContact> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ColdImportContact> {
  final TextEditingController _controller = TextEditingController(text: "1");
  String? myFile;
  String? myFileName;
  Future<void> pickFile(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        myFile = result.files.single.path;
        myFileName = result.files.single.name;
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
                const SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Import Contact",
                          style: TextStyle(
                              fontSize: 25,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationThickness: 1.4),
                        ),
                        const Text(
                          "Upload maximum 2000 records",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Upload excel file format. ',
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Click here',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 163, 141, 243),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Clicked on "Click here"');
                                  },
                              ),
                              const TextSpan(
                                text: ' download sample',
                                style: TextStyle(
                                  color: Colors.black, // Default text color
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Contact Upload",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color(0xff6546d2)),
                                ),
                                onPressed: () => pickFile('Aadhar'),
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
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
                                child: const Text('Export')),
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
                        )
                      ],
                    )),
              ],
            )));
  }
}
