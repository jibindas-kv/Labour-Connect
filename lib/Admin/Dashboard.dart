import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_Notification.dart';
import 'package:labour_connect/Admin/Admin_ComplaintList.dart';
import 'package:labour_connect/Admin/Admin_FeedbackList.dart';
import 'package:labour_connect/Admin/Admin_WorkerListView.dart';
import 'package:labour_connect/Admin/Admin_Worker_Requests.dart';
import 'package:labour_connect/Admin/Admin_Workers_Work_Add.dart';
import 'package:labour_connect/Admin/Approval_Page.dart';
import 'package:labour_connect/Admin/Admin_Rejected_List.dart';
import 'package:labour_connect/Admin/Payments.dart';
import 'package:labour_connect/Admin/Admin_Worker_List.dart';
import 'package:labour_connect/Admin/Admin_Customer_List.dart';
import 'package:labour_connect/Worker/Worker_Authgate.dart';

import 'Admin_Login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.admin_panel_settings_outlined,
                      color: Colors.white,
                      size: 40.sp,
                    )),
                IconButton(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Worker_Authgate();
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 36.sp,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r))),
                    height: 770.h,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Admin_Customer_List();},));
                                  },
                                  child: Container(
                                    height: 180.sp,
                                    width: 180.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection("CustomerLogin")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            final count =
                                                snapshot.data?.docs.length ?? 0;
                                            return Text(
                                              "$count",
                                              style: TextStyle(
                                                fontSize: 60.sp,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            );
                                          },
                                        ),
                                        Text(
                                          "Customers",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Admin_Worker_List();},));
                                  },
                                  child: Container(
                                    height: 180.sp,
                                    width: 180.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection("WorkerLogin")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            final count =
                                                snapshot.data?.docs.length ?? 0;
                                            return Text(
                                              "$count",
                                              style: TextStyle(
                                                fontSize: 60.sp,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            );
                                          },
                                        ),
                                        Text(
                                          "Workers",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Payments();},));
                                  },
                                  child: Container(
                                    height: 180.sp,
                                    width: 180.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection("Customer_request")
                                              .where("Payment", whereIn: [4, 5]) // Filter for Payment == 4 or 5
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            final count = snapshot.data?.docs.length ?? 0;
                                            return Text(
                                              "$count",
                                              style: TextStyle(
                                                fontSize: 60.sp,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            );
                                          },
                                        ),
                                        Text(
                                          "Payments",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Admin_Worker_Requests();
                                    },));
                                  },
                                  child: Container(
                                    height: 180.sp,
                                    width: 180.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person_add_outlined,
                                          size: 80.sp,
                                        ),
                                        Text(
                                          "Approve",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Admin_Rejected_List();
                                },));
                              },
                              child: Container(
                                height: 60.sp,
                                width: 450.sp,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rejected Workers",
                                            style: TextStyle(
                                                fontSize: 23.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Icon(
                                            Icons.info_outline,size: 30.sp,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Admin_Workers_Work_Add();
                                },));
                              },
                              child: Container(
                                height: 60.sp,
                                width: 450.sp,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Works",
                                            style: TextStyle(
                                                fontSize: 23.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Icon(
                                            Icons.note_add_outlined,size: 30.sp,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Admin_FeedbackList();
                                        },));
                                      },
                                      child: Container(
                                        height: 80.sp,
                                        width: 180.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Feedback",
                                              style: TextStyle(
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Admin_ComplaintList();},));
                                      },
                                      child: Container(
                                        height: 80.sp,
                                        width: 180.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Complaints",
                                              style: TextStyle(
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Admin_Notification();},));
                                      },
                                      child: Container(
                                        height: 170.sp,
                                        width: 180.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10.sp,
                                                ),
                                                Icon(
                                                  Icons.notification_add_outlined,
                                                  size: 70.sp,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Notification",
                                              style: TextStyle(
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
