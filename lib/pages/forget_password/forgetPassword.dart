import 'package:final_project/pages/otp_page/otpPage.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff39B579),
      appBar: AppBar(
        backgroundColor: const Color(0xff39B579),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Please enter your email.",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      color: Color(0xFFFFF4F4),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'email',
                      hintStyle: TextStyle(color: Color(0xffC0C0C0)),
                      prefixIcon: Icon(Icons.email_outlined),
                      prefixIconColor: Color(0xff82B587),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@gmail.com')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
              ],
            )),
            const SizedBox(height: 60,),
            Center(
              child: MaterialButton(
                  color: Colors.white,
                  minWidth: double.infinity,
                  height: 55,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Otppage()));
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(
                        color: Color(0xFF82B587),
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
