import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Worker/Worker_Home.dart';

class Worker_Login extends StatefulWidget {
  const Worker_Login({super.key});

  @override
  State<Worker_Login> createState() => _Worker_LoginState();
}
class _Worker_LoginState extends State<Worker_Login> {
  String Email = '', Password = '';
  Future<void> _saveUserDataToFirestore(User user) async {
    final DocumentSnapshot userDoc =
    await _firestore.collection("WorkerLogin").doc(user.uid).get();

    if (!userDoc.exists) {
      await _firestore.collection("WorkerLogin").doc(user.uid).set({
        'Name': user.displayName,
        'Email': user.email,
        'Phn_no': "",
        // Add additional fields like "Trade" and "OfficeLocation" if required
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  void loginWorker() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: Email,
          password: Password,
        );

        if (userCredential.user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Worker_Home();
          },));
        }
      } catch (e) {
        print("Login Error: $e");
      }
    }
  }

  final RegExp emailRegExp =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    style:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => Email=value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.only(right: 280),
                  child: Text(
                    "Password",
                    style:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => Password=value,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginWorker();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logging in...')),
                        );
                      }
                    },
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
                          loginWorker();
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
      ),
    );
  }
}
