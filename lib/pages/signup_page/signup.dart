import 'package:final_project/pages/signup_page/widgets/signup_body.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff39B579),
      appBar: AppBar(
        backgroundColor: const Color(0xff39B579),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SignupBody(),
      ),
    );
  }
}
