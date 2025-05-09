import 'package:flutter/material.dart';

class Alertmassege extends StatelessWidget {
  const Alertmassege({
    super.key,
    required this.titeltext,
    required this.contenttext,
    required this.button1,
    required this.button2,
    required this.onConfirm,
  });
  final String titeltext;
  final String contenttext;
  final String button1;
  final String button2;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
          child: Text(
        titeltext,
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      content: Text(
        contenttext,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            button1,
            style: const TextStyle(
                color: Color(0xFF39B579), fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: 20,
          width: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () {
            // logout logic
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            button2,
            style: const TextStyle(
                color: Color(0xFF39B579), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
