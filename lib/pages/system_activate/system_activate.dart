import 'dart:developer';

import 'package:final_project/core/services/system_services.dart';
import 'package:final_project/core/util/constatnt.dart';
import 'package:final_project/pages/system_activate/edit_system_dialog.dart';
import 'package:flutter/material.dart';

class SystemActivate extends StatefulWidget {
  const SystemActivate({super.key, required this.system});
  final Map<String, dynamic> system;

  @override
  State<SystemActivate> createState() => _SystemActivateState();
}

class _SystemActivateState extends State<SystemActivate> {
  bool isactivated = false;

  Future<void> _onSelected(String value) async {
    switch (value) {
     case 'edit':
  showEditSystemDialog(widget.system, context);
  break;

     case 'delete':
  await SystemServices().deleteSystem(widget.system['_id']);
  if (mounted) {
    // التحقق من أن الـ Widget لا يزال موجودًا
    Navigator.pop(context); // العودة إلى الشاشة السابقة بعد الحذف
  }
  break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final system = widget.system;

    final name = system["name"] ?? "No name";
    final description = system["description"] ?? "No description";
    final amountWater = system["amountWater"]?.toString() ?? "-";
    final irrigationEvery = system["IrrigationEvery"]?.toString() ?? "-";
    final duration = system["duration"]?.toString() ?? "-";
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        actions: [
        PopupMenuButton<String>(
          onSelected: _onSelected,
          itemBuilder: (context) => [
            const PopupMenuItem<String>(
              value: 'edit',
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.green),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
          icon: const Icon(Icons.more_vert),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(color: Color(0xFF5E5E5E), fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Text(
                  "Amount of water",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                Text(
                  "$amountWater liters",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  "Irrigation every",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                Text(
                  "$irrigationEvery hours",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  "Watering Duration",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                Text(
                  "$duration min",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor:
        isactivated ? Colors.red : const Color(0xFF39B579),
    minimumSize: const Size(300, 60),
  ),
  onPressed: () {
    setState(() {
      isactivated = !isactivated;
      globalSystem = widget.system;
    });
          log(globalSystem.toString()+'-----------');
  },
  child: Text(
    isactivated ? "Deactivate" : "Activate",
    style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white),
  ),
)

          ],
        ),
      ),
    );
  }
}
