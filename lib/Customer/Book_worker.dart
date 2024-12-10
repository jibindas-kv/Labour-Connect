import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book_Worker extends StatefulWidget {
  const Book_Worker({
    super.key,
    required this.Worker_id,
    required this.Name,
    required this.phn_no,
    required this.SpecializedWork,
    required this.Address,
  });
  final Worker_id;
  final Name;
  final phn_no;
  final SpecializedWork;
  final Address;

  @override
  State<Book_Worker> createState() => _Book_WorkerState();
}

class _Book_WorkerState extends State<Book_Worker> {
  // Controllers for TextFormField widgets
  final TextEditingController locationController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController workDescriptionController =
  TextEditingController();

  String? customerName;
  String? customerId;
  String? customerUserName;
  String? customerPhoneNo;
  String? specializedWork;
  String? address;

  @override
  void initState() {
    super.initState();
    getCustomer();
  }

  Future<void> getCustomer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? customerId = await preferences.getString('Customer_id');
    DocumentSnapshot customerDetails = await FirebaseFirestore.instance
        .collection('CustomerLogin')
        .doc(customerId)
        .get();

    if (customerDetails.exists) {
      setState(() {
        customerUserName = customerDetails['Name'];
        customerPhoneNo = customerDetails['Phn_no'];
        this.customerId = customerId;
        address = customerDetails['Address'];
      });
    }
  }

  // Date and Time
  final String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final String time = DateFormat('kk:mm').format(DateTime.now());

  // Firestore Add Method
  Future<void> addCustomerRequest() async {
    await FirebaseFirestore.instance.collection("Customer_request").add({
      "Location": locationController.text,
      "NeededService": serviceController.text,
      "CustomerAddress": addressController.text,
      "CustomerPhoneNo": phoneController.text,
      "WorkDescription": workDescriptionController.text,
      "Date": date,
      "Time": time,
      "Address": address,
      "Worker_id": widget.Worker_id,
      "Worker_Name": widget.Name,
      "SpecializedWork": specializedWork,
      "Customer_id": customerId,
      "Customer_user_name": customerUserName,
      "Amount": 0,
      "Payment": 0,
      "Worker_status": 0,
      "Reject_reason": "Rejected",
    });
    print("Data Added Successfully.");
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
                children: const [
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
                              padding: const EdgeInsets.all(16),
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
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${widget.SpecializedWork}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: serviceController,
                            decoration: InputDecoration(
                              hintText: 'Needed Service',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: 'Your Address',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: 'Your Mobile Number',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: workDescriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Write About Your Work',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150, top: 20),
                          child: InkWell(
                            onTap: addCustomerRequest,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                "BOOK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
