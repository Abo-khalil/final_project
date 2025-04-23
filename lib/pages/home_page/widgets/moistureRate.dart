import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MoistureRate extends StatefulWidget {
  const MoistureRate({super.key});

  @override
  State<MoistureRate> createState() => _MoistureRateState();
}

class _MoistureRateState extends State<MoistureRate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.eco, color: Colors.green, size: 20),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Moisture Rate",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
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
                const Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("System: Lavender", style: TextStyle(fontSize: 14)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Watering after: 3 days",
                        style: TextStyle(fontSize: 14)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Status: Stable",
                        style: TextStyle(fontSize: 14, color: Colors.green)),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 15.0,
                    percent: 0.37,
                    center: const Text("37%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.green)),
                    progressColor: Colors.green,
                    backgroundColor: Colors.green.shade100,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
