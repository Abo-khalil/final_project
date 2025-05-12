import 'package:final_project/pages/system_create/create_system.dart';
import 'package:flutter/material.dart';

class SystemActivate extends StatefulWidget {
  const SystemActivate({super.key, required this.system});
  final Map<String, dynamic> system;

  @override
  State<SystemActivate> createState() => _SystemActivateState();
}

class _SystemActivateState extends State<SystemActivate> {
  bool isactivated = false;

  void _onSelected(String value) {
    switch (value) {
      case 'edit':
        Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CreateSystem()));
        
        break;
      case 'delete':
       
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('System Delete')),
        );
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
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
          onSelected: _onSelected,
          itemBuilder: (context) => [
            const PopupMenuItem<String>(
              value: 'edit',
              child: Text('Edit',style: TextStyle(color: Colors.green),),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete',style: TextStyle(color: Colors.red),),
            ),
          ],
          icon: const Icon(Icons.more_vert),
        ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        const TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                });
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
