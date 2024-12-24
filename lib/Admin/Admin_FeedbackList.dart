import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_Feedback_View.dart';

class Admin_FeedbackList extends StatefulWidget {
  const Admin_FeedbackList({super.key});

  @override
  State<Admin_FeedbackList> createState() => _Admin_FeedbackListState();
}

class _Admin_FeedbackListState extends State<Admin_FeedbackList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Feedbacks",
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
                        .where("Feedback", isNotEqualTo: "null")

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
                          final feedbacklt = doc.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Admin_Feedback_View(
                                      customer_name:
                                          feedbacklt["Customer_user_name"],
                                      worker_name: feedbacklt["Worker_Name"],
                                      needed_service:
                                          feedbacklt["NeededService"],
                                      feedback: feedbacklt["Feedback"],
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
                                        "${feedbacklt["Customer_user_name"] ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        "${feedbacklt["Date"] ?? ""}",
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
