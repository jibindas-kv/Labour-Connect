import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_Work_Status extends StatefulWidget {
  const Worker_Work_Status({super.key});

  @override
  State<Worker_Work_Status> createState() => _Worker_Work_StatusState();
}

class _Worker_Work_StatusState extends State<Worker_Work_Status> {
  @override

  String _status = 'Completed';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                "Work Status",
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
                          child: Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15, bottom: 10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 70.w,
                                        width: 70.w,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("assets/Person.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(10.r)),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 90.h,
                                  ),
                                  Wrap(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Preffered Work",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "Time",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "Place",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              "Add Status",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Radio<String>(
                                        activeColor: Colors.black,
                                        value: 'Completed',
                                        groupValue: _status,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _status = value!;
                                          });
                                        },
                                      ),
                                      Text('Completed',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(width: 20.w), // Space between containers
                                  Row(
                                    children: [
                                      Radio<String>(
                                        hoverColor: Colors.blue,
                                        activeColor: Colors.black,
                                        value: 'Not Completed',
                                        groupValue: _status,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _status = value!;
                                          });
                                        },
                                      ),
                                      Text('Not Completed',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Container(
                          child: _status == "Completed"
                              ? Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              Container(
                                height: 60.h,
                                width: 250.w,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.currency_rupee),
                                      hintText: "amount",
                                      prefix: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 15.sp,
                                      ),
                                      focusColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                              ),
                              SizedBox(
                                height: 60.h,
                              ),
                              InkWell(
                                onTap: () {
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 230.w,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10.r)),
                                  child: Center(
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          )
                              : Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    "Denial Reason",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 30, right: 30),
                                child: Container(
                                  child: TextFormField(
                                    minLines: 5,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        hintText: "Denial reason",
                                        prefix: Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                        focusColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        fillColor: Colors.white,
                                        filled: true),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              InkWell(
                                onTap: () {
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 230.w,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10.r)),
                                  child: Center(
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}