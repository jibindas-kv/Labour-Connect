import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Worker/Worker_Home.dart';
import 'package:labour_connect/Worker/Worker_Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Worker_Login extends StatefulWidget {
  const Worker_Login({super.key});

  @override
  State<Worker_Login> createState() => _Worker_LoginState();
}

class _Worker_LoginState extends State<Worker_Login> {
  String email = '', password = '';
  String id = "";
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool obscureText = true; // Toggle for password visibility

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Worker login function
  void loginWorker() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        QuerySnapshot userSnapshot = await _firestore
            .collection('WorkerLogin')
            .where('Email', isEqualTo: email)
            .where('approvel', isEqualTo: 1)
            .limit(1)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          id = userSnapshot.docs[0].id;
          SharedPreferences data = await SharedPreferences.getInstance();
          data.setString('Worker_id', id);
        }

        if (userSnapshot.docs.isEmpty) {
          _showErrorDialog("No worker record found with this email.");
        } else {
          DocumentSnapshot userDoc = userSnapshot.docs.first;
          String role = userDoc.get('Role');

          if (role == 'Worker') {
            try {
              await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Worker_Home(),
                ),
              );
            } catch (e) {
              _showErrorDialog("Login failed. Please check your credentials.");
            }
          } else {
            _showErrorDialog("This account is not registered as a Worker.");
          }
        }
      } catch (e) {
        _showErrorDialog("An error occurred. Please try again.");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 180.h),
                Text(
                  "Worker Login",
                  style: TextStyle(
                    fontSize: 50.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextFormField(
                  onChanged: (value) => email = value,
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
                Row(
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextFormField(
                  onChanged: (value) => password = value,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
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
                SizedBox(height: 40.h),
                Center(
                  child: ElevatedButton(
                    onPressed: loginWorker,
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
                    child: isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Text(
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
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Worker_Signup(),
                            ),
                          );
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
