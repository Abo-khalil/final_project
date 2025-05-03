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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.9,
            ),
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFA1E592),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              sys[index]["img"],
                              height: 120,
                              width: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        flex: 1,
                        child: Text(
                          sys[index]["name"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
