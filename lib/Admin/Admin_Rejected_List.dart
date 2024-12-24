import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Approval_Page.dart';

class Admin_Rejected_List extends StatefulWidget {
  const Admin_Rejected_List({super.key});

  @override
  State<Admin_Rejected_List> createState() => _Admin_Rejected_ListState();
}

class _Admin_Rejected_ListState extends State<Admin_Rejected_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Rejects",
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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("WorkerLogin")
                        .where("approvel", isEqualTo: 2)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: Colors.black));
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: TextStyle(color: Colors.red, fontSize: 16.sp),
                          ),
                        );
                      }
                      final workers = snapshot.data?.docs ?? [];
                      if (workers.isEmpty) {
                        return Center(
                          child: Text(
                            "No Requests Found",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: workers.length,
                        itemBuilder: (context, index) {
                          final worker = workers[index].data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Approval_Page(
                                    worker_id:worker["worker_id"],
                                    worker_name:worker["Name"],
                                    worker_phn:worker["Phn_no"],
                                    worker_email:worker["Email"],
                                    worker_category:worker["SpecializedWork"],
                                    worker_date:worker["Date"],

                                  );
                                }));
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
                                        "${worker["Name"] }",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800, fontSize: 16.sp),
                                      ),
                                      Text(
                                        "${worker["Date"]}",
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
