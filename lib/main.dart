import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Admin/Admin_Customer_List.dart';
import 'package:labour_connect/Admin/Dashboard.dart';
import 'package:labour_connect/Worker/Worker_Home.dart';
import 'package:labour_connect/Worker/Worker_Login.dart';
import 'package:labour_connect/Worker/Worker_Notification.dart';
import 'package:labour_connect/Worker/Worker_Profile.dart';
import 'package:labour_connect/Worker/Worker_Profile_Edit.dart';
import 'package:labour_connect/Worker/Worker_Signup.dart';
import 'package:labour_connect/Worker/Worker_Work_Acc_Rej.dart';

import 'Admin/Admin_Login.dart';
import 'Admin/Admin_Workerlistview.dart';
import 'Admin/Admin_feedbacklist.dart';
import 'Admin/Admin_CustomerListView.dart';
import 'Admin/Admin_Rejected_List.dart';
import 'Admin/Approval_Page.dart';
import 'Admin/Transcation_Details.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  Worker_Notification(),

      ),
        designSize: Size(432, 864)
    );
  }
}

