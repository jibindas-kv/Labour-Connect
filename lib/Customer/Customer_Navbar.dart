import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Customer/CustomerProfile_view.dart';
import 'package:labour_connect/Customer/Customer_Login.dart';
import 'package:labour_connect/Customer/Customer_Notification.dart';

class Customer_Navbar extends StatelessWidget {
  const Customer_Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(image: AssetImage("assets/greys.jpg"),fit: BoxFit.cover)),
            accountName: Text(
              "Name",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
            accountEmail: Text("emailaddress@gmail.com",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/Person.png"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline_sharp,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text("   Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Customer_Profile_View();
              },));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text("   Notifications",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Customer_Notification();
              },));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer_outlined,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text("   FAQ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text("   About",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.connect_without_contact,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text("   Contact Us",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp)),
            onTap: () {},
          ),
          SizedBox(
            height: 300.h,
          ),
          ListTile(
            leading: Icon(
              Icons.login_outlined,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text("   SignOut",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp)),
            onTap: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Customer_Login();
              },));
            },
          ),
        ],
      ),
    );
  }
}
