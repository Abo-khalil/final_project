import 'package:flutter/material.dart';

class Tankcard extends StatelessWidget {
  const Tankcard({super.key, required this.tankName, required this.percentage});
  final String tankName;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tankName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: 12,
                backgroundColor: Colors.blue[100],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlue),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${(percentage * 100).toInt()}%",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );;
  }
}