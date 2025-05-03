import 'package:final_project/pages/system_create/create_system.dart';
import 'package:final_project/pages/system_page/widgets/systempage_body.dart';
import 'package:flutter/material.dart';

class Systempage extends StatelessWidget {
  const Systempage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF39B579),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CreateSystem()));
          }),
      body: const Padding(
        padding: EdgeInsets.only(top: 35.0, right: 16, left: 16, bottom: 10),
        child: SystempageBody(),
      ),
    );
  }
}
