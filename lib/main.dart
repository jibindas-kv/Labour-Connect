import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Admin/Admin_CustomersList.dart';
import 'Admin/Admin_Login.dart';
import 'Admin/Admin_Workerlistview.dart';
import 'Admin/Admin_feedbacklist.dart';
import 'Admin/Admin_listview.dart';
import 'Admin/Admin_workers.dart';
import 'Admin/Adminaccrej.dart';
import 'Admin/Admincomplaintlist.dart';
import 'Admin/Admincomplaintview.dart';

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
        home:  Admin_listview(),

      ),
        designSize: Size(432, 864)
    );
  }
}

