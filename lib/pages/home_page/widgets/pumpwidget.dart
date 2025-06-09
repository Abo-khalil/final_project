import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Pumpwidget extends StatefulWidget {
  const Pumpwidget({super.key});

  @override
  State<Pumpwidget> createState() => _PumpwidgetState();
}

class _PumpwidgetState extends State<Pumpwidget> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('PumpState');
  bool isOn = false;

  @override
  void initState() {
    super.initState();

    // متابعة التحديث من Firebase
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && mounted) {
        setState(() {
          isOn = data == 1;
        });
      }
    });
  }

  void togglePump() {
    final newState = isOn ? 0 : 1;
    _dbRef.set(newState); // إرسال التحديث إلى Firebase
  }

  @override
  Widget build(BuildContext context) {
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
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.settings, size: 20),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Pump",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              isOn ? "On" : "Off",
              style: TextStyle(
                fontSize: 20,
                color: isOn ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: togglePump,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.power_settings_new,
                    size: 32,
                    color: isOn ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
