import 'package:final_project/core/services/system_services.dart';
import 'package:final_project/pages/system_activate/system_activate.dart';
import 'package:flutter/material.dart';

class SystempageBody extends StatefulWidget {
  const SystempageBody({super.key});

  @override
  State<SystempageBody> createState() => _SystempageBodyState();
}

class _SystempageBodyState extends State<SystempageBody> {
  List<dynamic> sys = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadSystems();
  }

  Future<void> loadSystems() async {
    final result = await SystemServices
        .fetchGlobalSystemData(); // مثال إذا كانت الدالة موجودة داخل كلاس ApiService

    if (mounted) {
      setState(() {
        if (result is List) {
          sys = result;
          isLoading = false;
        } else {
          error = result.toString(); // إذا كان فيه رسالة خطأ
          isLoading = false;
        }
      });
    }
  }

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
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : error != null
                  ? Center(
                      child: Text(
                        "Error: $error",
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : sys.isEmpty
                      ? const Center(child: Text("No systems found."))
                      : ListView.builder(
                          itemCount: sys.length,
                          itemBuilder: (context, index) {
                            final system = sys[index];
                            final name = system["name"] ?? "Unnamed";
                            return GestureDetector(
                                onTap: () {
                                  // Navigate to a new page with the selected system's details
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SystemActivate(system: sys[index])),
                                  );
                                },
                                child: Card(
                                  color: const Color(0xFFA1E592),
                                  elevation: 3,
                                  // ignore: deprecated_member_use
                                  shadowColor: Colors.grey.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(Icons.eco,
                                        color: Colors.white),
                                    title: Text(
                                      name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios,
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
