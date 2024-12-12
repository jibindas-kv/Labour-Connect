import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_WorkerListView.dart';
import 'package:labour_connect/Admin/Transcation_Details.dart';
import 'package:labour_connect/main.dart';

class Admin_Worker_List extends StatefulWidget {
  const Admin_Worker_List({super.key});

  @override
  State<Admin_Worker_List> createState() => _Admin_Worker_ListState();
}

class _Admin_Worker_ListState extends State<Admin_Worker_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Workers",
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
                        .collection("WorkerLogin")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      final Workerlist = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        itemCount: Workerlist.length,
                        itemBuilder: (context, index) {
                          final doc = Workerlist[index];
                          final Workerlt = doc.data() as Map<String,dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Admin_WorkerListView();},));
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
                                      Text("${Workerlt["Name"] ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.sp),
                                      ),
                                      Text("${Workerlt["Date"] ?? ""}",
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
