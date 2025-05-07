import 'package:final_project/pages/create_Tank/widgets/createTankBody.dart';
import 'package:flutter/material.dart';

class Createtank extends StatefulWidget {
  const Createtank({super.key});

  @override
  State<Createtank> createState() => _CreatetankState();
}

class _CreatetankState extends State<Createtank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Createtankbody(),
      ),
    );
  }
}
