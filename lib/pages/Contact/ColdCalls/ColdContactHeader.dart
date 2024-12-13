import 'package:flutter/material.dart';

class ColdContactHeader extends StatefulWidget {
  const ColdContactHeader({super.key});

  @override
  State<ColdContactHeader> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ColdContactHeader> {
  List<Map<String, String>> menuItems2 = [
    {'name': 'Export', 'value': 'Export'},
    {'name': 'Import', 'value': 'Import'},
    {'name': 'Advanced Search', 'value': 'Advanced Search'},
    {'name': 'Create Group', 'value': 'Create Group'},
    {'name': 'Transfer', 'value': 'Transfer'},
    {'name': 'Videos', 'value': 'Videos'},
  ];
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
              Navigator.pushNamed(context, "/allContact");
            },
            child: const Icon(
              size: 24,
              Icons.home,
              color: Colors.black,
            ),
          )),
        ),
        Expanded(
          child: Center(
              child: GestureDetector(
                  onTap: () {
                    showMenu(
                      color: Colors.white,
                      context: context,
                      position: const RelativeRect.fromLTRB(220, 150, 15, 0),
                      items: menuItems2.map((item) {
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
                          Navigator.pushNamed(context, "/coldExport");
                        } else if (value == "Import") {
                          Navigator.pushNamed(context, "/coldImport");
                        } else if (value == "Advanced Search") {
                          Navigator.pushNamed(context, "/coldAdvanceSearch");
                        } else if (value == "Create Group") {
                          Navigator.pushNamed(context, "/coldCreateGroup");
                        }else if (value == "Transfer") {
                          Navigator.pushNamed(context, "/coldTransfer");
                        }
                      }
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 21,
                        Icons.format_list_bulleted_outlined,
                        color: Color(0xff6546D2),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xff6546D2),
                      ),
                    ],
                  ))),
        )
      ],
    );
  }
}
