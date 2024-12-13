import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Admin_WorkerListView extends StatefulWidget {
  const Admin_WorkerListView({
    super.key,
    required this.Worker_id,
    required this.Worker_name,
    required this.Worker_Email,
    required this.Worker_Phn_no,
    required this.Worker_place,
    required this.Worker_address,
    required this.Specialized_Work,
  });

  final String Worker_id;
  final String Worker_name;
  final String Worker_Email;
  final String Worker_Phn_no;
  final String Worker_place;
  final String Worker_address;
  final String Specialized_Work;

  @override
  State<Admin_WorkerListView> createState() => _Admin_WorkerListViewState();
}

class _Admin_WorkerListViewState extends State<Admin_WorkerListView> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController placeController;
  late TextEditingController specializedWorkController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.Worker_name);
    emailController = TextEditingController(text: widget.Worker_Email);
    phoneController = TextEditingController(text: widget.Worker_Phn_no);
    placeController = TextEditingController(text: widget.Worker_place);
    specializedWorkController = TextEditingController(text: widget.Specialized_Work);
    addressController = TextEditingController(text: widget.Worker_address);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    placeController.dispose();
    specializedWorkController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Icon(
              Icons.person_3_outlined,
              size: 70.sp,
              color: Colors.white,
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
                  height: 725.h,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildTextField("Name", nameController),
                        _buildTextField("Email", emailController),
                        _buildTextField("Phone Number", phoneController),
                        _buildTextField("Place", placeController),
                        _buildTextField("Specialized Work", specializedWorkController),
                        _buildTextField("Address", addressController, minLines: 3, maxLines: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int minLines = 1, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          minLines: minLines,
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
        const SizedBox(height: 15),
      ],
    );
  }
}
