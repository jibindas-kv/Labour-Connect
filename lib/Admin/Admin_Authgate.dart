import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labour_connect/Admin/Admin_Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labour_connect/Admin/Dashboard.dart';

class Admin_Authgate extends StatefulWidget {
  const Admin_Authgate({super.key});

  @override
  State<Admin_Authgate> createState() => _Admin_AuthgateState();
}

class _Admin_AuthgateState extends State<Admin_Authgate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            User? user = snapshot.data;

            // Fetch user role from Firestore
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Admin') // Ensure this is the correct collection
                  .doc(user?.uid) // Assuming each admin has their UID in Firestore
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userSnapshot.hasError) {
                  return const Center(child: Text('Error fetching user data.'));
                }

                if (userSnapshot.hasData && userSnapshot.data != null) {
                  DocumentSnapshot adminDoc = userSnapshot.data!;
                  if (adminDoc.exists) {
                    String role = adminDoc['Role'] ?? '';
                    if (role == 'admin') {
                      return Dashboard(); // Redirect to admin home if role matches
                    } else {
                      return const Admin_Login(); // Role mismatch
                    }
                  } else {
                    return const Admin_Login(); // No user data
                  }
                } else {
                  return const Admin_Login(); // No user data
                }
              },
            );
          } else {
            return const Admin_Login(); // If no user is logged in, show Admin login page
          }
        },
      ),
    );
  }
}
