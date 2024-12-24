import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:labour_connect/Worker/Worker_Login.dart';

class Worker_Signup extends StatefulWidget {
  const Worker_Signup({super.key});

  @override
  State<Worker_Signup> createState() => _Worker_SignupState();
}

class _Worker_SignupState extends State<Worker_Signup> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String Name = "";
  String Email = "";
  String Phn_no = "";
  String Place = "";
  String Address = "";
  String SpecializedWork = "";
  String Password = "";

  List<String> workCategories = []; // List to store fetched categories
  String Work = 'Select'; // Default dropdown value

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchWorkCategories(); // Fetch categories when the page loads
  }

  // Fetch work categories from Firestore
  void _fetchWorkCategories() async {
    try {
      var querySnapshot = await _firestore.collection('WorkCategories').get();
      setState(() {
        workCategories =
            querySnapshot.docs.map((doc) => doc['category'] as String).toList();
        workCategories.insert(0, 'Select'); // Add 'Select' option at the start
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  void RegisterWorker() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading
      });
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: Email,
          password: Password,
        );

        String workerId = userCredential.user!.uid; // Get worker ID

        // Save worker data with worker_id in Firestore
        await _firestore.collection('WorkerLogin').doc(workerId).set({
          'worker_id': workerId,
          'Name': Name,
          'Email': Email,
          'Phn_no': Phn_no,
          'Place': Place,
          'Address': Address,
          'SpecializedWork': SpecializedWork,
          'Role': "Worker",
          'status': 0,
          "Date": date,
          "approvel": 0,
        });

        // Navigate to Worker Login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Worker_Login(),
          ),
        );
      } catch (e) {
        _showErrorDialog("Registration failed: ${e.toString()}");
      } finally {
        setState(() {
          isLoading = false; // Stop loading
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
                    SizedBox(height: 60.h),
                    Center(
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      onChanged: (value) => Name = value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    Text("Email",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      onChanged: (value) => Email = value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    Text("Phone Number",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      onChanged: (value) => Phn_no = value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your phone number';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    Text("Place",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      onChanged: (value) => Place = value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your place';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    Text("Address",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      onChanged: (value) => Address = value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    Text("Specialized Work",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey.shade300,
                          value: Work,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: workCategories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null && newValue != 'Select') {
                              setState(() {
                                Work = newValue;
                                SpecializedWork = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text("Password",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      onChanged: (value) => Password = value,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: RegisterWorker,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                        ),
                        child: const Text(
                          "Signup",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Worker_Login()),
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
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
