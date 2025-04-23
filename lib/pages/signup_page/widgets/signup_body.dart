import 'package:final_project/pages/bottom_nav_bar/navigation_bar.dart';
import 'package:final_project/pages/sign_In_page/sign_in.dart';
import 'package:final_project/pages/signup_page/widgets/textform.dart';
import 'package:flutter/material.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Center(
          child: Text(
            "Sign up",
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 55,
        ),
        const Textform(),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: MaterialButton(
              color: Colors.white,
              minWidth: double.infinity,
              height: 55,
              child: const Text(
                "Sign up",
                style: TextStyle(
                    color: Color(0xFF82B587),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const BottomBar()));
              }),
        ),
        Row(
          children: [
            const Text(
              "Already have an account?",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            TextButton(
                child: const Text(
                  "Log in",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignIn()));
                })
          ],
        ),
      ],
    );
  }
}
