import 'dart:developer';

import 'package:final_project/core/services/Add_Water_Tank.dart' as AddWaterTank;
import 'package:flutter/material.dart';
import 'package:final_project/core/services/Add_Water_Tank.dart';
import 'package:final_project/pages/create_Tank/createTank.dart';
import 'package:final_project/pages/tank_details/widgets/tankCard.dart';

class Tankdetails extends StatefulWidget {
  const Tankdetails({super.key});

  @override
  State<Tankdetails> createState() => _TankdetailsState();
}

class _TankdetailsState extends State<Tankdetails> {
  List<WaterTank> tanks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTanks();
  }

  Future<void> fetchTanks() async {
    final fetchedTanks = await getWaterTanks();
    if (!mounted) return;
    setState(() {
      tanks = fetchedTanks;
      isLoading = false;
    });
  }

  void showEditDialog(WaterTank tank) {
    final nameController = TextEditingController(text: tank.nameTank);
    final amountController = TextEditingController(text: tank.amountTank.toString());
    final maxController = TextEditingController(text: tank.maxTank.toString());
    final minController = TextEditingController(text: tank.minTank.toString());
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    backgroundColor: Colors.white,
    title: const Center(
      child: Text(
        "Edit Water Tank",
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
            controller: nameController,
            decoration: const InputDecoration(labelText: "Tank Name"),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: "Amount"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: maxController,
            decoration: const InputDecoration(labelText: "Max Capacity"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: minController,
            decoration: const InputDecoration(labelText: "Min Capacity"),
            keyboardType: TextInputType.number,
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
          await AddWaterTank.editWaterTank(
            context: context,
            tankId: tank.id,
            nameTank: nameController.text,
            amountTank: int.tryParse(amountController.text) ?? tank.amountTank,
            maxTank: int.tryParse(maxController.text) ?? tank.maxTank,
            minTank: int.tryParse(minController.text) ?? tank.minTank,
          );

          if (context.mounted) {
            Navigator.of(context).pop(); // Close the dialog safely
            await fetchTanks(); // Refresh data
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF39B579),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Createtank()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        title: const Text("Water Tanks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : tanks.isEmpty
                ? const Center(child: Text('No tanks found'))
                : ListView.builder(
                    itemCount: tanks.length,
                    itemBuilder: (context, index) {
                      final tank = tanks[index];
                      double rawPercentage = 0.0;
                      if (tank.maxTank > 0) {
                        rawPercentage = tank.amountTank / tank.maxTank;
                      }
                      double displayValue = rawPercentage.clamp(0.0, 1.0);
                      int percentText = (rawPercentage * 100).toInt().clamp(0, 100);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Tankcard(
                          tankName: tank.nameTank,
                          displayValue: displayValue,
                          percentText: percentText,
                          onEdit: () {
                            showEditDialog(tank);
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
