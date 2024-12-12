import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_Notification extends StatefulWidget {
  const Worker_Notification({super.key});

  @override
  State<Worker_Notification> createState() => _Worker_NotificationState();
}

class _Worker_NotificationState extends State<Worker_Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Notifications",
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
                  child:StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Worker_Notification")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      final CustomerNotification = snapshot.data?.docs ?? [];
                      return ListView.builder(

                        itemCount: CustomerNotification.length,
                        itemBuilder: (context, index) {
                          final doc = CustomerNotification[index];
                          final customernoti= doc .data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.black,width: 2)),
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${customernoti["Content"] ?? ""}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "${customernoti["Time"] ?? ""}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            "${customernoti["Content"] ?? ""}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },);
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






