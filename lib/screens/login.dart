// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("Credentials: $credential");

        Navigator.of(context).pushReplacementNamed("/home");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      print("email: $email || password: $password");
    } else {
      print("Missing details == email: $email || password: $password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Login",
          style: TextStyle(fontSize: 25, color: Colors.white),
        )),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3))),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/register");
                },
                child: const Text("New User? Register Here"))
          ],
        ),
      ),
    );
  }
}
