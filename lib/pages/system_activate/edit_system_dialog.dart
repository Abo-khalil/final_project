import 'package:final_project/core/services/system_services.dart';
import 'package:flutter/material.dart';

void showEditSystemDialog(Map<String, dynamic> system, BuildContext context) {
  final name = TextEditingController(text: system["name"] ?? 'No name');
  final description =
      TextEditingController(text: system["description"] ?? "No description");
  final amountWater =
      TextEditingController(text: system["amountWater"]?.toString() ?? "-");
  final irrigationEvery =
      TextEditingController(text: system["IrrigationEvery"]?.toString() ?? "-");
  final type = TextEditingController(text: system["type"]?.toString() ?? "-");
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Center(
        child: Text(
          "Edit System",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "System Name"),
            ),
            TextField(
              controller: description,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: amountWater,
              decoration: const InputDecoration(labelText: "Amount Water"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: irrigationEvery,
              decoration: const InputDecoration(labelText: "Irrigation Every"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: type,
              decoration: const InputDecoration(labelText: "Type"),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Color(0xFF39B579),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 20,
          width: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () async {
            await SystemServices.editSystem(
                context: context,
                name: name.text,
                description: description.text,
                amountWater: int.parse(amountWater.text),
                irrigationEvery: int.parse(irrigationEvery.text),
                duration: "12 minutes",
                type: type.text,
                systemId: system['_id']);

            if (context.mounted) {
              Navigator.of(context).pop(); // Close the dialog safely
              //await fetchTanks(); // Refresh data
            }
          },
          child: const Text(
            "Save",
            style: TextStyle(
              color: Color(0xFF39B579),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
