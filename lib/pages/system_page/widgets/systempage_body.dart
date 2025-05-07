import 'package:final_project/pages/system_activate/system_activate.dart';
import 'package:flutter/material.dart';

class SystempageBody extends StatefulWidget {
  const SystempageBody({super.key});

  @override
  State<SystempageBody> createState() => _SystempageBodyState();
}

class _SystempageBodyState extends State<SystempageBody> {
  List sys = [
    {"name": "Lavender", "img": "images/50d10ad4698214455e68c9a817e40efe.png"},
    {"name": "Tagetes", "img": "images/tagetes.png"},
    {"name": "Tomato", "img": "images/tomato.png"},
    {"name": "Peas", "img": "images/peas.png"},
    {"name": "Peas", "img": "images/peas.png"},
    {"name": "Peas", "img": "images/peas.png"},
    {"name": "Peas", "img": "images/peas.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text("Systems",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.w400)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sys.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    // Navigate to a new page with the selected system's details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SystemActivate()),
                    );
                  },
                  child: Card(
                    color: const Color(0xFFA1E592),
                    elevation: 3,
                    shadowColor: Colors.grey.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.eco, color: Colors.white),
                      title: Text(
                        sys[index]["name"],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }
}
