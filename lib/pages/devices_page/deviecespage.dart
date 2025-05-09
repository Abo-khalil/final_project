import 'package:final_project/pages/account_page/widgets/alertmassege.dart';
import 'package:flutter/material.dart';

class Deviecespage extends StatelessWidget {
  const Deviecespage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 10),
            child: Row(
              children: [
                Spacer(),
                Icon(
                  Icons.add,
                  size: 30,
                )
              ],
            ),
          ),
          const Text(
            "Devices",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.white,
            child: ListTile(
              title: const Text(
                "My devieces",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              subtitle:
                  const Text("Add devices to be \ncontrolled by the app."),
              trailing: TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF39B579))),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Alertmassege(
                            titeltext: "Turn on",
                            contenttext:
                                "To connect devices, you need to turn on your phone’s Blutooth.",
                            button1: "Cancel",
                            button2: "Turn on",
                            onConfirm: () {},
                          );
                        });
                  },
                  child: const Text(
                    "Add device",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
