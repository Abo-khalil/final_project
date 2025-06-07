import 'package:final_project/pages/tank_details/tankDetails.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/services/Add_Water_Tank.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Createtankbody extends StatefulWidget {
  const Createtankbody({super.key});

  @override
  State<Createtankbody> createState() => _CreatetankbodyState();
}

class _CreatetankbodyState extends State<Createtankbody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  final TextEditingController _minController = TextEditingController();

  bool _isLoading = false; // حالة انتظار

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
                  controller: _nameController,
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
                  controller: _amountController,
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
                  controller: _maxController,
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
                  controller: _minController,
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
              onPressed: () {
                // مسح الحقول والعودة لصفحة عرض الخزانات
                _nameController.clear();
                _amountController.clear();
                _maxController.clear();
                _minController.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Tankdetails()), // غير هذا للصفحة الحقيقية
                );
              },
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
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        bool success = await createWaterTank(
                          nameTank: _nameController.text.trim(),
                          amountTank: int.parse(_amountController.text),
                          maxTank: int.parse(_maxController.text),
                          minTank: int.parse(_minController.text),
                        );

                        setState(() {
                          _isLoading = false;
                        });

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Water tank created successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Tankdetails()), // غير هذا
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to create water tank.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(150, 50),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text("Create",
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
