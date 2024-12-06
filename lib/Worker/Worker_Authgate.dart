import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labour_connect/Worker/Worker_Home.dart';
import 'package:labour_connect/Worker/Worker_Login.dart';

class Worker_Authgate extends StatefulWidget {
  const Worker_Authgate({super.key});

  @override
  State<Worker_Authgate> createState() => _Worker_AuthgateState();
}

class _Worker_AuthgateState extends State<Worker_Authgate> {
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
                  .collection('WorkerLogin')
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
                  DocumentSnapshot workerDoc = userSnapshot.data!;
                  if (workerDoc.exists) {
                    String role = workerDoc['Role'] ?? '';
                    if (role == 'Worker') {
                      return Worker_Home();
                    } else {
                      return const Worker_Login(); // Role mismatch, no sign out here
                    }
                  } else {
                    return const Worker_Login(); // No user data, no sign out
                  }
                } else {
                  return const Worker_Login(); // No user data
                }
              },
            );
          } else {
            return const Worker_Login(); // If no user is logged in, show Worker login page
          }
        },
      ),
    );
  }
}
