import 'package:flutter/material.dart';

class Otppage extends StatefulWidget {
  const Otppage({super.key});

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C569), // الأخضر المستخدم
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please enter the 6-digit code sent\nto your email.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Form(
                  child: TextFormField(
                    textAlign: TextAlign.center, 
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Color(0xffC0C0C0)),
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
                      if (value.length < 6) {
                        return 'otp must be 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: MaterialButton(
                    
                      color: Colors.white,
                      minWidth: double.infinity,
                      height: 55,
                      onPressed: () {},
                      child: const Text(
                        "Verify",
                        style: TextStyle(
                            color: Color(0xFF82B587),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    text: "Didn't receive the code?",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: " Resend",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
