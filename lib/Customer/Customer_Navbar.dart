import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labour_connect/Customer/About_Us.dart';
import 'package:labour_connect/Customer/Contact_Us.dart';
import 'package:labour_connect/Customer/CustomerProfile_view.dart';
import 'package:labour_connect/Customer/Customer_Authgate.dart';
import 'package:labour_connect/Customer/Customer_Notification.dart';
import 'package:labour_connect/Customer/FAQ.dart';

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
              image: DecorationImage(
                image: AssetImage("assets/greys.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
            accountEmail: Text(
              "emailaddress@gmail.com",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            title: Text(
              "   Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Customer_Profile_View();
              }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text(
              "   Notifications",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Customer_Notification();
              }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer_outlined,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text(
              "   FAQ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FAQ();
              }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text(
              "   About",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return About_Us();
              }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.connect_without_contact,
              color: Colors.white,
              size: 25.sp,
            ),
            title: Text(
              "   Contact Us",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContactUs();
              }));
            },
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
            title: Text(
              "   SignOut",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            onTap: () async {
              try {
                // Sign out the current user
                await FirebaseAuth.instance.signOut();
                // Navigate to the authentication gate after signing out
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Customer_Authgate();
                    },
                  ),
                );
              } catch (e) {
                // Handle any errors during sign-out
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sign-out failed: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
