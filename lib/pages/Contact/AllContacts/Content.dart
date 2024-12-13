import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ContentPage> {
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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    "Rent Reminder",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.create_sharp,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Message :",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Greetings from propension india pvt ltd!!! As you have shown an interest in finding the property for rental/buy/sale. Kindly share your preferred requirements or please feel free to reach us through the same contact number so that I can help you to find real estate needs number so that I can help you to find real estate needs. number so that I can help you to find real estate needs.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE6E4FD),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Rent Reminder",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )))),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xfffdfaff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Rent Reminder",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )))),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xfffdfaff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Rent Reminder",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )))),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xfffdfaff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Rent Reminder",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )))),
                            ],
                          ),
                        )),
                  )),
            ],
          ),
        ));
  }
}
