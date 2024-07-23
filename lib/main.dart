import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spoco_app/screens/home_page.dart';
import 'package:spoco_app/screens/login.dart';
import 'package:spoco_app/screens/register.dart';
import 'package:spoco_app/screens/splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Splash(),
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/home": (context) => const HomePage(),
      }
    );
  }
}