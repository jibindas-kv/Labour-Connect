import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_Login extends StatefulWidget {
  const Worker_Login({super.key});

  @override
  State<Worker_Login> createState() => _Worker_LoginState();
}

class _Worker_LoginState extends State<Worker_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 180.h),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 50.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: const EdgeInsets.only(right: 330),
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(right: 280),
                child: Text(
                  "Password",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              // Forgot Password Link
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Handle forgot password action
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 100,
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account? ",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle sign-up navigation here
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
