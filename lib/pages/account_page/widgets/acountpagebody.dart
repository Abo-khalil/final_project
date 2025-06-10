import 'package:final_project/pages/account_page/widgets/alertmassege.dart';
import 'package:final_project/pages/account_page/widgets/customwidget.dart';
import 'package:final_project/pages/contact_us/contactus.dart';
import 'package:final_project/pages/sign_In_page/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Acountpagebody extends StatelessWidget {
  const Acountpagebody({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_circle,
                size: 70,
                color: Color(0xFFC8C8C8),
              ),
              const SizedBox(width: 16),
              Text(
                userData['role'] ?? "no name",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          
          Customwidget(
            text: "Contact us",
            icon: const Icon(Icons.arrow_right_outlined),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Contactus()));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Customwidget(
            text: "Log out",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Alertmassege(
                      titeltext: "Logout",
                      contenttext: "Are you sure you want to logout?",
                      button1: "Cancel",
                      button2: "Logout",
                      onConfirm: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('token');
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const SignIn()),
                          (route) => false,
                        );
                      },
                    );
                  });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Customwidget(
            text: "Version",
            subtext: const Text(
              "1.0",
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Color(0xFF888888)),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
