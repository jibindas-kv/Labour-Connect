import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Admin_CustomerListView.dart';

class Admin_Customer_List extends StatefulWidget {
  const Admin_Customer_List({super.key});

  @override
  State<Admin_Customer_List> createState() => _Admin_Customer_ListState();
}

class _Admin_Customer_ListState extends State<Admin_Customer_List> {
  // Reference to the Firestore collection
  final CollectionReference _customersRef =
  FirebaseFirestore.instance.collection('CustomerLogin'); // Replace 'customers' with your collection name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Customers",
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
                    stream: _customersRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No customers found",
                            style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                          ),
                        );
                      }
                      final customers = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Admin_CustomerListView();
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
                                        "${customer["Name"] ?? ""}", // Field name in Firestore
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                          "${customer["Date"] ?? ""}", // Assuming 'createdAt' is a field in your document
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
