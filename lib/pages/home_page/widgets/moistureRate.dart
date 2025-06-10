
import 'dart:developer';

import 'package:final_project/core/services/embedded.dart';
import 'package:final_project/core/util/constatnt.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MoistureRate extends StatefulWidget {
  const MoistureRate({super.key, });

  @override
  State<MoistureRate> createState() => _MoistureRateState();
}

class _MoistureRateState extends State<MoistureRate> {
  double? humidity;

  @override
  void initState() {
    super.initState();
    loadHumidity();
    log(globalSystem.toString());
  }

  Future<void> loadHumidity() async {
    final result = await Embedded.fetchHumidity('6846daf95674545af5c5dd10');
    setState(() {
      humidity = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percent = (humidity ?? 0) / 100;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.eco, color: Colors.green, size: 20),
                SizedBox(width: 5),
                Text(
                  "Moisture Rate",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Spacer(),
                Text(
                  "Today",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("System Name: ${globalSystem['name'] ?? 'N/A'}", style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text("Duration: ${globalSystem['duration'] ?? 'N/A'}",
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      const Text("Status: Stable",
                          style: TextStyle(fontSize: 14, color: Colors.green)),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 15.0,
                    percent: percent.clamp(0.0, 1.0),
                    center: Text(
                      "${(percent * 100).toInt()}%",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.green,
                      ),
                    ),
                    progressColor: Colors.green,
                    backgroundColor: Colors.green.shade100,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
