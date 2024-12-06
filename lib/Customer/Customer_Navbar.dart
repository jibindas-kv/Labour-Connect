import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labour_connect/Customer/About_Us.dart';
import 'package:labour_connect/Customer/Contact_Us.dart';
import 'package:labour_connect/Customer/CustomerProfile_view.dart';
import 'package:labour_connect/Customer/Customer_Authgate.dart';
import 'package:labour_connect/Customer/Customer_Notification.dart';
import 'package:labour_connect/Customer/FAQ.dart';

class Customer_Navbar extends StatefulWidget {
  const Customer_Navbar({super.key});

  @override
  State<Customer_Navbar> createState() => _Customer_NavbarState();
}

class _Customer_NavbarState extends State<Customer_Navbar> {
  String? id;
  DocumentSnapshot? profile;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("Customer_id");
    if (userId != null) {
      setState(() {
        id = userId;
        print(id);
      });

      // Fetch profile data from Firestore
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection("CustomerLogin")
          .doc(userId)
          .get();

      setState(() {
        profile = userProfile;
      });
    }
  }

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
              profile?['Name'] ?? "Name",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
            accountEmail: Text(
              profile?['Email'] ?? "emailaddress@gmail.com",
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
          _buildListTile(
            icon: Icons.person_outline_sharp,
            label: "Profile",
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Customer_Profile_View();
              },
            )),
          ),
          _buildListTile(
            icon: Icons.notifications_active_outlined,
            label: "Notifications",
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Customer_Notification();
              },
            )),
          ),
          _buildListTile(
            icon: Icons.question_answer_outlined,
            label: "FAQ",
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return FAQ();
              },
            )),
          ),
          _buildListTile(
            icon: Icons.info_outline_rounded,
            label: "About",
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return About_Us();
              },
            )),
          ),
          _buildListTile(
            icon: Icons.connect_without_contact,
            label: "Contact Us",
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ContactUs();
              },
            )),
          ),
          SizedBox(height: 300.h),
          _buildListTile(
            icon: Icons.login_outlined,
            label: "SignOut",
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Customer_Authgate();
                  },
                ));
              } catch (e) {
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

  ListTile _buildListTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 25.sp,
      ),
      title: Text(
        "   $label",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      onTap: onTap,
    );
  }
}
