import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hibroker/components/Environment/Environment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfessionalInfo extends StatefulWidget {
  const ProfessionalInfo({super.key});

  @override
  State<ProfessionalInfo> createState() => _MyWidgetState();
}

final TextEditingController _comapanyController = TextEditingController();
final TextEditingController _businessController = TextEditingController();
final TextEditingController _comapanyTypeController = TextEditingController();
final TextEditingController _designationController = TextEditingController();
final TextEditingController _investCapacityController = TextEditingController();
final TextEditingController _bankNameController = TextEditingController();
final TextEditingController _bankAccountController = TextEditingController();
final TextEditingController _ifscController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _searchController = TextEditingController();
final TextEditingController _localityController = TextEditingController();

class _MyWidgetState extends State<ProfessionalInfo> {
  String company = _comapanyController.text.trim();
  String? business = _businessController.text.trim();
  String? companyType = _comapanyTypeController.text.trim();
  String? designation = _designationController.text.trim();
  String? investCapacity = _investCapacityController.text.trim();
  String? bankName = _bankNameController.text.trim();
  String? bankAcc = _bankAccountController.text.trim();
  String? ifsc = _ifscController.text.trim();
  String? address = _addressController.text.trim();
  String? searchData = _searchController.text.trim();
  String? searchLocalityData = _localityController.text.trim();
  List<dynamic> cities = [];
  List<dynamic> localities = [];

  void setCompany(String? company) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('company', company ?? "");
  }

  void setBusiness(String? business) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('business', business ?? "");
  }

  void setCompanyType(String? companyType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('companyType', companyType ?? "");
  }

  void setDesignation(String? designation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('designation', designation ?? "");
  }

  void setInvestCapacity(String? investCapacity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('investCapacity', investCapacity ?? "");
  }

  void setBankName(String? bankName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bankName', bankName ?? "");
  }

  void setBankAcc(String? bankAcc) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bankAcc', bankAcc ?? "");
  }

  void setIFSC(String? ifsc) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ifsc', ifsc ?? "");
  }

  void setAddress(String? address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address ?? "");
  }

  void setCity(String profCity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profCity', profCity);
  }

  void setLocality(String profLocality) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profLocality', profLocality);
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
    String? _cityName = prefs.getString('profCity');
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
              ),
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
              ),
            ],
          ),
        );
      },
    );
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
              "Professional Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Company"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _comapanyController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter company',
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
                  setCompany(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Business"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _businessController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter business',
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
                  setBusiness(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Company Type"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _comapanyTypeController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter company type',
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
                  setCompanyType(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Designation"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _designationController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter designation',
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
                  setDesignation(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Invest Capacity"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _investCapacityController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter invest capacity',
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
                  setInvestCapacity(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Bank Name"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _bankNameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter bank name',
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
                  setBankName(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Bank A/C"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _bankAccountController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter Bank A/C',
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
                  setBankAcc(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("IFSC Code"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _ifscController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter IFSC Code',
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
                  setIFSC(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
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
