import 'package:flutter/material.dart';

class CustomerPaymentcompleted extends StatefulWidget {
  const CustomerPaymentcompleted({super.key});

  @override
  State<CustomerPaymentcompleted> createState() => _CustomerPaymentcompletedState();
}

class _CustomerPaymentcompletedState extends State<CustomerPaymentcompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 300,left: 140),
        child: Column(
          children: [
            Icon(Icons.verified_outlined,color: Colors.black,size: 130,
            ),
            Column(children: [
              Text("Successful",style: TextStyle(color: Colors.black,fontSize: 18),)
            ],)
          ],
        ),
      ),
    );
  }
}
