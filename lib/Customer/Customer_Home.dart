import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_connect/Customer/Book_worker.dart';
import 'package:labour_connect/Customer/Customer_Navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Customer_Workerbillpayment.dart';

class Customer_Home extends StatefulWidget {
  const Customer_Home({super.key});

  @override
  State<Customer_Home> createState() => _Customer_HomeState();
}

class _Customer_HomeState extends State<Customer_Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Customer_Navbar(),
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white, size: 30.sp)),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       hintText: "Search",
            //       hintStyle: TextStyle(color: Colors.black),
            //       filled: true,
            //       suffixIcon: Icon(Icons.search),
            //       fillColor: Colors.white,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12.r),
            //         borderSide: BorderSide.none,
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r))),
                      height: 700.h,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Container(
                                    height: 50.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
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
                                              'Workers',
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
                                              'Status',
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
                              child: TabBarView(children: [
                                Workers(),
                                Status(),
                              ]),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Workers extends StatefulWidget {
  const Workers({super.key});

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  // List to store workers data
  List<Map<String, dynamic>> workers = [];
  List<Map<String, dynamic>> filteredWorkers = [];

  // Controller for search input
  final TextEditingController searchController = TextEditingController();

  // Stream to fetch workers data from Firestore
  Stream<List<Map<String, dynamic>>> streamWorkers() {
    return FirebaseFirestore.instance.collection('WorkerLogin').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList());
  }

  @override
  void initState() {
    super.initState();

    // Listen to search input changes
    searchController.addListener(() {
      filterWorkers(searchController.text);
    });
  }

  // Filter workers based on the search query
  void filterWorkers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredWorkers = workers;
      });
    } else {
      setState(() {
        filteredWorkers = workers
            .where((worker) =>
                (worker['Name'] ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                (worker['SpecializedWork'] ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                (worker['Place'] ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                suffixIcon: const Icon(Icons.search),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: streamWorkers(),
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
                  return const Center(
                    child: Text(
                      'No workers found',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                // Update workers list and filtered list
                workers = snapshot.data!;
                filteredWorkers =
                    filteredWorkers.isEmpty ? workers : filteredWorkers;

                return GridView.builder(
                  itemCount: filteredWorkers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (context, index) {
                    final worker = filteredWorkers[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Book_Worker(
                                Worker_id: worker['worker_id'] ?? worker['id'],
                                Name: worker["Name"] ?? "No Name",
                                phn_no: worker["Number"] ?? "N/A",
                                SpecializedWork:
                                    worker["SpecializedWork"] ?? "N/A",
                                Address: worker["Place"] ?? "N/A",
                              );
                            },
                          ));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage("assets/Worker.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  worker['Name'] ?? 'Unknown',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  worker['SpecializedWork'] ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  worker['Place'] ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  worker['status'] == 1 ? "Online" : "Offline",
                                  style: TextStyle(
                                    color: worker['status'] == 1
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  String? CustomerId;
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _workerDetails = [];  // To store worker details
  List<dynamic> _filteredWorkerDetails = [];  // To store filtered worker details

  @override
  void initState() {
    super.initState();
    fetchWorkerData();
  }

  Future<void> fetchWorkerData() async {
    final prefs = await SharedPreferences.getInstance();
    String? fetchedWorkerId = prefs.getString('Customer_id'); // Retrieve workerId

    if (fetchedWorkerId != null && fetchedWorkerId.isNotEmpty) {
      setState(() {
        CustomerId = fetchedWorkerId;
      });
    }
  }

  void _filterWorkers(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredWorkerDetails = _workerDetails;
      });
    } else {
      setState(() {
        _filteredWorkerDetails = _workerDetails
            .where((worker) =>
            worker["Worker_Name"]
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                // Trigger filtering when the search query changes
                _filterWorkers(query);
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                suffixIcon: const Icon(Icons.search),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Customer_request")
                  .where('Customer_id', isEqualTo: CustomerId) // Firebase collection
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No data available."));
                }

                // Fetch worker details from the snapshot
                final workerDetails = snapshot.data!.docs;

                // Initialize worker details if they are not already loaded
                if (_workerDetails.isEmpty) {
                  _workerDetails = workerDetails;
                  _filteredWorkerDetails = workerDetails;
                }

                return ListView.builder(
                  itemCount: _filteredWorkerDetails.length,
                  itemBuilder: (context, index) {
                    final Status = _filteredWorkerDetails[index].data() as Map<String, dynamic>;

                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Status["Worker_Name"] ?? "Name Unavailable",
                                    style: TextStyle(
                                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    Status["Date"] ?? "Date Unavailable",
                                    style: TextStyle(
                                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    Status["Time"] ?? "Time Unavailable",
                                    style: TextStyle(
                                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    Status["NeededService"] ?? "Work Unavailable",
                                    style: TextStyle(
                                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                      child: Status["Payment"] == 3
                                          ? InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Customer_Billpayment(
                                                    id: Status["Customer_id"],
                                                    doc_id: Status["customer_request_id"],
                                                    Amount: Status["Amount"],
                                                    Name: Status["Worker_Name"],
                                                    Work: Status["NeededService"],
                                                  );
                                                },
                                              ));
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 110.w,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                              BorderRadius.circular(20.r)),
                                          child: Center(
                                            child: Text(
                                              "Pay",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      )
                                          : Status["Payment"] == 4
                                          ? InkWell(
                                        onTap: () {
                                          // Add your navigation here
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 110.w,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                              BorderRadius.circular(20.r)),
                                          child: Center(
                                            child: Text(
                                              "Failed",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      )
                                          : Status["Payment"] == 5
                                          ? Container(
                                        height: 50.h,
                                        width: 120.w,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(10.r)),
                                        child: Center(
                                          child: Text(
                                            " Payment\nCompleted",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ),
                                      )
                                          : Status["Work_status"] == 0
                                          ? Container(
                                        height: 40.h,
                                        width: 110.w,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                            BorderRadius.circular(20.r)),
                                        child: Center(
                                          child: Text(
                                            "Pending",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ),
                                      )
                                          : Status["Work_status"] == 1
                                          ? Container(
                                        height: 40.h,
                                        width: 110.w,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(20.r)),
                                        child: Center(
                                          child: Text(
                                            "Approved",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                          : Container(
                                        height: 40.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                            BorderRadius.circular(20.r)),
                                        child: Center(
                                          child: Text(
                                            "Rejected",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )),
                                ],
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
          ),
        ],
      ),
    );
  }
}
