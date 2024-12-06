import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labour_connect/Customer/Customer_Home.dart';
import 'package:labour_connect/Customer/Customer_Login.dart';

class Customer_Authgate extends StatefulWidget {
  const Customer_Authgate({super.key});

  @override
  State<Customer_Authgate> createState() => _Customer_AuthgateState();
}

class _Customer_AuthgateState extends State<Customer_Authgate> {
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
                  .collection('CustomerLogin')
                  .doc(user?.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userSnapshot.hasError) {
                  return const Center(child: Text('Error fetching user data.'));
                }

                if (userSnapshot.hasData && userSnapshot.data != null) {
                  DocumentSnapshot customerDoc = userSnapshot.data!;
                  if (customerDoc.exists) {
                    String role = customerDoc['Role'] ?? '';
                    if (role == 'customer') {
                      return Customer_Home();
                    } else {
                      return const Customer_Login(); // Role mismatch, no sign out here
                    }
                  } else {
                    return const Customer_Login(); // No user data, no sign out
                  }
                } else {
                  return const Customer_Login(); // No user data
                }
              },
            );
          } else {
            return const Customer_Login(); // If no user is logged in, show Customer login page
          }
        },
      ),
    );
  }
}
