import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Customer/Customer_Home.dart';

class Customer_Billpayment extends StatefulWidget {
  const Customer_Billpayment(
      {super.key,
      required this.id,
      required this.Amount,
      required this.Name,
      required this.Work,
      required this.doc_id});
  final id;
  final Amount;
  final Name;
  final Work;
  final doc_id;

  @override
  State<Customer_Billpayment> createState() => _Customer_BillpaymentState();
}

class _Customer_BillpaymentState extends State<Customer_Billpayment> {
  String ? Complaint_ctrl ;
  String ?Experience_ctrl;

  Future<void> Pay() async {
    FirebaseFirestore.instance
        .collection("Customer_request")
        .doc(widget.doc_id)
        .update({ 'Payment': 5,"complaint":Complaint_ctrl,"Experience":Experience_ctrl});
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Customer_Home();
      },
    ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                "Pay Your Bill",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.person,
                                      size: 48.sp,
                                      color: Colors.white,
                                    ),
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                  ),
                                  SizedBox(width: 16.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.Name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.Work,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Text(
                            "Complaint Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            onChanged: (value) => Complaint_ctrl = value,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "How  Was Your Experience",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            onChanged: (value) => Experience_ctrl = value,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "Make Payment...",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 100, top: 30),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 40,
                                      ),
                                      Text(
                                        widget.Amount,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                height: 70.h,
                                width: 180.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(width: 2)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 100, top: 40),
                              child: InkWell(
                                onTap: () {
                                  Pay();
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 49, right: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(
                                            child: Text(
                                          "Pay",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.bold),
                                        ))
                                      ],
                                    ),
                                  ),
                                  height: 50.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
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
