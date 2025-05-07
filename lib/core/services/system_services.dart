import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateSystemBody extends StatefulWidget {
  const CreateSystemBody({super.key});

  @override
  State<CreateSystemBody> createState() => _CreateSystemBodyState();
}

class _CreateSystemBodyState extends State<CreateSystemBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _irrigationEveryController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  Future<void> addSystem({
    required BuildContext context,
    required String name,
    required String description,
    required int amountWater,
    required int irrigationEvery,
    required int duration,
    required String type,
  }) async {
    final url = Uri.parse('https://automatic-irrigation-system-eirp.vercel.app/api/system');

    final body = {
      'name': name,
      'description': description,
      'amountWater': amountWater,
      'IrrigationEvery': irrigationEvery,
      'duration': duration,
      'type': type,
    };

    try {
      print("Hisham")
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ System added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('🚨 Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('Create your system!',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text(
            "Determine the right amount of water and the\ntime between every watering that is suitable\nfor your plant.",
            style: TextStyle(color: Color(0xFF5E5E5E), fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                  ),
                  const SizedBox(height: 10),

                  const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                  ),
                  const SizedBox(height: 10),

                  const Text("Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextFormField(
                    controller: _typeController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? 'Please enter a type' : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: _irrigationEveryController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Irrigation Every (in days)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter irrigation frequency in days' : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Watering Amount (in liters)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter watering amount' : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duration (in seconds)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter duration' : null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  _nameController.clear();
                  _descController.clear();
                  _typeController.clear();
                  _amountController.clear();
                  _irrigationEveryController.clear();
                  _durationController.clear();
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addSystem(
                      context: context,
                      name: _nameController.text,
                      description: _descController.text,
                      type: _typeController.text,
                      amountWater: int.parse(_amountController.text),
                      irrigationEvery: int.parse(_irrigationEveryController.text),
                      duration: int.parse(_durationController.text),
                    );
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
      ),
    );
  }
}
