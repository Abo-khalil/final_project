import 'package:final_project/pages/tank_details/tankDetails.dart';
import 'package:flutter/material.dart';

class Createtankbody extends StatefulWidget {
  const Createtankbody({super.key});

  @override
  State<Createtankbody> createState() => _CreatetankbodyState();
}

class _CreatetankbodyState extends State<Createtankbody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Add New Water Tank',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text(
          "Determine the amount of water and maximum capacity and minimum alert threshold.",
          style: TextStyle(color: Color(0xFF5E5E5E), fontSize: 16),
        ),
        const SizedBox(height: 15),
        Form(
          key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount of water',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the amount of water';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Max Capacity (in liters)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter max amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Minimum Alert Level(in liters)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter minimum amount';
                }
                return null;
              },
            ),
          ],
        )),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: const Size(150, 50),
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text("Cancel",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Tankdetails()));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(150, 50),
              ),
              child: const Text("Create",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        )
      ],
    );
  }
}
