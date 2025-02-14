import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Rejected_Reason extends StatefulWidget {
  const Rejected_Reason({super.key});

  @override
  State<Rejected_Reason> createState() => _Rejected_ReasonState();
}

class _Rejected_ReasonState extends State<Rejected_Reason> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30,left: 20),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios,color: Colors.white,),
                ],
              ),
            ),
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
                                    'Worker Name',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Phone Number',
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
                              hintText: 'Address of worker',
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
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                              hintText: 'Work Category',
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
