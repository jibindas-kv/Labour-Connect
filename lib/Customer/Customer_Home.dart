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
import 'package:labour_connect/Customer/Customer_Navbar.dart';

class Customer_Home extends StatefulWidget {
  const Customer_Home({super.key});

  @override
  State<Customer_Home> createState() => _Customer_HomeState();
}

class _Customer_HomeState extends State<Customer_Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Customer_Navbar(),
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(backgroundColor: Colors.black,iconTheme: IconThemeData(color: Colors.white,size: 30.sp)),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,bottom: 15),
              child: TextFormField(

                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  suffixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r))),
                      height: 700.h,
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
                                              'Workers',
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
                                              'Status',
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
                                Workers(),
                                Status(),
                              ]),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Workers extends StatefulWidget {
  const Workers({super.key});

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GridView.builder(
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10,left: 5,right: 5),
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
                          image: DecorationImage(image: AssetImage("assets/Worker.png"),fit: BoxFit.cover),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r)),
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
                      Text("Online",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900),)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 20,top: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name Of Worker",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Requested Work",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 30.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Center(
                                child: Text(
                                  "Pay",
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold, fontSize: 16.sp),
                                )),
                          )
                        ],
                      )
                    ],
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
