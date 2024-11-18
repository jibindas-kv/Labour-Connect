import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Admin_Login extends StatefulWidget {
  const Admin_Login({super.key});

  @override
  State<Admin_Login> createState() => _Admin_LoginState();
}

class _Admin_LoginState extends State<Admin_Login> {

  final formkey = GlobalKey<FormState>(); //for validations
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [Row(
                    children: [
                      Text("Enter Username",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Invalid credentials";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: ("Username"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [Row(
                    children: [
                      Text("Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) ;
                        {
                          return "Invalid password";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.remove_red_eye),
                          hintText: (" Enter Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width:250,
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
