import 'package:final_project/core/services/system_services.dart';
import 'package:final_project/pages/system_create/widgets/create_system_body.dart';
import 'package:flutter/material.dart';

class CreateSystem extends StatelessWidget {
  const CreateSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateSystemBody22(),
      ),
    );
  }
}
