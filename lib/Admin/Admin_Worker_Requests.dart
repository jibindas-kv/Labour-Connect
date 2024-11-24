import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_WorkerListView.dart';
import 'package:labour_connect/Admin/Approval_Page.dart';
import 'package:labour_connect/Admin/Transcation_Details.dart';
import 'package:labour_connect/main.dart';

class Admin_Worker_Requests extends StatefulWidget {
  const Admin_Worker_Requests({super.key});

  @override
  State<Admin_Worker_Requests> createState() => _Admin_Worker_RequestsState();
}

class _Admin_Worker_RequestsState extends State<Admin_Worker_Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Requests",
              style: TextStyle(
                fontSize: 45.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  height: 731.h,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Approval_Page();},));
                          },
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Worker Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.sp),
                                  ),
                                  Text(
                                    "12/11/2024",
                                    style: TextStyle(
                                        color: Colors.grey[700], fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
