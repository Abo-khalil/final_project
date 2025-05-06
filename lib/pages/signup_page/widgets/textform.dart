import 'package:flutter/material.dart';

class Textform extends StatefulWidget {
  const Textform(
      {super.key,
      required this.formkey,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      required this.passwordController,
      required this.addressController});
  final GlobalKey<FormState> formkey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<Textform> createState() => _TextformState();
}

class _TextformState extends State<Textform> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Frist Name",
              style: TextStyle(
                  color: Color(0xFFFFF4F4),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            TextFormField(
              controller: widget.firstNameController,
              decoration: const InputDecoration(
                  hintText: 'Frist Name',
                  hintStyle: TextStyle(color: Color(0xffC0C0C0)),
                  prefixIcon: Icon(Icons.person_2_outlined),
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
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const Text(
              "Last Name",
              style: TextStyle(
                  color: Color(0xFFFFF4F4),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            TextFormField(
              controller: widget.lastNameController,
              decoration: const InputDecoration(
                  hintText: 'Last Name',
                  hintStyle: TextStyle(color: Color(0xffC0C0C0)),
                  prefixIcon: Icon(Icons.person_2_outlined),
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
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const Text(
              "Governorate",
              style: TextStyle(
                  color: Color(0xFFFFF4F4),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            TextFormField(
              controller: widget.addressController,
              decoration: const InputDecoration(
                  hintText: 'Governorate',
                  hintStyle: TextStyle(color: Color(0xffC0C0C0)),
                  prefixIcon: Icon(Icons.home_filled),
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
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const Text(
              "Email",
              style: TextStyle(
                  color: Color(0xFFFFF4F4),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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
            const Text(
              "Password",
              style: TextStyle(
                  color: Color(0xFFFFF4F4),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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
          ],
        ));
  }
}
