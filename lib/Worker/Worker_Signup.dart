import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_Signup extends StatefulWidget {
  const Worker_Signup({super.key});

  @override
  State<Worker_Signup> createState() => _Worker_SignupState();
}

class _Worker_SignupState extends State<Worker_Signup> {
  @override
  final List<String> _works = [
    'Plumbing',
    'Wiring',
    'Carpenter',
    'Designing',
    'Cleaning',
    'Washing',
    'Select'
  ];

  String Work = 'Select';
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15.sp),
              Text(
                "Email",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              SizedBox(height: 15.sp),
              Text(
                "Phone number",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              SizedBox(height: 15.sp),
              Text(
                "Place",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              SizedBox(height: 15.sp),
              Text(
                "Address",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
                        Work = newValue!;
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
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
              SizedBox(height: 15.sp),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have An Account ? ",
                      style: TextStyle(fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        // Handle sign-in navigation here
                      },
                      child: Text(
                        "Sign in",
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
              SizedBox(
                height: 40.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
