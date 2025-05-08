import 'package:final_project/pages/system_create/create_system.dart';
import 'package:flutter/material.dart';

class SystemActivate extends StatefulWidget {
  const SystemActivate({super.key});

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Lavender',
                    style:
                        TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Lavender is preferred to be grown in a sandy\nsoil and during the growing season, water when the soil is dry to the touch. Watering Amount aim to give around 2.5 to 3.8 cm of water per week.",
              style: TextStyle(color: Color(0xFF5E5E5E), fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Row(
              children: [
                Text(
                  "Amount of water",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Spacer(),
                Text(
                  "15 liters",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Text(
                  "Irrigation every",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Spacer(),
                Text(
                  "7 days",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Text(
                  "Watering Duration",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Spacer(),
                Text(
                  "5 min",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
