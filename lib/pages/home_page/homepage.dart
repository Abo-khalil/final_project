import 'package:final_project/pages/home_page/widgets/homepage_body.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: HomepageBody(),
    );
  }
}
