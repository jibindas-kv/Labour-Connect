import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Customer/Customer_Home.dart';
import 'package:labour_connect/Customer/Customer_Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customer_Login extends StatefulWidget {
  const Customer_Login({super.key});

  @override
  State<Customer_Login> createState() => _Customer_LoginState();
}

class _Customer_LoginState extends State<Customer_Login> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String email = "";
  String password = "";
  String id = "";
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  // Login method with role verification and authentication after Firestore check
  void loginCustomer() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading state
      });

      try {
        QuerySnapshot userSnapshot = await _firestore
            .collection(
                'CustomerLogin') // Ensure this is the correct collection name
            .where('Email', isEqualTo: email)
            .limit(1) // Limit to 1 result
            .get();
        if (userSnapshot.docs.isNotEmpty) {
          id = userSnapshot.docs[0].id;
          SharedPreferences data = await SharedPreferences.getInstance();
          data.setString('Customer_id', id);
          print("///////////////////////////////////////");
          print(id);
          print("///////////////////////////////////////");
        }

        if (userSnapshot.docs.isEmpty) {
          // No user document found with this email
          showErrorDialog("No customer record found with this email.");
        } else {
          // Get user document and verify role
          DocumentSnapshot userDoc = userSnapshot.docs.first;
          String role = userDoc.get('Role');

          // Verify if the user is a customer
          if (role == 'customer') {
            // Now authenticate the user with Firebase
            try {
              UserCredential userCredential =
                  await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
              );

              // If login successful, navigate to the Customer Home page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Customer_Home(),
                ),
              );
            } catch (e) {
              // Firebase authentication failed
              showErrorDialog("Login failed. Please check your credentials.");
            }
          } else {
            // Role mismatch, show error and sign out
            showErrorDialog("This account is not registered as a customer.");
          }
        }
      } catch (e) {
        // Catch Firestore or other errors
        showErrorDialog("An error occurred. Please try again.");
        print("Error: $e");
      } finally {
        setState(() {
          isLoading = false; // Stop loading state
        });
      }
    }
  }

  // Error dialog to display errors
  void showErrorDialog(String message) {
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 200.h),
                    Center(
                      child: Text(
                        "Customer Login",
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      onChanged: (value) => password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
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
                    SizedBox(height: 40.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: loginCustomer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 100,
                          ),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white),
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
                                  builder: (context) => Customer_Signup(),
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
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
