import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:hibroker/pages/Contact/CreateContact/DocumentInfo.dart';
import 'package:hibroker/pages/Contact/CreateContact/OtherInfo.dart';
import 'package:hibroker/pages/Contact/CreateContact/PersonalInfo.dart';
import 'package:hibroker/pages/Contact/CreateContact/ProfessionalInfo.dart';
import 'package:hibroker/pages/Contact/CreateContact/SaveAndPublish.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class CreateContact extends StatefulWidget {
  const CreateContact({super.key});
  @override
  State<CreateContact> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateContact> {
  String? tabName = "PersonalInfo";
  bool _isNewTab = false;

  int? _salutationValue;
  String? _firstName;
  String? _lastName;
  int? _customerType;
  int? _contactType;
  String? _uniqueNumber;
  String? _countryCode;
  String? _mobileNumber;
  int? _mobStatus;
  String? _verifyMail;
  int? _mailStatus;
  String? _otherNumber;
  String? _personalCity;
  String? _personalLocality;
  String? _pincode;
  String? _personaladdress;
  /////////////////////////////////PROFESSIONAL///////////////////////////////////////////////////////
  String? _companyName;
  String? _businessName;
  String? _companyType;
  String? _designation;
  String? _investCapacity;
  String? _bankName;
  String? _bankAcc;
  String? _ifsc;
  String? _profCity;
  String? _profLocality;
  String? _profAddress;
  ///////////////////////////OTHER//////////////////////////////////////////////////////////////////
  String? _dob;
  String? _aniversary;
  bool? _smsGreet;
  bool? _emailGreet;
  bool? _whatsappGreet;
  String? _fax;
  String? _webSite;
  String? _skype;
  String? _rating;
  String? _remark;
  //////////////////////////////SAVE/////////////////////////////////////////////////////////////
  int? _folder;
  int? _source;
  int? _branch;
  int? _assignee;
  bool? _confidential;
  bool? _subscribe;
  String? keyword;
  String? myFile;
  String? myFileName;
  int? saveType;
  bool loading = false;

  void fetchAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    //////////////////////////////PERSONAL INFO/////////////////////////////////////////////////
    _salutationValue = prefs.getInt('salutaionValue');
    _firstName = prefs.getString('firstName');
    _lastName = prefs.getString('lastName');
    _customerType = prefs.getInt('customerType');
    _contactType = prefs.getInt('contactType');
    _uniqueNumber = prefs.getString('uniqueNumber');
    _countryCode = prefs.getString('countyCode');
    _mobileNumber = prefs.getString('mobileNumber');
    _mobStatus = prefs.getInt('mobStatus');
    _verifyMail = prefs.getString('verifyEmail');
    _mailStatus = prefs.getInt('emailStatus');
    _otherNumber = prefs.getString('otherNumber');
    _personalCity = prefs.getString('myCity');
    _personalLocality = prefs.getString('myLocality');
    _pincode = prefs.getString('myPin');
    _personaladdress = prefs.getString('myAddress');
    print('Salutation Value: $_salutationValue');
    print('First Name: $_firstName');
    print('Last Name: $_lastName');
    print('Customer Type: $_customerType');
    print('Contact Type: $_contactType');
    print('Unique Number: $_uniqueNumber');
    print('Country Code: $_countryCode');
    print('Mobile Number: $_mobileNumber');
    print('Mobile Status: $_mobStatus');
    print('Verify Email: $_verifyMail');
    print('Email Status: $_mailStatus');
    print('Other Number: $_otherNumber');
    print('City: $_personalCity');
    print('Locality: $_personalLocality');
    print('Pincode: $_pincode');
    print('Address: $_personaladdress');

    //////////////////////////////PROFESSIONAL INFO/////////////////////////////////////////////////
    _companyName = prefs.getString('company');
    _businessName = prefs.getString('business');
    _companyType = prefs.getString('companyType');
    _designation = prefs.getString('designation');
    _investCapacity = prefs.getString('investCapacity');
    _bankName = prefs.getString('bankName');
    _bankAcc = prefs.getString('bankAcc');
    _ifsc = prefs.getString('ifsc');
    _profCity = prefs.getString('profCity');
    _profLocality = prefs.getString('profLocality');
    _profAddress = prefs.getString('address');

    //////////////////////////////OTHER INFO/////////////////////////////////////////////////
    _dob = prefs.getString('dob');
    _aniversary = prefs.getString('aniversary');
    _smsGreet = prefs.getBool('smsGreet');
    _emailGreet = prefs.getBool('emailGreet');
    _whatsappGreet = prefs.getBool('whatsappGreet');
    _fax = prefs.getString('fax');
    _webSite = prefs.getString('webSite');
    _skype = prefs.getString('skype');
    _rating = prefs.getString('rating');
    _remark = prefs.getString('remark');

/////////////////////////////SAVE AND PUBLISH///////////////////////////////////////////////////////
    _folder = prefs.getInt('folder');
    _source = prefs.getInt('source');
    _branch = prefs.getInt('branch');
    _assignee = prefs.getInt('assignee');
    _confidential = prefs.getBool('confidential');
    _subscribe = prefs.getBool('subscribe');
    myFile = prefs.getString("path");
    myFileName = prefs.getString("fileName");
    keyword = prefs.getString("keyword");
    saveType = prefs.getInt("saveType");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      if (arguments['tabName'] != null) {
        tabName = arguments['tabName'];
      }

      if (arguments['isNewTab'] != null) {
        _isNewTab = arguments['isNewTab'];
      }
    }
  }

  void clearSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('salutaionValue');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('customerType');
    await prefs.remove('contactType');
    await prefs.remove('uniqueNumber');
    await prefs.remove('countyCode');
    await prefs.remove('mobileNumber');
    await prefs.remove('mobStatus');
    await prefs.remove('verifyEmail');
    await prefs.remove('emailStatus');
    await prefs.remove('otherNumber');
    await prefs.remove('myCity');
    await prefs.remove('myLocality');
    await prefs.remove('myPin');
    await prefs.remove('myAddress');
    await prefs.remove('company');
    await prefs.remove('business');
    await prefs.remove('companyType');
    await prefs.remove('designation');
    await prefs.remove('investCapacity');
    await prefs.remove('bankName');
    await prefs.remove('bankAcc');
    await prefs.remove('ifsc');
    await prefs.remove('profCity');
    await prefs.remove('profLocality');
    await prefs.remove('address');
    await prefs.remove('dob');
    await prefs.remove('aniversary');
    await prefs.remove('smsGreet');
    await prefs.remove('emailGreet');
    await prefs.remove('whatsappGreet');
    await prefs.remove('fax');
    await prefs.remove('webSite');
    await prefs.remove('skype');
    await prefs.remove('rating');
    await prefs.remove('remark');
    await prefs.remove('folder');
    await prefs.remove('source');
    await prefs.remove('branch');
    await prefs.remove('assignee');
    await prefs.remove('confidential');
    await prefs.remove('subscribe');
    await prefs.remove('path');
    await prefs.remove('fileName');
    await prefs.remove('keyword');
    await prefs.remove('saveType');
  }

  void submitContactForm() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('MY_TOKEN');
    final url = Uri.parse('${Environment.apiUrl}api/contact/creation');

    if (_salutationValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select one salutation")),
      );
      return;
    }
    if (_firstName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter your first name")),
      );
      return;
    }
    if (_customerType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select one customer type")),
      );
      return;
    }
    if (_uniqueNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter your unique number")),
      );
      return;
    }
    if (_countryCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select mobile code")),
      );
      return;
    }

    if (_mobileNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter your mobile number")),
      );
      return;
    }

    if (_verifyMail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter your email id")),
      );
      return;
    }

    if (_folder == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select one folder")),
      );
      return;
    }

    if (_source == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select one source")),
      );
      return;
    }

    if (_branch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select one branch")),
      );
      return;
    }

    if (_assignee == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select one assignee")),
      );
      return;
    }
    setState(() {
      loading = true;
    });

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data"
        });

      request.fields.addAll({
        "salutation": _salutationValue == 1
            ? "Mr"
            : _salutationValue == 2
                ? "Mrs"
                : _salutationValue == 3
                    ? "Ms"
                    : _salutationValue == 4
                        ? "M/s"
                        : "Dr",
        "first_name": _firstName ?? "",
        "last_name": _lastName ?? "",
        "cus_type": (_customerType ?? 0).toString(),
        "cont_type": (_contactType ?? 0).toString(),
        "uan": _uniqueNumber ?? "",
        "mob_code": _countryCode ?? "",
        "mobile_no": _mobileNumber ?? "",
        "mobile_status": (_mobStatus ?? 1).toString(),
        "email": _verifyMail ?? "",
        "email_status": (_mailStatus ?? 1).toString(),
        "city": _personalCity ?? "",
        "locality": _personalLocality ?? "",
        "pincode": _pincode ?? "",
        "address": _personaladdress ?? "",
        "company": _companyName ?? "",
        "business": _businessName ?? "",
        "company_type": _companyType ?? "",
        "designation": _designation ?? "",
        "invest_capacity": _investCapacity ?? "",
        "bank_name": _bankName ?? "",
        "bank_ac": _bankAcc ?? "",
        "ifsc": _ifsc ?? "",
        "org_city": _profCity ?? "",
        "org_locality": _profLocality ?? "",
        "org_address": _profAddress ?? "",
        "dob": _dob ?? "",
        "aniversary": _aniversary ?? "",
        "sms_greet": _smsGreet == true ? "1" : "0",
        "email_greet": _emailGreet == true ? "1" : "0",
        "whatsapp_greet": _whatsappGreet == true ? "1" : "0",
        "fax": _fax ?? "",
        "website": _webSite ?? "",
        "skype": _skype ?? "",
        "rating": _rating ?? "0",
        "cus_remark": _remark ?? "",
        "folder": (_folder ?? 0).toString(),
        "source": (_source ?? 0).toString(),
        "branch": (_branch ?? 0).toString(),
        "user": (_assignee ?? 0).toString(),
        "type_status": (saveType ?? 1).toString(),
        "subscribe": _subscribe == true ? "1" : "0",
        "is_confidential": _confidential == true ? "1" : "0",
      });

      if (myFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo',
          myFile!,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final dataResponse = jsonDecode(responseBody);
        print("dataResponse $dataResponse");
        clearSharedPref();
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
          title: const Text(
            'Contact created successfully',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.green,
          backgroundColor: Colors.white,
          description: const Text(
            "Great!! Contact has been created successfully",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
          ),
        );
        Navigator.pushNamed(context, "/allContact");
      } else {
        final responseBody = await response.stream.bytesToString();
        final dataResponse = jsonDecode(responseBody);
        print("dataResponse ${dataResponse}");
        setState(() {
          loading = false;
        });
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          title: const Text(
            'Contact creation failed',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          description: const Text(
            "Contact creation has been failed. Try again",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
          ),
        );
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      print("Error $error");
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
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                "Create Contact",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(1, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 70,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tabName = "PersonalInfo";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: tabName == "PersonalInfo"
                                        ? const Color(0xff6546d2)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                height: 70,
                                child: Center(
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: tabName == "PersonalInfo"
                                        ? Colors.white
                                        : const Color(0xff8C91B6),
                                    size: 33,
                                  ),
                                ),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tabName = "ProfessionalInfo";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: tabName == "ProfessionalInfo"
                                      ? const Color(0xff6546d2)
                                      : Colors.white,
                                ),
                                height: 300,
                                child: Center(
                                  child: Icon(
                                    Icons.manage_accounts_rounded,
                                    color: tabName == "ProfessionalInfo"
                                        ? Colors.white
                                        : const Color(0xff8C91B6),
                                    size: 33,
                                  ),
                                ),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tabName = "OtherInfo";
                                });
                              },
                              child: Container(
                                color: tabName == "OtherInfo"
                                    ? const Color(0xff6546d2)
                                    : Colors.white,
                                height: 300,
                                child: Center(
                                  child: Icon(
                                    Icons.g_translate_sharp,
                                    color: tabName == "OtherInfo"
                                        ? Colors.white
                                        : const Color(0xff8C91B6),
                                    size: 33,
                                  ),
                                ),
                              ),
                            )),
                            _isNewTab == true
                                ? Expanded(
                                    child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tabName = "Document";
                                      });
                                    },
                                    child: Container(
                                      color: tabName == "Document"
                                          ? const Color(0xff6546d2)
                                          : Colors.white,
                                      height: 300,
                                      child: Center(
                                        child: Icon(
                                          Icons.attach_file,
                                          color: tabName == "Document"
                                              ? Colors.white
                                              : const Color(0xff8C91B6),
                                          size: 33,
                                        ),
                                      ),
                                    ),
                                  ))
                                : const Text(""),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tabName = "SaveAndPublish";
                                  fetchAllData();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: tabName == "SaveAndPublish"
                                        ? const Color(0xff6546d2)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                height: 300,
                                child: Center(
                                  child: Icon(
                                    Icons.public_outlined,
                                    color: tabName == "SaveAndPublish"
                                        ? Colors.white
                                        : const Color(0xff8C91B6),
                                    size: 33,
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            if (tabName == "PersonalInfo")
              const PersonalInfo()
            else if (tabName == "ProfessionalInfo")
              const ProfessionalInfo()
            else if (tabName == "OtherInfo")
              const OtherInfo()
            else if (tabName == "Document")
              const DocumentInfo()
            else
              const SaveAndPublish(),
            if (tabName == "PersonalInfo")
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                  const Color(0xffFF7A29)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName = "ProfessionalInfo";
                              });
                            },
                            child: const Text('Next'))
                      ],
                    ),
                  ))
            else if (tabName == "ProfessionalInfo")
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  const Color(0xff2E2138)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName = "PersonalInfo";
                              });
                            },
                            child: const Text('Previous')),
                        FilledButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xffFF7A29)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName = "OtherInfo";
                              });
                            },
                            child: const Text('Next'))
                      ],
                    ),
                  ))
            else if (tabName == "OtherInfo")
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  const Color(0xff2E2138)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName = "ProfessionalInfo";
                              });
                            },
                            child: const Text('Previous')),
                        FilledButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xffFF7A29)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName =
                                    _isNewTab ? "Document" : "SaveAndPublish";
                                fetchAllData();
                              });
                            },
                            child: const Text('Next'))
                      ],
                    ),
                  ))
            else if (tabName == "Document")
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  const Color(0xff2E2138)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName = "OtherInfo";
                              });
                            },
                            child: const Text('Previous')),
                        FilledButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xffFF7A29)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName = "SaveAndPublish";
                                fetchAllData();
                              });
                            },
                            child: const Text('Next'))
                      ],
                    ),
                  ))
            else
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  const Color(0xff2E2138)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                tabName = _isNewTab ? "Document" : "OtherInfo";
                              });
                            },
                            child: const Text('Previous')),
                        if (loading == true)
                          FilledButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 28, 182, 66)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                submitContactForm();
                              });
                            },
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        else
                          FilledButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 28, 182, 66)),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  submitContactForm();
                                });
                              },
                              child: const Text('Submit'))
                      ],
                    ),
                  ))
          ],
        )));
  }
}
