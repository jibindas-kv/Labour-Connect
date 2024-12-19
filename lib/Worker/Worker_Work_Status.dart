import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Worker/Worker_Home.dart';

class Worker_Work_Status extends StatefulWidget {
  const Worker_Work_Status({
    super.key,
    required this.id,
    required this.Work,
    required this.Name,
    required this.Date,
    required this.Time,
    required this.Place,
  });

  final String id;
  final String Work;
  final String Name;
  final String Date;
  final String Time;
  final String Place;

  @override
  State<Worker_Work_Status> createState() => _Worker_Work_StatusState();
}

class _Worker_Work_StatusState extends State<Worker_Work_Status> {
  late String _status;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _status = 'Completed'; // Default value
      _isLoading = false;
    });
  }



  var Amount_ctrl = TextEditingController();
  Future<void> Amount_add() async {
    FirebaseFirestore.instance
        .collection("Customer_request")
        .doc(widget.id)
        .update({'Amount': Amount_ctrl.text, 'Payment': 3});
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Worker_Home();
      },
    ));
  }

  var Reject_res_ctrl = TextEditingController();
  Future<void> Reject_reason() async {
    FirebaseFirestore.instance
        .collection("Customer_request")
        .doc(widget.id)
        .update({'Reject_reason': Reject_res_ctrl.text, 'Payment': 4});
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Worker_Home();
      },
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )
          : SingleChildScrollView(
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
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    height: 725.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 60.w,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/Person.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        widget.Name,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.Work,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        widget.Date,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        widget.Time,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      // Text(
                                      //   widget.Place,
                                      //   style: TextStyle(
                                      //     fontSize: 17.sp,
                                      //     color: Colors.white,
                                      //     fontWeight: FontWeight.w600,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(width: 5.w,)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          children: [
                            SizedBox(width: 30.w),
                            Text(
                              "Add Status",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.w),
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: Colors.black,
                                  value: 'Not Completed',
                                  groupValue: _status,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _status = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Not Completed',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        if (_status == "Completed") ...[
                          Row(
                            children: [
                              SizedBox(width: 30.w),
                              Text(
                                "Amount",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          Container(
                            height: 60.h,
                            width: 250.w,
                            child: TextFormField(
                              controller: Amount_ctrl,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.currency_rupee),
                                hintText: "Amount",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(height: 70.h),
                          InkWell(
                            onTap: () {
                              Amount_add();
                            },
                            child: Container(
                              height: 60.h,
                              width: 230.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              SizedBox(width: 30.w),
                              Text(
                                "Denial Reason",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              controller: Reject_res_ctrl,
                              minLines: 5,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: "Denial reason",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(height: 50.h),
                          InkWell(
                            onTap: () {
                              Reject_reason();
                            },
                            child: Container(
                              height: 60.h,
                              width: 230.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
