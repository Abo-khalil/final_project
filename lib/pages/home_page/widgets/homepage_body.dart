import 'package:final_project/pages/account_page/accountpage.dart';
import 'package:final_project/pages/home_page/widgets/moistureRate.dart';
import 'package:final_project/pages/home_page/widgets/pumpwidget.dart';
import 'package:final_project/pages/home_page/widgets/water_tank.dart';
import 'package:flutter/material.dart';

class HomepageBody extends StatefulWidget {
  const HomepageBody({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<HomepageBody> createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Accountpage(userData: widget.userData,)));
                  },
                  icon: const Icon(
                      size: 45,
                      color: Color(0xFFC8C8C8),
                      Icons.account_circle)),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: MoistureRate(),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: Pumpwidget()),
              SizedBox(
                width: 10,
              ),
              Expanded(child: WaterTank()),
            ],
          ),
        )
      ],
    );
  }
}
