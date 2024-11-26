import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class About_Us extends StatefulWidget {
  const About_Us({super.key});

  @override
  State<About_Us> createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ABOUT US",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 40.sp),
                  ),
                ],
              ),
               SizedBox(height: 30.h),
              const Text(
                "About Our Company",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
               SizedBox(height: 10.h),
               Text(
                "We are dedicated to empowering daily wage workers by bridging the gap between them and customers in need of their services. Our platform serves as a reliable and efficient connection point, enabling workers to find opportunities and customers to access skilled labor quickly and seamlessly.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                  fontStyle: FontStyle.italic
                ),
              ),
               SizedBox(height: 20.h),
              const Text(
                "Our Mission",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
               SizedBox(height: 10.h),
               Text(
                "Our mission is to enhance livelihoods by providing a trusted digital space that promotes dignity, convenience, and mutual growth. With Labour Connect, we aim to build stronger communities and foster economic empowerment for everyone involved.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5.h,
                  fontStyle: FontStyle.italic
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
