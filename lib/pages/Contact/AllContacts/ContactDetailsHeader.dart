import 'package:flutter/material.dart';

class Contactdetailsheader extends StatefulWidget {
  const Contactdetailsheader({super.key});

  @override
  State<Contactdetailsheader> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Contactdetailsheader> {
  List<Map<String, String>> menuItems = [
    {"name": "Export", "value": "Export"},
    {"name": "Import", "value": "Import"},
    {"name": "Advanced Search", "value": "Advanced Search"},
    {"name": "Create Group", "value": "Create Group"},
    {"name": "Properties", "value": "Properties"},
    {"name": "Requirements", "value": "Requirements"},
    {"name": "Send Email", "value": "Send Email"},
    {"name": "Send SMS", "value": "Send SMS"},
    {"name": "Send Whatsapp", "value": "Send Whatsapp"},
    {"name": "Email T & C", "value": "Email T & C"},
    {"name": "Transfer", "value": "Transfer"},
    {"name": "Videos", "value": "Videos"},
  ];

  List<Map<String, String>> menuItems2 = [
    {'name': 'Lead', 'value': 'Lead'},
    {'name': 'Owner', 'value': 'Owner'},
    {'name': 'Tenant', 'value': 'Tenant'},
    {'name': 'Vendor', 'value': 'Vendor'},
  ];
  String isSelected = "home";
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
              child: GestureDetector(
            onTap: () {
              setState(() {
                isSelected = "home";
                Navigator.pop(context);
              });
            },
            child: Icon(
              size: 24,
              Icons.arrow_back,
              color:
                  isSelected == "home" ? const Color(0xff6546D2) : Colors.black,
            ),
          )),
        ),
        Expanded(
          child: Center(
              child: GestureDetector(
            onTap: () {
              setState(() {
                isSelected = "contact";
              });
            },
            child: Icon(
              size: 25,
              Icons.history,
              color: isSelected == "contact" ? Colors.black : Colors.black,
            ),
          )),
        ),
        Expanded(
          child: Center(
              child: GestureDetector(
            onTap: () {
              setState(() {
                isSelected = "contact";
              });
            },
            child: Icon(
              size: 26,
              Icons.edit_note,
              color: isSelected == "contact"
                  ? const Color(0xff6546D2)
                  : Colors.black,
            ),
          )),
        ),
        Expanded(
          child: Center(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = "menu";
                    });
                    showMenu(
                      color: Colors.white,
                      context: context,
                      position: const RelativeRect.fromLTRB(220, 150, 15, 0),
                      items: menuItems.map((item) {
                        return PopupMenuItem(
                          height: 35,
                          value: item['value'],
                          child: Text(
                            item['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        );
                      }).toList(),
                    ).then((value) {
                      if (value != null) {
                        if (value == "Export") {
                          Navigator.pushNamed(context, "/exportContact");
                        } else if (value == "Import") {
                          Navigator.pushNamed(context, "/importContact");
                        } else if (value == "Advanced Search") {
                          Navigator.pushNamed(context, "/advanceSearch");
                        } else if (value == "Create Group") {
                          Navigator.pushNamed(context, "/createGroup");
                        } else if (value == "Send Email") {
                          Navigator.pushNamed(context, "/sendEmail");
                        } else if (value == "Send SMS") {
                          Navigator.pushNamed(context, "/sendSMS");
                        } else if (value == "Send Whatsapp") {
                          Navigator.pushNamed(context, "/sendWhatsApp");
                        }
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 19,
                        Icons.format_list_bulleted_outlined,
                        color: isSelected == "menu"
                            ? const Color(0xff6546D2)
                            : Colors.black,
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ))),
        ),
        Expanded(
          child: Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = "folder";
                  });
                  showMenu(
                          color: Colors.white,
                          context: context,
                          position:
                              const RelativeRect.fromLTRB(220, 150, 15, 0),
                          items: menuItems2.map((item) {
                            return PopupMenuItem(
                              height: 35,
                              value: item['value'],
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList())
                      .then((value) {
                    if (value != null) {
                      print("Selected: $value");
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      size: 20,
                      Icons.share_sharp,
                      color: isSelected == "folder"
                          ? const Color(0xff6546D2)
                          : Colors.black,
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
