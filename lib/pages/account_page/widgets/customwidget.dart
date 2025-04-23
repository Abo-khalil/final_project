import 'package:flutter/material.dart';

class Customwidget extends StatelessWidget {
  const Customwidget(
      {super.key,
      required this.text,
      this.icon,
      this.subtext,
      required this.onTap});
  final String text;
  final Icon? icon;
  final Text? subtext;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: icon,
        subtitle: subtext,
        onTap: onTap,
      ),
    );
  }
}
