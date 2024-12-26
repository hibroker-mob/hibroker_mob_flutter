import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Lead/CreateLead/LeadInformation.dart';
import 'package:hibroker/pages/Lead/CreateLead/LeadSave.dart';

class Createlead extends StatefulWidget {
  const Createlead({super.key});

  @override
  State<Createlead> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Createlead> {
  String? tabName = "Lead Information";

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
              const Text(
                "Create Lead",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        tabName = "Lead Information";
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: tabName == "Lead Information"
                                ? const Color(0xff6546d2)
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.person_rounded,
                                color: tabName == "Lead Information"
                                    ? Colors.white
                                    : const Color(0xff8C91B6),
                                size: 33,
                              ),
                            ),
                            Text(
                              "Lead Information",
                              style: TextStyle(
                                color: tabName == "Lead Information"
                                    ? Colors.white
                                    : const Color(0xff8C91B6),
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        tabName = "Save&Publish";
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: tabName == "Save&Publish"
                                ? const Color(0xff6546d2)
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.public,
                                color: tabName == "Save&Publish"
                                    ? Colors.white
                                    : const Color(0xff8C91B6),
                                size: 33,
                              ),
                            ),
                            Text(
                              "Save & Publish",
                              style: TextStyle(
                                color: tabName == "Save&Publish"
                                    ? Colors.white
                                    : const Color(0xff8C91B6),
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (tabName == "Lead Information")
                const Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: [const LeadInformation()],
                  ),
                )))
              else
                const Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: [const LeadSave()],
                  ),
                )))
            ],
          ),
        ));
  }
}
