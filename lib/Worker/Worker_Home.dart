import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_Add_Notification.dart';
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

class Worker_Home extends StatefulWidget {
  const Worker_Home({super.key});

  @override
  State<Worker_Home> createState() => _Worker_HomeState();
}

class _Worker_HomeState extends State<Worker_Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 36.sp,
                      ))
                ],
              ),
            ),
            Stack(
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                ),
                              ),
                              Container(
                                child: TabBar(
                                  indicator: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  dividerColor: Colors.white,
                                  tabs: [
                                    Tab(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Center(
                                          child: Text(
                                            'Requests',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Center(
                                          child: Text(
                                            'Accepted',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(children: [
                              Worker_Requests(),
                              Worker_Accepted(),
                            ]),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Worker_Requests extends StatefulWidget {
  const Worker_Requests({super.key});

  @override
  State<Worker_Requests> createState() => _Worker_RequestsState();
}

class _Worker_RequestsState extends State<Worker_Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Icon(
                        Icons.person,
                        size: 35.sp,
                      ),
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Preffered Work",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Place",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.info_outline,
                      size: 25.sp,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Worker_Accepted extends StatefulWidget {
  const Worker_Accepted({super.key});

  @override
  State<Worker_Accepted> createState() => _Worker_AcceptedState();
}

class _Worker_AcceptedState extends State<Worker_Accepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Icon(
                        Icons.person,
                        size: 35.sp,
                      ),
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Preffered Work",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Place",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Center(
                          child: Text(
                        "Pending",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
