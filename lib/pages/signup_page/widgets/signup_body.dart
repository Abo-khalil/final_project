import 'package:final_project/core/services/auth_services.dart';
import 'package:final_project/pages/bottom_nav_bar/navigation_bar.dart';
import 'package:final_project/pages/otp_register/otpregister.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _sendOtpAndNavigate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final otpResponse = await AuthService.sendOtp(_emailController.text);

      setState(() {
        _isLoading = false;
      });

      if (otpResponse == "OTP sent successfully") {
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpRegister(
              email: _emailController.text,
              password: _passwordController.text,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              address: _addressController.text,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(otpResponse ?? "فشل في إرسال رمز التحقق"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              onPressed: _isLoading ? null : _sendOtpAndNavigate,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Color(0xFF82B587),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
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
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
