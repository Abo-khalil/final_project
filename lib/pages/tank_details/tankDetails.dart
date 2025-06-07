import 'package:final_project/core/services/Add_Water_Tank.dart';
import 'package:final_project/pages/create_Tank/createTank.dart';
import 'package:final_project/pages/tank_details/widgets/tankCard.dart';
import 'package:flutter/material.dart';

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
    final fetchedTanks = await getWaterTanks();  // استدعاء دالة جلب الخزانات
    setState(() {
      tanks = fetchedTanks;
      isLoading = false;
    });
  }


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
                  MaterialPageRoute(builder: (context) => const Createtank()));
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
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
                      double percentage = 0;
                      if (tank.maxTank != 0) {
                        percentage = tank.amountTank / tank.maxTank;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Tankcard(
                          tankName: tank.nameTank,
                          percentage: percentage.clamp(0, 1),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
