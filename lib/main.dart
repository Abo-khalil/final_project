import 'package:final_project/pages/ai_page/ai_Page.dart';
import 'package:final_project/pages/sign_In_page/sign_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Final project',
        home: SignIn());
  }
}
