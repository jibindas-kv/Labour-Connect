import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Transcation_Details extends StatefulWidget {
  const Transcation_Details({super.key});

  @override
  State<Transcation_Details> createState() => _Transcation_DetailsState();
}

class _Transcation_DetailsState extends State<Transcation_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              " Transcations \n Details",
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
                    height: 658.h,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 80, top: 50, left: 20, right: 20),
                      child: Container(
                        height: 30,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Text(
                              " FROM CUSTOMER NAME",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 138),
                                child: Row(
                                  children: [
                                    Text(
                                      "Phone number",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 105),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 59,
                                    ),
                                    Text(
                                      "527",
                                      style: TextStyle(
                                          fontSize: 59.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 145),
                                child: Row(
                                  children: [
                                    Text(
                                      "Completed",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.verified_outlined,
                                      size: 26,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 230, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Worker Name",
                        style: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "Requested Work",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "Painting",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "Payment method",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "UPI",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "11/01/2024",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "1:10",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "Transcation ID",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),],
                      ),
                      Row(
                        children: [Text(
                          "SXGHXXXX678",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),],
                      ),
                    ],
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
