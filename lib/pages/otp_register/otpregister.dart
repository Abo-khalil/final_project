import 'package:final_project/core/services/auth_services.dart';
import 'package:final_project/pages/bottom_nav_bar/navigation_bar.dart';
import 'package:flutter/material.dart';

class OtpRegister extends StatefulWidget {
  const OtpRegister(
      {super.key,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.address});
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String address;

  @override
  State<OtpRegister> createState() => _OtpRegisterState();
}

class _OtpRegisterState extends State<OtpRegister> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final otp = _otpController.text.trim();

    try {
      final otpValid = await AuthService.verifyOtp(widget.email, otp);

      if (otpValid) {
        final registerSuccess = await AuthService.registerUser(
          firstName: widget.firstName,
          lastName: widget.lastName,
          email: widget.email,
          address: widget.address,
          password: widget.password,
          context: context,
        );

        if (registerSuccess) {
          final userData = await AuthService.loginUser(
            widget.email,
            widget.password,
            context,
          );

          if (userData != null) {
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BottomBar(userData: userData),
              ),
            );
          } else {
            setState(() {
              _errorMessage = "Login failed after registration";
            });
          }
        } else {
          setState(() {
            _errorMessage = "Registration failed";
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll("Exception:", "").trim();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff39B579),
      appBar: AppBar(
        backgroundColor: const Color(0xff39B579),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Please enter the 6-digit code sent to your email.",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _otpController,
              decoration: const InputDecoration(
                  hintText: 'otp',
                  hintStyle: TextStyle(color: Color(0xffC0C0C0)),
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
                  return 'Please enter otp';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                minWidth: double.infinity,
                height: 55,
                color: Colors.white,
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Send",
                        style: TextStyle(
                            color: Color(0xFF82B587),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
