import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_project/pages/devices_page/deviecespage.dart';
import 'package:final_project/pages/home_page/homepage.dart';
import 'package:final_project/pages/system_page/systempage.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  List<Widget> pages = [
    const Homepage(),
    const Systempage(),
    const Deviecespage()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color(0xFFFAFAFA),
          color: const Color(0xFF39B579),
          animationDuration: const Duration(milliseconds: 400),
          index: 0,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
              size: 35,
            ),
            Icon(
              Icons.water_drop,
              color: Colors.white,
              size: 35,
            ),
            Icon(
              Icons.bluetooth,
              color: Colors.white,
              size: 35,
            ),
          ]),
      body: pages[index],
    );
  }
}
