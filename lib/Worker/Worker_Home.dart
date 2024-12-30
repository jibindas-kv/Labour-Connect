import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Worker/Worker_Authgate.dart';
import 'package:labour_connect/Worker/Worker_Notification.dart';
import 'package:labour_connect/Worker/Worker_Profile.dart';
import 'package:labour_connect/Worker/Worker_Work_Acc_Rej.dart';
import 'package:labour_connect/Worker/Worker_Work_Status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Worker_Home extends StatefulWidget {
  const Worker_Home({super.key});

  @override
  State<Worker_Home> createState() => _Worker_HomeState();
}

class _Worker_HomeState extends State<Worker_Home> {
  final _auth = FirebaseAuth.instance;
  bool isOnline = false;
  // Track the toggle state

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Worker_Profile();
                      }));
                    },
                    icon: Icon(
                      Icons.person_outline_sharp,
                      color: Colors.white,
                      size: 40.sp,
                    ),
                  ),
                  PopupMenuButton<int>(
                    color: Colors.black,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                    onSelected: (value) async {
                      if (value == 1) {
                        await _auth.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Worker_Authgate();
                          },
                        ));
                      } else if (value == 2) {
                        // Toggle the state when the menu option is selected
                        setState(() {
                          isOnline = !isOnline;
                        }
                        );

                        await updateWorkerStatus(isOnline ? 1 : 0);

                        // Show a Snackbar indicating the new status
                        String statusMessage = isOnline
                            ? "You are now online."
                            : "You are now offline.";
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(statusMessage),
                            duration: Duration(seconds: 2),
                            backgroundColor: isOnline
                                ? Colors.green
                                : Colors
                                    .red, // Set background color based on status
                          ),
                        );
                      }else if(value==3){
                        {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Worker_Notification();
                            },
                          ));
                        }
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [

                        PopupMenuItem<int>(
                          value: 3,
                          child: Text(
                            'Notifications',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Text(
                            isOnline ? 'Go Offline' : 'Go Online',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                      ];
                    },
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  height: 770.h,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 50.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                            ),
                            Container(
                              child: TabBar(
                                indicator: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                dividerColor: Colors.white,
                                tabs: [
                                  Tab(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      child: Center(
                                        child: Text(
                                          'Requests',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      child: Center(
                                        child: Text(
                                          'Accepted',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Worker_Requests(),
                              Worker_Accepted(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to update the worker's online/offline status in Firestore
  Future<void> updateWorkerStatus(int status) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Get the worker's document ID or reference
      String workerId = user.uid;
      try {
        await FirebaseFirestore.instance
            .collection('WorkerLogin')
            .doc(workerId)
            .update({
          'status': status,
        });
        print("Worker status updated to: $status");
      } catch (e) {
        print("Error updating status: $e");
      }
    }
  }
}

class Worker_Requests extends StatefulWidget {
  const Worker_Requests({Key? key}) : super(key: key);

  @override
  State<Worker_Requests> createState() => _Worker_RequestsState();
}

class _Worker_RequestsState extends State<Worker_Requests> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? workerId; // Store worker ID here

  @override
  void initState() {
    super.initState();
    fetchWorkerData();
  }

  Future<void> fetchWorkerData() async {
    final prefs = await SharedPreferences.getInstance();
    String? fetchedWorkerId = prefs.getString('Worker_id'); // Retrieve workerId

    if (fetchedWorkerId != null && fetchedWorkerId.isNotEmpty) {
      try {
        DocumentSnapshot workerSnapshot = await _firestore
            .collection('WorkerLogin')
            .doc(fetchedWorkerId)
            .get();
        if (workerSnapshot.exists) {
          setState(() {
            workerId = workerSnapshot['worker_id'];
          });
        }
      } catch (e) {
        print('Error fetching worker data: $e');
      }
    }
  }

  Stream<List<Map<String, dynamic>>> streamCustomerRequests(String? workerId) {
    if (workerId == null || workerId.isEmpty) {
      return const Stream.empty();
    }

    return _firestore
        .collection('Customer_request')
        .where('Worker_id', isEqualTo: workerId)
        .where("Work_status", isEqualTo: 0)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: workerId == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Map<String, dynamic>>>(
              stream: streamCustomerRequests(workerId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No requests found',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }

                final requests = snapshot.data!;

                return GridView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: requests.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Worker_Work_Acc_Rej(
                              doc_id: request["customer_request_id"],
                              Customer_id: request["Customer_id"],
                              Customer_user_name: request["Customer_user_name"],
                              NeededService: request["NeededService"],
                              CustomerPhoneNo: request["CustomerPhoneNo"],
                              Date: request["Date"],
                              Time: request["Time"],
                              CustomerAddress: request["CustomerAddress"],
                              Work_discription: request["WorkDescription"],
                            );
                          },
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: Icon(
                                  Icons.person,
                                  size: 35.sp,
                                ),
                              ),
                              Text(
                                request['Customer_user_name'] ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                request['NeededService'] ?? 'N/A',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                request['CustomerAddress'] ?? 'N/A',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Icon(
                                Icons.info_outline,
                                size: 19,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class Worker_Accepted extends StatefulWidget {
  const Worker_Accepted({Key? key}) : super(key: key);

  @override
  State<Worker_Accepted> createState() => _Worker_AcceptedState();
}

class _Worker_AcceptedState extends State<Worker_Accepted> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? workerId;

  @override
  void initState() {
    super.initState();
    fetchWorkerData();
  }

  Future<void> fetchWorkerData() async {
    final prefs = await SharedPreferences.getInstance();
    String? fetchedWorkerId = prefs.getString('Worker_id'); // Retrieve workerId

    if (fetchedWorkerId != null && fetchedWorkerId.isNotEmpty) {
      setState(() {
        workerId = fetchedWorkerId;
      });
    }
  }

  Stream<List<Map<String, dynamic>>> streamAcceptedRequests(String? workerId) {
    if (workerId == null || workerId.isEmpty) {
      return const Stream.empty();
    }

    return _firestore
        .collection('Customer_request')
        .where('Worker_id', isEqualTo: workerId)
        .where('Work_status', isEqualTo: 1) // Only accepted requests
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: workerId == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Map<String, dynamic>>>(
              stream: streamAcceptedRequests(workerId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No accepted requests found',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }

                final acceptedRequests = snapshot.data!;

                return GridView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: acceptedRequests.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    final request = acceptedRequests[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r)),
                              child: Icon(
                                Icons.person,
                                size: 35.sp,
                              ),
                            ),
                            Text(
                              request['Customer_user_name'] ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              request['NeededService'] ?? 'N/A',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              request['Date'] ?? 'N/A',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Column(
                              children: [
                                Center(
                                    child: request["Payment"] == 0
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return Worker_Work_Status(
                                                    id: request[
                                                        "customer_request_id"],
                                                    Work: request[
                                                        "NeededService"],
                                                    Name: request[
                                                        "Customer_user_name"],
                                                    Date: request["Date"],
                                                    Time: request["Time"],
                                                    Place: request[
                                                        "CustomerAddress"],
                                                  );
                                                },
                                              ));
                                            },
                                            child: Container(
                                              width: 150.w,
                                              height: 25.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  color: Colors.grey.shade800),
                                              child: Center(
                                                child: Text(
                                                  'Status Pending',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        : request["Payment"] == 4
                                            ? Container(
                                                width: 150.w,
                                                height: 25.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: Colors.red),
                                                child: Center(
                                                  child: Text(
                                                    'Payment Failed',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            : request["Payment"] == 5
                                                ? Container(
                                                    width: 150.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        color: Colors.green),
                                                    child: Center(
                                                      child: Text(
                                                        'Payment Success',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 150.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        color: Colors
                                                            .grey.shade600),
                                                    child: Center(
                                                      child: Text(
                                                        'Payment Pending',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
