import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_AccRej extends StatefulWidget {
  const Worker_AccRej({super.key});

  @override
  State<Worker_AccRej> createState() => _Worker_AccRejState();
}

class _Worker_AccRejState extends State<Worker_AccRej> {
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
                      padding: const EdgeInsets.only(bottom: 80,top: 50,left: 20,right: 20),
                      child: Container(
                        height: 25,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [Text(" FROM CUSTOMER NAME",style: TextStyle(),)],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
