import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Admin_Workers_Work_Add extends StatefulWidget {
  const Admin_Workers_Work_Add({super.key});

  @override
  State<Admin_Workers_Work_Add> createState() => _Admin_Workers_Work_AddState();
}

class _Admin_Workers_Work_AddState extends State<Admin_Workers_Work_Add> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _categoryController = TextEditingController();

  List<String> workCategories = []; // List to hold the fetched work categories

  @override
  void initState() {
    super.initState();
    _fetchWorkCategories(); // Fetch existing categories when the screen loads
  }

  // Fetch work categories from Firestore
  void _fetchWorkCategories() async {
    try {
      var querySnapshot = await _firestore.collection('WorkCategories').get();
      setState(() {
        workCategories = querySnapshot.docs.map((doc) => doc['category'] as String).toList();
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  // Show dialog to add a new work category
  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Add Work Category"),
          content: TextField(
            controller: _categoryController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              hintText: 'Enter Category Name',
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String newCategory = _categoryController.text.trim();
                if (newCategory.isNotEmpty) {
                  try {
                    // Save the new category to Firestore
                    await _firestore.collection('WorkCategories').add({
                      'category': newCategory,
                    });

                    _categoryController.clear();
                    Navigator.pop(context);
                    _fetchWorkCategories(); // Fetch updated list
                  } catch (e) {
                    print("Error adding category: $e");
                  }
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 70.h,
          width: 70.w,
          child: FloatingActionButton(
            shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add,
              size: 40.sp,
              color: Colors.white,
            ),
            onPressed: _showAddCategoryDialog, // Show the dialog on press
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.admin_panel_settings_outlined,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 36.sp,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  height: 770.h,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: workCategories.length, // Use dynamic list
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  workCategories[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
