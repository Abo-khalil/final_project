import 'package:final_project/core/services/auth_services.dart';
import 'package:final_project/pages/sign_In_page/sign_in.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isObscure = true;

  void handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final result = await AuthService.resetPassword(
        widget.email,
        otpController.text.trim(),
        passwordController.text.trim(),
      );
      setState(() => isLoading = false);
      if (result == "Password reset successfully") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Password reset successfully"),
              backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignIn()));
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
      backgroundColor: const Color(0xFF00C569),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("OTP Verification",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text("Please enter the 6-digit code sent to your email.",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center),
                const SizedBox(height: 30),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("OTP",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
                TextFormField(
                  controller: otpController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter OTP"
                      : null,
                ),
                const SizedBox(height: 10),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("New Password",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
                TextFormField(
                  controller: passwordController,
                  textAlign: TextAlign.center,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new password";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  color: Colors.white,
                  minWidth: double.infinity,
                  height: 55,
                  onPressed: isLoading ? null : handleResetPassword,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Verify",
                          style: TextStyle(
                              color: Color(0xFF82B587),
                              fontSize: 26,
                              fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
