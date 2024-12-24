import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Complaint_Listview extends StatefulWidget {
  const Complaint_Listview({
    super.key,
    required this.customerName,
    required this.workerName,
    required this.neededService,
    required this.feedback,
  });

  final String? customerName;
  final String? workerName;
  final String? neededService;
  final String? feedback;

  @override
  State<Complaint_Listview> createState() => _Complaint_ListviewState();
}

class _Complaint_ListviewState extends State<Complaint_Listview> {
  late String customerName;
  late String workerName;
  late String neededService;
  late String feedback;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Simulate data fetching delay
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      customerName = widget.customerName! ;
      workerName = widget.workerName! ;
      neededService = widget.neededService! ;
      feedback = widget.feedback!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Complaint Details",
              style: TextStyle(
                fontSize: 45.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  height: 731.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      _buildDetailField("Customer Name", customerName),
                      SizedBox(height: 16),
                      _buildDetailField("Worker Name", workerName),
                      SizedBox(height: 16),
                      _buildDetailField("Preferred Work", neededService),
                      SizedBox(height: 16),
                      _buildDetailField("Complaint", feedback, maxLines: 4),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailField(String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            initialValue: value,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
