import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_Feedback_View.dart';

import 'Admin_ComplaintListView.dart';

class Admin_ComplaintList extends StatefulWidget {
  const Admin_ComplaintList({super.key});

  @override
  State<Admin_ComplaintList> createState() => _Admin_ComplaintListState();
}

class _Admin_ComplaintListState extends State<Admin_ComplaintList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Complaints",
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
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Customer_request")
                        .where("complaint", isNotEqualTo: "null")

                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      final Feedbacklist = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        itemCount: Feedbacklist.length,
                        itemBuilder: (context, index) {
                          final doc = Feedbacklist[index];
                          final complaintlt = doc.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Complaint_Listview(
                                      customerName:complaintlt["Customer_user_name"],
                                      workerName:complaintlt["Worker_Name"],
                                      neededService:complaintlt["NeededService"],
                                      feedback:complaintlt["complaint"],
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${complaintlt["Customer_user_name"] ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        "${complaintlt["Date"] ?? ""}",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
