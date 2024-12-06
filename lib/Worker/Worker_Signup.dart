import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Worker/Worker_Login.dart';

class Worker_Signup extends StatefulWidget {
  const Worker_Signup({super.key});

  @override
  State<Worker_Signup> createState() => _Worker_SignupState();
}

class _Worker_SignupState extends State<Worker_Signup> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void RegisterWorker() async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: Email,
          password: Password,
        );

        await _firestore
            .collection('WorkerLogin')
            .doc(userCredential.user!.uid)
            .set({
          'Name': Name,
          'Email': Email,
          'Phn_no': Phn_no,
          'Place': Place,
          'Address': Address,
          'SpecializedWork': SpecializedWork,
          "Role":"Worker"
        });

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Worker_Login();
          },
        ));
      } catch (e) {
        print("Registration Error: $e");
      }
    }
  }

  final List<String> _works = [
    'Plumbing',
    'Wiring',
    'Carpenter',
    'Designing',
    'Cleaning',
    'Washing',
    'Select'
  ];
  String Name = "";
  String Email = "";
  String Phn_no = "";
  String Place = "";
  String Address = "";
  String SpecializedWork = "";
  String Password = "";

  final formKey = GlobalKey<FormState>();

  String Work = 'Select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  "Name",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: (value) => Name = value,
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
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.sp),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: (value) => Email = value,
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
                      return 'Please Enter Your Email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please Enter A Valid Email Address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.sp),
                Text(
                  "Phone number",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: (value) => Phn_no = value,
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
                      return 'Please Enter Your Phone Number';
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please Enter A Valid 10-digit Phone Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.sp),
                Text(
                  "Place",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: (value) => Place = value,
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
                      return 'Please Enter Your Place';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.sp),
                Text(
                  "Address",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: (value) => Address = value,
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
                      return 'Please Enter Your Address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.sp),
                Text(
                  "Specialized Work",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 55,
                  width: 400.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.grey.shade300,
                      value: Work,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 250),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ),
                      ),
                      items: _works.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          SpecializedWork = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15.sp),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: (value) => Password = value,
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
                      return 'Please Enter Your Password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 100,
                      ),
                    ),
                    child: Text(
                      "Signup",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 25.sp),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have An Account ? ",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Worker_Login();
                          },));

                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 16.sp.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }}
