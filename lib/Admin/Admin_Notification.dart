import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labour_connect/Admin/Admin_Add_Notifications.dart';

class Admin_Notification extends StatefulWidget {
  const Admin_Notification({super.key});

  @override
  State<Admin_Notification> createState() => _Admin_NotificationState();
}

class _Admin_NotificationState extends State<Admin_Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 70.h,
          width: 70.w,
          child: FloatingActionButton(
            shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add,
              size: 40.sp,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Admin_Add_Notifications();
              }));
            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 43.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  height: 718.h,
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('notifications')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final notifications = snapshot.data!.docs;

                      if (notifications.isEmpty) {
                        return Center(
                          child: Text(
                            "No Notifications Found",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index].data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification['heading'] ?? "No Heading",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      notification['content'] ?? "No Content",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      notification['target'] ?? "No Target",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
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
