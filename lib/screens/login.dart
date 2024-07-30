// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/utils/util.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  // Kind of Destructor
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("Credentials: $credential");

        FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .get()
            .then((DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          Util.user = AppUser.fromMap(data);
          Navigator.of(context).pushReplacementNamed("/home");
        });
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

  obscurePass() {
    setState(() {
      if (obscureText == false) {
        obscureText = true;
      } else {
        obscureText = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Center(
      //       child: Text(
      //     "Login",
      //     style: TextStyle(fontSize: 25, color: Colors.white),
      //   )),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: VxArc(
                arcType: VxArcType.convey,
                height: 20,
                child: Container(
                    color: const Color(0xFF1A3636),
                    child: "Login".text.xl5.white.makeCentered()),
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Colors.white,
                        hintText: "email",
                        hintStyle: TextStyle(color: Colors.white),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            borderSide: BorderSide(width: 3)),
                        filled: true,
                        fillColor: Color(0xFF1A3636)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    obscureText: obscureText,
                    controller: passwordController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: Colors.white,
                        suffixIcon: InkWell(
                            splashColor: Colors.transparent,
                            onTap: obscurePass,
                            child: obscureText
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  )),
                        hintText: "password",
                        hintStyle: const TextStyle(color: Colors.white),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            borderSide: BorderSide(width: 3)),
                        filled: true,
                        fillColor: const Color(0xFF1A3636)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xFF1A3636)),
                          foregroundColor:
                              WidgetStatePropertyAll(Colors.white)),
                      onPressed: login,
                      child: const Text("Login")),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.green[50]),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/register");
                    },
                    child: const Text(
                      "New User? Register Here",
                      style: TextStyle(color: Color(0xFF1A3636)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
