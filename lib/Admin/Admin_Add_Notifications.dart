import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labour_connect/Admin/Admin_Notification.dart';

class Admin_Add_Notifications extends StatefulWidget {
  const Admin_Add_Notifications({super.key});

  @override
  State<Admin_Add_Notifications> createState() => _Admin_Add_NotificationsState();
}

class _Admin_Add_NotificationsState extends State<Admin_Add_Notifications> {
  final List<String> _notify = ['Worker', 'Customer', 'All'];
  String Deafault = 'All';
  final TextEditingController headingController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> _addNotification() async {
    final String heading = headingController.text.trim();
    final String content = contentController.text.trim();

    if (heading.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'heading': heading,
        'content': content,
        'target': Deafault,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification added successfully!')),
      );

      // Navigate to Admin Notification Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Admin_Notification()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding notification: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Add Notification",
              style: TextStyle(
                fontSize: 43.sp,
                color: Colors.white,
                fontWeight: FontWeight.w900,
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
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  height: 731.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 28.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Heading",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: headingController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Notification Content",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: contentController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Preferred Work",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 55,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.grey.shade300,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButton<String>(
                              dropdownColor: Colors.grey.shade300,
                              value: Deafault,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 250),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                ),
                              ),
                              items: _notify.map((String value) {
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
                                  Deafault = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h),
                      Center(
                        child: InkWell(
                          onTap: _addNotification,
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Center(
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
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
    );
  }
}
