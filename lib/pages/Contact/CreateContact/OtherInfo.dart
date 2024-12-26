import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherInfo extends StatefulWidget {
  const OtherInfo({super.key});

  @override
  State<OtherInfo> createState() => _MyWidgetState();
}

final TextEditingController _dobController = TextEditingController();
final TextEditingController _aniversaryController = TextEditingController();
final TextEditingController _faxController = TextEditingController();
final TextEditingController _webSiteController = TextEditingController();
final TextEditingController _skypeController = TextEditingController();
final TextEditingController _remarkController = TextEditingController();

class _MyWidgetState extends State<OtherInfo> {
  String? faxNumber = _faxController.text.trim();
  String? webSite = _webSiteController.text.trim();
  String? skype = _skypeController.text.trim();
  String? remark = _remarkController.text.trim();
  RangeValues _currentRangeValues = const RangeValues(0, 0);
  bool? isCheckedSMS = false;
  bool? isCheckedEmail = false;
  bool isCheckedWhatsApp = false;
  bool? isDocument = false;
  String? selectedDOB;
  String? selectedAniversary;
  String? rating;

  void setDOB(String? dob) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dob', dob ?? "");
  }

  void setAniversary(String? aniversary) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('aniversary', aniversary ?? "");
  }

  void setSMSGreet(bool? smsGreet) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('smsGreet', smsGreet ?? false);
  }

  void setEmailGreet(bool? emailGreet) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('emailGreet', emailGreet ?? false);
  }

  void setwhatsappGreet(bool? whatsappGreet) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('whatsappGreet', whatsappGreet ?? false);
  }

  void setFaxNumber(String? fax) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fax', fax ?? "");
  }

  void setWebsite(String? webSite) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('webSite', webSite ?? "");
  }

  void setSkype(String? skype) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('skype', skype ?? "");
  }

  void setRating(String? rating) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rating', rating ?? "");
  }

  void setRemark(String? remark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('remark', remark ?? "");
  }

  @override
  void initState() {
    super.initState();
    fetchOtherInfo();
  }

  void fetchOtherInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _dob = prefs.getString('dob');
    String? _aniversary = prefs.getString('aniversary');
    bool? _smsGreet = prefs.getBool('smsGreet');
    bool? _mailGreet = prefs.getBool('emailGreet');
    bool? _whatsappGreet = prefs.getBool('whatsappGreet');
    String? _ratingScale = prefs.getString('rating');
    print("_ratingScale ${_ratingScale}");
    if (_dob != null) {
      setState(() {
        selectedDOB = _dob;
      });
    }

    if (_aniversary != null) {
      setState(() {
        selectedAniversary = _aniversary;
      });
    }
    if (_smsGreet != null) {
      isCheckedSMS = _smsGreet;
    }
    if (_mailGreet != null) {
      isCheckedEmail = _mailGreet;
    }
    if (_whatsappGreet != null) {
      isCheckedWhatsApp = _whatsappGreet;
    }
    if (_ratingScale != null) {
      double? scale = double.tryParse(_ratingScale);

      if (scale != null) {
        _currentRangeValues = RangeValues(0, scale);
      }
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
              primary: Color(0xff005258),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff005258),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDOB = "${pickedDate.toLocal()}".split(' ')[0];
        _dobController.text = selectedDOB!;
        setDOB("${pickedDate.toLocal()}".split(' ')[0]);
        print("date ${selectedDOB}");
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
              primary: Color(0xff005258),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff005258),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedAniversary = "${pickedDate.toLocal()}".split(' ')[0];
        _aniversaryController.text = selectedAniversary!;
        setAniversary("${pickedDate.toLocal()}".split(' ')[0]);
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
              "Other Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("DOB"),
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
                  hintText: selectedDOB ?? "yyyy-mm-dd",
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
              height: 20,
            ),
            const Text("Aniversary"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _aniversaryController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  hintText: selectedAniversary ?? "yyyy-mm-dd",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_outlined,
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
              height: 20,
            ),
            const Text("Send Greeting Wishes"),
            Row(
              children: [
                Container(
                  transform: Matrix4.translationValues(-12.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color(0xFF6546D2);
                            }
                            return Colors.white;
                          },
                        ),
                        value: isCheckedSMS,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedSMS = value!;
                            setSMSGreet(value);
                          });
                        },
                      ),
                      const Text(
                        "SMS",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0xFF6546D2);
                          }
                          return Colors.white;
                        },
                      ),
                      value: isCheckedEmail,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedEmail = value!;
                          setEmailGreet(value);
                        });
                      },
                    ),
                    const Text(
                      "Eamil",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                const SizedBox(
                  width: 7,
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0xFF6546D2);
                          }
                          return Colors.white;
                        },
                      ),
                      value: isCheckedWhatsApp,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedWhatsApp = value!;
                          setwhatsappGreet(value);
                        });
                      },
                    ),
                    const Text(
                      "WhatsApp",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Fax Number"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _faxController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter Fax Number',
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
                  setFaxNumber(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Website"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _webSiteController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter Website',
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
                  setWebsite(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Skype"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _skypeController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter Skype',
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
                  setSkype(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Rating Scale: ${_currentRangeValues.end.round()}',
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
                    setRating(_currentRangeValues.end.round().toString());
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Customer's Remark"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                controller: _remarkController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: .5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter Customer Remark',
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
                  setRemark(value);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                    checkColor: Colors.white,
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return const Color(0xFF6546D2);
                        }
                        return Colors.white;
                      },
                    ),
                    value: isDocument,
                    onChanged: (bool? value) {
                      setState(() {
                        isDocument = value!;
                      });
                      if (value!) {
                        Navigator.pushNamed(context, "/createContact",
                            arguments: {
                              'tabName': "Document",
                              "isNewTab": value
                            });
                      }
                    }),
                const Text(
                  "Do you have any document to upload ?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
