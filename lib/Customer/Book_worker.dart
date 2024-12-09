import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book_Worker extends StatefulWidget {
const Book_Worker({super.key,
  required this.Worker_id,
  required this.Name,
  required this.phn_no,
  required this.SpecializedWork,
  required this.Address});
 final Worker_id;
 final Name;
 final phn_no;
 final SpecializedWork;
 final Address;

  @override
  State<Book_Worker> createState() => _Book_WorkerState();
}

class _Book_WorkerState extends State<Book_Worker> {
  String? Customer_name;
  @override
  void initState(){
    super.initState();
    Get_Customer();
  }

  String? Customer_id;
  String?Customer_user_name;
  String? Customer_PhoneNo;
  String? SpecializedWork;
  String? Address;

  Future<void> Get_Customer() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? Customerid = await preferences.getString('Customer_id');
    DocumentSnapshot Customer_details = await FirebaseFirestore.instance
        .collection('CustomerLogin')
        .doc(Customerid)
        .get();

    if (Customer_details.exists){
      setState(() {
        Customer_user_name = Customer_details['Name'];
        Customer_PhoneNo = Customer_details['Phonenumber'];
        SpecializedWork = Customer_details['SpecializedWork'];
        Customer_id = Customerid;
        Address= Customer_details['Address'];
      });
      print(Customer_user_name);
      print(Customer_id);
      print(Customer_PhoneNo);
      print(SpecializedWork);
      print(Address);
    }
  }
  String Date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String Time = DateFormat('kk:mm').format(DateTime.now());
  var Location_ctrl = TextEditingController();

  Future<void>Customer_request()async{
    FirebaseFirestore.instance.collection("Customer_request").add({
      "Location": Location_ctrl.text,
      "Date": Date,
      "Time": Time,
      "Address":Address,
      "Worker_id": widget.Worker_id,
      "Worker_Name": widget.Name,
      "SpecializedWork": SpecializedWork,
      "Customer_id": Customer_id,
      "Customer_user_name": Customer_user_name,
      "Customer_PhoneNo": Customer_PhoneNo,
      "Amount": 0,
      "Payment": 0,
      "Worker_status": 0,
      "Reject_reason":"Rejected",
    });
    print("Data Added Successfully/////////////////");
  }


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
                "Book Worker",
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
                                        "${widget.Name}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${widget.SpecializedWork}',
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
                          padding: const EdgeInsets.only(left: 20, top: 10,),
                          child: Text(
                            "Confirm Booking...",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 25.sp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Needed Service',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Your Address',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Your Mobile Number',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10,),
                          child: Text(
                            "Write About Your Work",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 150, right: 100,top: 20),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 42,right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("BOOK",style: TextStyle(color: Colors.white,fontSize: 25.sp,fontWeight: FontWeight.bold),)
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
