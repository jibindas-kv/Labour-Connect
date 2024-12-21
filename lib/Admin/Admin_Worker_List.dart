import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_WorkerListView.dart';

class Admin_Worker_List extends StatefulWidget {
  const Admin_Worker_List({super.key});

  @override
  State<Admin_Worker_List> createState() => _Admin_Worker_ListState();
}

class _Admin_Worker_ListState extends State<Admin_Worker_List> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              "Workers",
              style: TextStyle(
                fontSize: 45.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: "Search by name...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
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
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("WorkerLogin")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      final workerList = snapshot.data?.docs.where((doc) {
                        final workerData = doc.data() as Map<String, dynamic>;
                        final name = workerData["Name"]?.toString().toLowerCase() ?? '';
                        return name.contains(_searchQuery);
                      }).toList() ?? [];

                      if (workerList.isEmpty) {
                        return Center(
                          child: Text(
                            "No workers match your search",
                            style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: workerList.length,
                        itemBuilder: (context, index) {
                          final doc = workerList[index];
                          final workerData = doc.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Admin_WorkerListView(
                                      Worker_id: doc.id,
                                      Worker_name: workerData["Name"],
                                      Worker_Email: workerData["Email"],
                                      Worker_Phn_no: workerData["Phn_no"],
                                      Worker_place: workerData["Place"],
                                      Worker_address: workerData["Address"],
                                      Specialized_Work: workerData["SpecializedWork"],
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${workerData["Name"] ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        "${workerData["Date"] ?? ""}",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
