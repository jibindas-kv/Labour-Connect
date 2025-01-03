import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_Work_Acc_Rej extends StatefulWidget {
  const Worker_Work_Acc_Rej({
    super.key,
    required this.Customer_id,
    required this.NeededService,
    required this.CustomerPhoneNo,
    required this.Date,
    required this.Time,
    required this.Customer_user_name,
    required this.CustomerAddress, required this.doc_id, required this.Work_discription,
  });

  final doc_id;
  final Customer_id;
  final String NeededService;
  final String Work_discription;
  final String CustomerPhoneNo;
  final String Date;
  final String Time;
  final String Customer_user_name;
  final String CustomerAddress;

  @override
  State<Worker_Work_Acc_Rej> createState() => _Worker_Work_Acc_RejState();
}

class _Worker_Work_Acc_RejState extends State<Worker_Work_Acc_Rej> {
  Future<void> _acceptwork() async {
    if (widget.Customer_id == null || widget.Customer_id.isEmpty) {
      print('Error: Customer ID is null or empty');
      return;
    }
    print('Customer ID: ${widget.Customer_id}');
    try {
      await FirebaseFirestore.instance
          .collection('Customer_request')
          .doc(widget.doc_id)
          .update({'Work_status': 1});
      Navigator.pop(context);
    } catch (e) {
      if (e is FirebaseException && e.code == 'not-found') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('The requested document was not found.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> _rejectwork() async {
    if (widget.Customer_id == null || widget.Customer_id.isEmpty) {
      print('Error: Customer ID is null or empty');
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection('Customer_request')
          .doc(widget.Customer_id)
          .update({'Work_status': 2});
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
    }
  }

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
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    height: 725.h,
                    width: double.infinity,
                    child: SingleChildScrollView(
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
                                          widget.Customer_user_name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          widget.NeededService,
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
                            padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("  Needed Service",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                  ],
                                ),
                                SizedBox(height: 3.h,),
                                Card(
                                  color: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0), // Adjust padding as needed
                                    child: Text(
                                      widget.Work_discription ?? '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("  Address",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                  ],
                                ),
                                SizedBox(height: 3.h,),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.CustomerAddress,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("  Phone Number",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                  ],
                                ),
                                SizedBox(height: 3.h,),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.CustomerPhoneNo,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("  Date",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                  ],
                                ),
                                SizedBox(height: 3.h,),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.Date,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("  Time",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                  ],
                                ),
                                SizedBox(height: 3.h,),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.Time,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _acceptwork();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(24),
                                  backgroundColor: Colors.black,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _rejectwork();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(24),
                                  backgroundColor: Colors.red,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
