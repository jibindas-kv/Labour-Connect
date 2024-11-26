import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_Add_Notifications.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 70),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Contact us",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.sp),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    "We are all ears and are available 24/7",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(
                  "Customer support number -",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "+91 - 8989898989",
                  style: TextStyle(color: Colors.black, fontSize: 18,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Email - ",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                ),
                Text(
                  "help@labourconnect.com",
                  style: TextStyle(color: Colors.black, fontSize: 18,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Text(
                  "We have no other call support numbers",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
