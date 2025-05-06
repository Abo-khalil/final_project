import 'package:final_project/core/services/auth_services.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Textform(
          formkey: _formKey,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          addressController: _addressController,
          emailController: _emailController,
          passwordController: _passwordController,
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
                "Sign up",
                style: TextStyle(
                    color: Color(0xFF82B587),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  bool isSuccess = await AuthService.registerUser(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    address: _addressController.text,
                    password: _passwordController.text,
                    context: context,
                  );
                  if (isSuccess) {
                    final userData = await AuthService.loginUser(
                      _emailController.text,
                      _passwordController.text,
                      context,
                    );

                    if (userData != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => BottomBar(userData: userData),
                        ),
                      );
                    }
                  }
                }
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
