import 'package:flutter/material.dart';

class CreateSystemBody extends StatelessWidget {
  const CreateSystemBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Create your system!',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text(
          "Determine the right amount of water and the\ntime between every watering that is suitable\nfor your plant.",
          style: TextStyle(color: Color(0xFF5E5E5E), fontSize: 16),
        ),
        const SizedBox(height: 15),
        const Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Watering Frequency (in hours)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Watering Amount (in liters)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Irrigation every(in days)',
                border: OutlineInputBorder(),
              ),
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
              onPressed: () {},
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
