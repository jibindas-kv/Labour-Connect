import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Admin/Admin_CustomersList.dart';
import 'Admin/Admin_Login.dart';
import 'Admin/Admin_WorkerListView.dart';
import 'Admin/Admin_FeedbackList.dart';
import 'Admin/Admin_ListView.dart';
import 'Admin/Admin_Workers.dart';
import 'Admin/Admin_AccRej.dart';
import 'Admin/Admin_ComplaintList.dart';
import 'Admin/Admin_ComplaintView.dart';
import 'Admin/Worker_AccRej.dart';

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
        home:  Worker_AccRej(),

      ),
        designSize: Size(432, 864)
    );
  }
}

