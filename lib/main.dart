import 'package:final_project/pages/sign_In_page/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD4-RE-GGkWLjyc9TG1MMZi-jMvkBEBbn8',
      appId: '1:854970310579:android:751fa20b35c8327a20a507',
      messagingSenderId: '854970310579',
      projectId: 'smart-irregation-af58a',
      databaseURL:
          'https://smart-irregation-af58a-default-rtdb.europe-west1.firebasedatabase.app/',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Final project',
        home: SignIn());
  }
}
