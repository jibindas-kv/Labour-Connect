import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_Work_Acc_Rej extends StatefulWidget {
  const Worker_Work_Acc_Rej({super.key});

  @override
  State<Worker_Work_Acc_Rej> createState() => _Worker_Work_Acc_RejState();
}

class _Worker_Work_Acc_RejState extends State<Worker_Work_Acc_Rej> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                "Approval",
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
                    height: 725.h,
                    width: double.infinity,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Column(children: [Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.black,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer Name',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Prefered Work',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),],),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Issue Of Customer',
                              hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none, // Removes border outline
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Address',
                              hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
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
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
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
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Date',
                              hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
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
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Time',
                              hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Approve button action
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(24),
                                backgroundColor: Colors.black,
                              ),
                              child: Icon(Icons.check, color: Colors.white, size: 32),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Reject button action
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(24),
                                backgroundColor: Colors.red,
                              ),
                              child: Icon(Icons.close, color: Colors.white, size: 32),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}