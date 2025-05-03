import 'package:final_project/pages/account_page/widgets/alertmassege.dart';
import 'package:final_project/pages/account_page/widgets/customwidget.dart';
import 'package:flutter/material.dart';

class Acountpagebody extends StatelessWidget {
  const Acountpagebody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.account_circle,
                size: 70,
                color: Color(0xFFC8C8C8),
              ),
              SizedBox(width: 16),
              Text(
                "Mohamed Ibrahim",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Customwidget(
            text: "Permissions",
            icon: const Icon(Icons.arrow_right_outlined),
            onTap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          Customwidget(
            text: "Contact us",
            icon: const Icon(Icons.arrow_right_outlined),
            onTap: () {},
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
                    return const Alertmassege(
                        titeltext: "Logout",
                        contenttext: "Are you sure you want to logout?",
                        button1: "Cancel",
                        button2: "Logout");
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
