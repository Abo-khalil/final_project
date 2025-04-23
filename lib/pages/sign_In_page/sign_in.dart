import 'package:final_project/pages/sign_In_page/widgets/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff39B579),
      appBar: AppBar(
        backgroundColor: const Color(0xff39B579),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SignInBody(),
      ),
    );
  }
}
