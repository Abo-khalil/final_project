import 'package:final_project/pages/forget_password/email.dart';
import 'package:flutter/material.dart';

class Signinform extends StatefulWidget {
  const Signinform(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.passwordController});
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<Signinform> createState() => _SigninformState();
}

class _SigninformState extends State<Signinform> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
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
              controller: widget.emailController,
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
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Password",
              style: TextStyle(
                  color: Color(0xFFFFF4F4),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: widget.passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                hintText: 'password',
                hintStyle: const TextStyle(color: Color(0xffC0C0C0)),
                prefixIcon: const Icon(Icons.lock),
                prefixIconColor: const Color(0xff82B587),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EmailPage()));
                    },
                    child: const Text(
                      "Forget password?",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ],
        ));
  }
}
