import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Complaint_Listview extends StatefulWidget {
  const Complaint_Listview({super.key});

  @override
  State<Complaint_Listview> createState() => _Complaint_ListviewState();
}

class _Complaint_ListviewState extends State<Complaint_Listview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Complaint Details",
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
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Customer Name",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none, // Removes border outline
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Worker Name",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Preferred Work",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Complaint",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
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
