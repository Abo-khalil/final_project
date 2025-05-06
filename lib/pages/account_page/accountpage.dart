import 'package:final_project/pages/account_page/widgets/acountpagebody.dart';
import 'package:flutter/material.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key, required this.userData});
  final Map<String, dynamic> userData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      body:  Acountpagebody(userData: userData,),
    );
  }
}
