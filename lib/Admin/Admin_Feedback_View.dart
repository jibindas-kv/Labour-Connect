import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Admin_Feedback_View extends StatefulWidget {
  const Admin_Feedback_View({
    super.key,
    required this.customer_name,
    required this.worker_name,
    required this.needed_service,
    required this.feedback,
  });

  final String? customer_name;
  final String? worker_name;
  final String? needed_service;
  final String? feedback;

  @override
  State<Admin_Feedback_View> createState() => _Admin_Feedback_ViewState();
}

class _Admin_Feedback_ViewState extends State<Admin_Feedback_View> {
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
    // Simulating a data fetching delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      customerName = widget.customer_name! ;
      workerName = widget.worker_name! ;
      neededService = widget.needed_service! ;
      feedback = widget.feedback! ;
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
              "Feedback Details",
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
                      _buildDetailField("Feedback", feedback, maxLines: 4),
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
