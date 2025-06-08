import 'package:flutter/material.dart';
import 'package:final_project/pages/tank_details/widgets/tankCard.dart';

class TankScreen extends StatefulWidget {
  const TankScreen({super.key});

  @override
  State<TankScreen> createState() => _TankScreenState();
}

class _TankScreenState extends State<TankScreen> {
  String tankName = "Main Tank";
  int percent = 70;

  void _editTankDialog() {
    final nameController = TextEditingController(text: tankName);
    final percentController = TextEditingController(text: percent.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Tank"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Tank Name"),
            ),
            TextField(
              controller: percentController,
              decoration: const InputDecoration(labelText: "Percentage"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tankName = nameController.text;
                percent = int.tryParse(percentController.text) ?? percent;
              });
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Water Tanks")),
      body: Center(
        child: Tankcard(
          tankName: tankName,
          displayValue: percent / 100,
          percentText: percent,
          onEdit: _editTankDialog,
        ),
      ),
    );
  }
}
