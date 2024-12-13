import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class OTPPassword extends StatefulWidget {
  const OTPPassword({super.key});

  @override
  State<OTPPassword> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OTPPassword> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otp = TextEditingController(text: "1234");
  final TextEditingController _password =
      TextEditingController(text: "babu@hibroker");
  String? _token;
  bool loading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      if (arguments['phoneNumber'] != null) {
        _phoneController.text = arguments['phoneNumber'];
      }
      if (arguments['token'] != null) {
        _token = arguments['token'];
      }
    });
  }

  Future<void> handlePartnerDetails(
      BuildContext context, Map<String, dynamic> dataResponse) async {
    final prefs = await SharedPreferences.getInstance();

    final int id = dataResponse["user"]["id"];
    final String token = dataResponse["token"];
    await prefs.setInt('USERID', id);
    await prefs.setString('MY_TOKEN', token);

    Navigator.pushNamed(
      context,
      "/dashboardHome",
      arguments: {'id': id.toString(), "MY_TOKEN": token},
    );
  }

  void _handleSignIn() async {
    String otp = _otp.text.trim();
    String password = _password.text.trim();

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your OTP")),
      );
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your password")),
      );
      return;
    }

    final url = Uri.parse('${Environment.apiUrl}api/verify-password-otp');
    setState(() {
      loading = true;
    });

    final requestBody =
        jsonEncode({"token": _token, "password": password, "otp": otp});
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );
      print("requestBody $requestBody");
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            title: const Text(
              'Login Successfull',
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
            ),
            autoCloseDuration: const Duration(seconds: 4),
            primaryColor: Colors.green,
            backgroundColor: Colors.white,
            description: const Text(
              "Welcome to HiBroker",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ));
        handlePartnerDetails(context, dataResponse);
      } else {
        toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            title: const Text(
              'Login Failed',
              style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
            ),
            autoCloseDuration: const Duration(seconds: 4),
            primaryColor: Colors.red,
            backgroundColor: Colors.white,
            description: const Text(
              "Token expired or failed",
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
            'Login Failed',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          description: const Text(
            "Token expired or failed",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                      child: Text(
                        "Enter OTP and Password",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 65, 63, 63),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 17, 25, 15),
                        child: TextField(
                          controller: _phoneController,
                          readOnly: true,
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
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 128, 124, 124),
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                        child: TextField(
                          controller: _otp,
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
                            hintText: 'OTP',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 128, 124, 124),
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                        child: TextField(
                          controller: _password,
                          cursorColor: Colors.red,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 0.5),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 128, 124, 124),
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                size: 19,
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
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
                                _handleSignIn();
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
                                  "SIGN IN",
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
