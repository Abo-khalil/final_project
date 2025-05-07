import 'package:final_project/pages/create_Tank/createTank.dart';
import 'package:final_project/pages/tank_details/widgets/tankCard.dart';
import 'package:flutter/material.dart';

class Tankdetails extends StatefulWidget {
  const Tankdetails({super.key});

  @override
  State<Tankdetails> createState() => _TankdetailsState();
}

class _TankdetailsState extends State<Tankdetails> {
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
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Water Tank Levels",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
                ],
              ),
              Tankcard(tankName: "Tank one", percentage: 0.73)
            ],
          ),
        ));
  }
}
