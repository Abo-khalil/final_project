import 'package:flutter/material.dart';

class WaterTank extends StatefulWidget {
  const WaterTank({super.key});

  @override
  State<WaterTank> createState() => _WaterTankState();
}

class _WaterTankState extends State<WaterTank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.water_drop, color: Colors.blue, size: 20),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Water Tank",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Icon(
              Icons.water_drop,
              size: 80,
              color: Color.fromARGB(255, 163, 209, 248),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Center(
              child: Text(
                "45%",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
