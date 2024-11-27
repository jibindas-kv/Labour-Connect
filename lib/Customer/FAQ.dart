import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Customer/Contact_Us.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children:  [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [

          SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Frequently Asked Questions",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,
                    fontSize: 30.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          ExpansionTile(
            title: Text(
              "What is Labour Connect?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Labour Connect is an application designed to connect daily wage workers with customers looking for their services. It facilitates seamless communication and provides a platform to bridge the gap between the two.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "How does Labour Connect work?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Customers can post job requirements on the platform, and workers can browse and apply for these opportunities. Communication between both parties is facilitated directly through the app.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Is Labour Connect free to use?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Yes, Labour Connect is free for workers and customers to register and use. Some premium features may require a subscription or fee in the future.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "What kind of jobs can I find on Labour Connect?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You can find various types of jobs, including construction, plumbing, electrical work, housekeeping, and other daily wage opportunities.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "How can I contact customer support?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You can reach our customer support team via email at support@labourconnect.com or call us at +123 456 7890.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
                ],
              ),
              SizedBox(height: 400.h,),
              Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Need More Help ? ",
                          style: TextStyle(fontSize: 17),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return ContactUs();
                            },));
                          },
                          child: Text(
                            "Contact Us",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],

      ),
    );
  }
}
