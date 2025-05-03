import 'package:final_project/core/services/auth_services.dart';
import 'package:final_project/pages/bottom_nav_bar/navigation_bar.dart';
import 'package:final_project/pages/sign_In_page/widgets/SignInForm.dart';
import 'package:final_project/pages/signup_page/signup.dart';
import 'package:flutter/material.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Center(
          child: Text(
            "Sign In",
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 55,
        ),
        Signinform(
          formKey: _formKey,
          emailController: emailController,
          passwordController: passwordController,
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: MaterialButton(
              color: Colors.white,
              minWidth: double.infinity,
              height: 55,
              child: const Text(
                "Log in",
                style: TextStyle(
                    color: Color(0xFF82B587),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final success = await AuthService.loginUser(
                      emailController.text, passwordController.text, context);
                  if (success) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const BottomBar()));
                  }
                }
              }),
        ),
        Row(
          children: [
            const Text(
              "Don’t have an account?",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            TextButton(
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Signup()));
                })
          ],
        ),
      ],
    );
  }
}
