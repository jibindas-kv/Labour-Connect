import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Admin_Add_Notification extends StatefulWidget {
  const Admin_Add_Notification({super.key});

  @override
  State<Admin_Add_Notification> createState() => _Admin_Add_NotificationState();
}

class _Admin_Add_NotificationState extends State<Admin_Add_Notification> {
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
            onPressed: () {
              print("Pressed");
            },
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
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 36.sp,
                    ))
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Heading",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.sp),
                                ),
                                Text(
                                  "Content Of The Notification.....",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                ),
                                Text(
                                  "Customer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15.sp),
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
