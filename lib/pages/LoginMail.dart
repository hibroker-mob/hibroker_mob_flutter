import 'package:flutter/material.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class LoginMail extends StatefulWidget {
  const LoginMail({super.key});

  @override
  State<LoginMail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginMail> {
  final TextEditingController _emailController =
      TextEditingController(text: "");
  bool loading = false;

  void _handleVerifyEmail() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your registered email")),
      );
      return;
    }

    final url =
        Uri.parse('${Environment.apiUrl}api/consultant-verify-company-email');
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'company_email': email,
        }),
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
              "Email Id has been verified sucessfully",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ));

        Navigator.pushNamed(context, "/loginMobile",
            arguments: {'db_name': dataResponse["db_name"]});
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
              "Wrong Email Id. Please try again later",
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
            "Wrong Email Id. Please try again later",
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
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                        "Your company registered email",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 65, 63, 63),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 15, 25, 20),
                        child: TextField(
                          controller: _emailController,
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
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 128, 124, 124),
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          keyboardType: TextInputType.emailAddress,
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
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                            child: GestureDetector(
                              onTap: () {
                                _handleVerifyEmail();
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
                                  "Continue",
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
