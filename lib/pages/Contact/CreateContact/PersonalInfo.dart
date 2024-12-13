import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:searchfield/searchfield.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _MyWidgetState();
}

final TextEditingController _controller = TextEditingController();
final TextEditingController _firstNamecontroller = TextEditingController();
final TextEditingController _lastNamecontroller = TextEditingController();
final TextEditingController _uniqueController = TextEditingController();
final TextEditingController _mobileController = TextEditingController();
final TextEditingController _otherNumber = TextEditingController();
final TextEditingController _pinController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _searchController = TextEditingController();
final TextEditingController _localityController = TextEditingController();
bool isVerified = false;

class _MyWidgetState extends State<PersonalInfo> {
  String? executiveValue;
  final List<Map<String, dynamic>> _salutaionValues = [
    {'name': 'Mr', 'value': 1},
    {'name': 'Mrs', 'value': 2},
    {'name': 'Ms', 'value': 3},
    {'name': 'M/s', 'value': 4},
    {'name': 'Dr', 'value': 5},
  ];

  //////////////////////////////////////////////////////
  String? _token;
  int? salutaionValue;
  int? customerType;
  int? contactType;
  String firstName = _firstNamecontroller.text.trim();
  String lastName = _lastNamecontroller.text.trim();
  String uniqueNumber = _uniqueController.text.trim();
  String mobileNumber = _mobileController.text.trim();
  String otherNumber = _otherNumber.text.trim();
  String pinCode = _pinController.text.trim();
  String address = _addressController.text.trim();
  String email = _emailController.text.trim();
  List<dynamic> _customerTypes = [];
  List<dynamic> _contactTypes = [];
  List<dynamic> cities = [];
  List<dynamic> localities = [];
  String? countryCode;
  String? selectedItem;
  int? _mobileStatus = 1;
  int? _EmailStatus = 1;
  String? searchData = _searchController.text.trim();
  String? searchLocalityData = _localityController.text.trim();
  List<String> filteredData = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchPersonalInfoData();
  }

  void setSaluationValue(int? salutaionValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('salutaionValue', salutaionValue ?? 0);
  }

  void setFirstName(String firstName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
  }

  void setLastName(String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastName', lastName);
  }

  void setCustomerTypeValue(customerType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('customerType', customerType ?? 0);
  }

  void setContactTypeValue(contactType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('contactType', contactType ?? 0);
  }

  void setUniqueNo(String uniqueNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uniqueNumber', uniqueNumber);
  }

  void setMobileNumber(String mobileNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', mobileNumber);
  }

  void setMobileStatus(int mobStatus) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mobStatus', mobStatus);
  }

  void setVerifyEmail(String verifyEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('verifyEmail', verifyEmail);
  }

  void setEmailStatus(int emailStatus) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('emailStatus', emailStatus);
  }

  void setMobileCode(countryCode, selectedCounty) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('countyCode', countryCode);
    await prefs.setString('countryName', selectedCounty);
  }

  void setOtherNumber(String otherNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('otherNumber', otherNumber);
  }

  void setPinCode(String myPin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myPin', myPin);
  }

  void setAddress(String myAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myAddress', myAddress);
  }

  void setCity(String myCity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myCity', myCity);
  }

  void setLocality(String myLocality) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myLocality', myLocality);
  }

  void fetchPersonalInfoData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? _salutationValue = prefs.getInt('salutaionValue');
    int? _customerType = prefs.getInt('customerType');
    int? _contactType = prefs.getInt('contactType');
    String? _countryCode = prefs.getString('countyCode');
    String? _countryName = prefs.getString('countryName');

    final String? token = prefs.getString('MY_TOKEN');
    setState(() {
      _token = token;
      salutaionValue = _salutationValue;
      customerType = _customerType;
      contactType = _contactType;
      countryCode = _countryCode;
      selectedItem = _countryName;
    });

    if (token != null) {
      fetchCustomerTypes();
    }
    if (_customerType != null) {
      fetchContactTypes(_customerType);
    }
  }

  void fetchCities(search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        '${Environment.apiUrl}api/get-location?input=${search}&type=locality');
    final String? token = prefs.getString('MY_TOKEN');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          cities = dataResponse["data"];
          print("Cities ${dataResponse["data"]}");
          showSearchableList();
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchLocalities(search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _cityName = prefs.getString('myCity');
    print("_cityName ${_cityName}");
    final url = Uri.parse(
        '${Environment.apiUrl}api/get-location?input=${search}&type=locality&city=${_cityName}');
    final String? token = prefs.getString('MY_TOKEN');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          localities = dataResponse["data"];
          print("localities ${dataResponse["data"]}");
          showSearchableLocalityList();
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void showSearchableList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(26.0, 10, 26.0, 26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              if (cities.length > 0)
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cities[index]["text"],
                        style: const TextStyle(fontSize: 13),
                      ),
                      onTap: () {
                        setState(() {
                          _searchController.text = cities[index]["text"];
                          setCity(cities[index]["text"]);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 0.5,
                    );
                  },
                )
              else
                Column(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      width: double.infinity,
                      height: 150,
                    ),
                    const Text(
                      "Opps!! No location found",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red),
                    )
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  void showSearchableLocalityList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(26.0, 10, 26.0, 26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              if (localities.length > 0)
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: localities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        localities[index]["text"],
                        style: const TextStyle(fontSize: 13),
                      ),
                      onTap: () {
                        setState(() {
                          _localityController.text = localities[index]["text"];
                          setLocality(localities[index]["text"]);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 0.5,
                    );
                  },
                )
              else
                Column(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      width: double.infinity,
                      height: 150,
                    ),
                    const Text(
                      "Opps!! No location found",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red),
                    )
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  void fetchCustomerTypes() async {
    final url = Uri.parse('${Environment.apiUrl}api/contact-creation-data');
    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $_token",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);
        setState(() {
          _customerTypes = dataResponse["data"]["customerTypes"];
          print("Customer Types ${dataResponse["data"]["customerTypes"]}");
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void fetchContactTypes(id) async {
    final url = Uri.parse('${Environment.apiUrl}api/contacttype/$id');
    print("url ${url}");
    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer ${_token}",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final dataResponse = await jsonDecode(response.body);

        setState(() {
          _contactTypes = dataResponse["data"];
          print("Contact Types ${dataResponse["data"]}");
        });
      }
    } catch (error) {
      print("Error ${error}");
    }
  }

  void verifyEmail() async {
    final url = Uri.parse("${Environment.apiUrl}api/verify-email");
    final requestBody = jsonEncode({"email": email});
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer ${_token}",
            "Content-Type": "application/json"
          },
          body: requestBody);

      if (response.statusCode == 200) {
        setState(() {
          isVerified = true;
        });
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
              "Email Id has been verified.",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ));
      } else {
        setState(() {
          loading = false;
        });
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
              "Email Id not found. Please try again",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ));
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      print("Error ${error}");
    } finally {
      setState(() {
        loading = false;
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
              "Personal Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Salutation"),
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
              height: 40,
              child: DropdownButtonFormField<int>(
                key: const PageStorageKey('salutationValue'),
                style: const TextStyle(color: Colors.black),
                value: salutaionValue,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                ),
                isExpanded: true,
                dropdownColor: Colors.white,
                hint: const Text(
                  'Select',
                  style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
                ),
                onChanged: (int? value) {
                  setState(() {
                    salutaionValue = value;
                    setSaluationValue(value);
                  });
                },
                items: _salutaionValues
                    .map<DropdownMenuItem<int>>((dynamic state) {
                  final id = state['value'] as int;
                  final name = state['name'];
                  return DropdownMenuItem<int>(
                    value: id,
                    child: Text(name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("First Name"),
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
              height: 40,
              child: TextField(
                controller: _firstNamecontroller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter firstname',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setFirstName(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Last Name"),
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
              height: 40,
              child: TextField(
                controller: _lastNamecontroller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter lastname',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setLastName(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Customer Type"),
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
              height: 40,
              child: DropdownButtonFormField<int>(
                style: const TextStyle(color: Colors.black),
                value: customerType,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                ),
                isExpanded: true,
                dropdownColor: Colors.white,
                hint: const Text(
                  'Select the Customer Type',
                  style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
                ),
                onChanged: (int? value) async {
                  setState(() {
                    customerType = value;
                  });
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('contactType');
                  _contactTypes = [];
                  setCustomerTypeValue(value);
                  fetchContactTypes(value);
                },
                items:
                    _customerTypes.map<DropdownMenuItem<int>>((dynamic state) {
                  final id = state['id'];
                  final name = state['customer_type'];
                  return DropdownMenuItem<int>(
                    value: id,
                    child: Text(name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Contact Type"),
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
              height: 40,
              child: DropdownButtonFormField<int>(
                style: const TextStyle(color: Colors.black),
                value: contactType,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                ),
                isExpanded: true,
                dropdownColor: Colors.white,
                hint: const Text(
                  'Select',
                  style: TextStyle(color: Color.fromARGB(255, 117, 116, 116)),
                ),
                onChanged: (int? value) {
                  setState(() {
                    contactType = value;
                    setContactTypeValue(value);
                  });
                },
                items:
                    _contactTypes.map<DropdownMenuItem<int>>((dynamic state) {
                  final id = state['id'];
                  final name = state['contact_type'];
                  return DropdownMenuItem<int>(
                    value: id,
                    child: Text(name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Unique Number"),
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
              height: 40,
              child: TextField(
                controller: _uniqueController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Unique Identification Number',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setUniqueNo(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Mobile Code"),
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
              height: 40,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Select country code',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  suffixIcon: Icon(Icons.arrow_drop_down),
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
                        _controller.text = selectedItem!;
                        countryCode = country.phoneCode.toString();
                        setMobileCode(countryCode, selectedItem);
                        print("selectedItem ${selectedItem}");
                        print("countryCode ${country.phoneCode}");
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
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Mobile Number"),
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
              height: 40,
              child: TextField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Mobile number',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setMobileNumber(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text("Mobile Status"),
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
                    transform: Matrix4.translationValues(-11.0, 0.0, 0.0),
                    child: RadioListTile<int>(
                      contentPadding: const EdgeInsets.all(0),
                      title:
                          const Text('Pending', style: TextStyle(fontSize: 15)),
                      value: 1,
                      groupValue: _mobileStatus,
                      onChanged: (int? value) {
                        setState(() {
                          _mobileStatus = value!;
                          setMobileStatus(value);
                          print(" value ${value}");
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    transform: Matrix4.translationValues(-50.0, 0.0, 0.0),
                    child: RadioListTile<int>(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        'DND Number',
                        style: TextStyle(fontSize: 15),
                      ),
                      value: 2,
                      groupValue: _mobileStatus,
                      onChanged: (int? value) {
                        setState(() {
                          _mobileStatus = value!;
                          setMobileStatus(value);
                          print(" value ${value}");
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(-10.0, -18.0, 0.0),
              child: RadioListTile<int>(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Non-DND Number',
                  style: TextStyle(fontSize: 15),
                ),
                value: 3,
                groupValue: _mobileStatus,
                onChanged: (int? value) {
                  setState(() {
                    _mobileStatus = value!;
                    setMobileStatus(value);
                    print(" value ${value}");
                  });
                },
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: const Text("Email"),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Email',
                  suffixIcon: const Icon(
                    Icons.verified_user,
                    size: 20,
                  ),
                  suffixIconColor:
                      isVerified == true ? Colors.green : Colors.grey,
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setVerifyEmail(value);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            loading
                ? TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      minimumSize: WidgetStateProperty.all(const Size(30, 30)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 37, 170, 81)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {},
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                : TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      minimumSize: WidgetStateProperty.all(const Size(30, 30)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 37, 170, 81)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      verifyEmail();
                    },
                    child: const Text(
                      "Verify",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Text("Email Status"),
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
                    transform: Matrix4.translationValues(-11.0, 0.0, 0.0),
                    child: RadioListTile<int>(
                      contentPadding: const EdgeInsets.all(0),
                      title:
                          const Text('Pending', style: TextStyle(fontSize: 15)),
                      value: 1,
                      groupValue: _EmailStatus,
                      onChanged: (int? value) {
                        setState(() {
                          _EmailStatus = value!;
                          setEmailStatus(value);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    transform: Matrix4.translationValues(-50.0, 0.0, 0.0),
                    child: RadioListTile<int>(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        'Save to Send',
                        style: TextStyle(fontSize: 15),
                      ),
                      value: 2,
                      groupValue: _EmailStatus,
                      onChanged: (int? value) {
                        setState(() {
                          _EmailStatus = value!;
                          setEmailStatus(value);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(-10.0, -18.0, 0.0),
              child: RadioListTile<int>(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Not Safe to Send',
                  style: TextStyle(fontSize: 15),
                ),
                value: 3,
                groupValue: _EmailStatus,
                onChanged: (int? value) {
                  setState(() {
                    _EmailStatus = value!;
                    setEmailStatus(value);
                  });
                },
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -18.0, 0.0),
              child: const Text("Other Number"),
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _otherNumber,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Other number',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setOtherNumber(value);
                },
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            const Text("City"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                style: const TextStyle(fontSize: 14),
                controller: _searchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xff6546d2), width: 1)),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black, width: .5),
                    ),
                    hintText: 'Search...',
                    hintStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        fetchCities(_searchController.text.toLowerCase());
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xff6546d2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: const Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Locality"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                style: const TextStyle(fontSize: 14),
                controller: _localityController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xff6546d2), width: 1)),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black, width: .5),
                    ),
                    hintText: 'Search...',
                    hintStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        fetchLocalities(_localityController.text.toLowerCase());
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xff6546d2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: const Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Pincode"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _pinController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Pincode',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setPinCode(value);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Address"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter Address',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 128, 124, 124),
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                style: const TextStyle(
                  fontSize: 13,
                ),
                onChanged: (value) {
                  setAddress(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
