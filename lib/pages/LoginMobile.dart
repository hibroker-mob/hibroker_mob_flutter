import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toastification/toastification.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _MyWidgetState();
}

TextEditingController _controller =
    TextEditingController(text: "India (IN) [+91]");
TextEditingController _controllerPhone = TextEditingController(text: "6360328864");

class _MyWidgetState extends State<LoginMobile> {
  String? _dbName;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      if (arguments['db_name'] != null) {
        _dbName = arguments['db_name'];
      }
    });
  }

  String selectedItem = '';
  bool loading = false;
  String _countryCode = '91';

  void _handleVerifyMobile() async {
    String phoneNumber = _controllerPhone.text.trim();

    if (_countryCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select country code")),
      );
      return;
    }
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter your registered mobile no.")),
      );
      return;
    }

    final url = Uri.parse('${Environment.apiUrl}api/verify-mobile-number');
    setState(() {
      loading = true;
    });

    final requestBody = jsonEncode({
      "mobile_number": phoneNumber,
      "country_code": _countryCode,
      "db_name": _dbName
    });
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            title: const Text(
              'Verification Successfull',
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
            ),
            autoCloseDuration: const Duration(seconds: 4),
            primaryColor: Colors.green,
            backgroundColor: Colors.white,
            description: const Text(
              "Mobile Number has been verified.",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ));
        Navigator.pushNamed(context, "/otpPassword", arguments: {
          'phoneNumber': dataResponse["mobile_number"],
          'token': dataResponse["token"],
        });
      } else {
        toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            title: const Text(
              'Verification Failed',
              style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
            ),
            autoCloseDuration: const Duration(seconds: 4),
            primaryColor: Colors.red,
            backgroundColor: Colors.white,
            description: const Text(
              "Mobile number not found. Please try again",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ));
        setState(() {
          loading = false;
        });
      }
    } catch (error) {
      toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          title: const Text(
            'Verification Failed',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          description: const Text(
            "Mobile number not found. Please try again",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
          ));
      setState(() {
        loading = false;
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xffdc2b25),
          title: const Text(
            'LOGIN',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 170,
                height: 90,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: .5),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        "Login With Mobile",
                        style: TextStyle(
                          fontSize: 15.5,
                          color: Color.fromARGB(255, 65, 63, 63),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide:
                                BorderSide(color: Colors.red, width: .5),
                          ),
                          hintText: 'Select country code',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 128, 124, 124),
                              fontWeight: FontWeight.w400),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            onSelect: (Country country) {
                              setState(() {
                                selectedItem = country.displayName;
                                _controller.text = selectedItem;
                                print(
                                    "name ${_controller.text = selectedItem}");
                                _countryCode = country.phoneCode;
                                print("_countryCode ${country.phoneCode}");
                              });
                            },
                          );
                        },
                        readOnly: true,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 15, 25, 20),
                        child: TextField(
                          controller: _controllerPhone,
                          cursorColor: Colors.red,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: .5),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            hintText: 'Mobile number',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 128, 124, 124),
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        )),
                    loading
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                            child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffdc2b25),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 30,
                                )),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                            child: GestureDetector(
                              onTap: () {
                                _handleVerifyMobile();
                              },
                              child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffdc2b25),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
