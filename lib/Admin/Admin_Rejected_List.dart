import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:labour_connect/Admin/Approval_Page.dart';

class Admin_Rejected_List extends StatefulWidget {
  const Admin_Rejected_List({super.key});

  @override
  State<Admin_Rejected_List> createState() => _Admin_Rejected_ListState();
}

class _Admin_Rejected_ListState extends State<Admin_Rejected_List> {
  String formatDate(Timestamp timestamp) {
    return DateFormat('dd/MM/yyyy').format(timestamp.toDate());
  }
  // Reference to the Firestore collection
  final CollectionReference workersRef =
  FirebaseFirestore.instance.collection('WorkerLogin');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Rejected",
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
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  height: 731.h,
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: workersRef
                        .where('status', isEqualTo: 'rejected') // Filter by status
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No rejected workers found",
                            style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                          ),
                        );
                      }
                      final rejectedWorkers = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: rejectedWorkers.length,
                        itemBuilder: (context, index) {
                          final worker = rejectedWorkers[index];
                          final name = worker['Name'];
                          final rejectedAt = worker['rejectedAt'] ?? 'Unknown';

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Approval_Page();
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
                                  padding:
                                  const EdgeInsets.only(left: 10, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                  Text(
                                  formatDate(worker['rejectedAt']),
                                  style: TextStyle(color: Colors.grey[700], fontSize: 12.sp),
                                ),
                                      Text(
                                        name, // Worker name
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        rejectedAt,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
