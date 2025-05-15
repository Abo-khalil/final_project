import 'dart:io';
import 'dart:typed_data';

import 'package:final_project/core/services/ai.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  File? _imageFile;
  Uint8List? _imageBytes;
  List<dynamic> _predictions = [];
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await ImageService.uploadImage(pickedFile);

        setState(() {
          _imageBytes = response['bytes'];
          _imageFile = File(pickedFile.path);
          _predictions = response['result'];
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error occurred: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                _imageBytes != null
                    ? Image.memory(
                        _imageBytes!,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "images/image.png",
                        height: 200,
                      ),
                const SizedBox(height: 20),
                const Text(
                  "Upload a Photo of Your Plant",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "We'll analyze it to check if it's healthy or\nidentify any possible illnesses.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.green),
                  ),
                if (!_isLoading && _predictions.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Diagnosis Result:",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      const SizedBox(height: 10),
                      ..._predictions.map((result) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Class: ${result['class_name']}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Confidence: ${(result['confidence'] * 100).toStringAsFixed(2)}%",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
