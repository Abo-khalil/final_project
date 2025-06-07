import 'package:final_project/core/services/auth_services.dart';
import 'package:final_project/pages/otp_page/otpPage.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void handleSendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final result = await AuthService.sendOtp(emailController.text.trim());

      setState(() => isLoading = false);

      if (result == "OTP sent successfully") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(email: emailController.text.trim()),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(result ?? "Error"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff39B579),
      appBar: AppBar(backgroundColor: const Color(0xff39B579)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Forget Password?",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),

            const Text(
              "Please enter your email.",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'email',
                  prefixIcon: Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 60),
            MaterialButton(
              color: Colors.white,
              minWidth: double.infinity,
              height: 55,
              onPressed: isLoading ? null : handleSendOtp,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      "Send",
                      style: TextStyle(
                          color: Color(0xFF82B587),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
