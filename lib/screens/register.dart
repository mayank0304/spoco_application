// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/utils/util.dart';
import 'package:velocity_x/velocity_x.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var obscureText = true;

  register() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // String name = nameController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // 1. Create user in firebase authentication module
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // 2. Get the uid of newly created user
        String uid = credential.user!.uid;
        Util.UID = uid;

        var db = FirebaseFirestore.instance;

        // 3. Create the data as Map, which u wish to store in the database
        // final userData = <String, dynamic>{
        //   "name": name,
        //   "email": email,
        //   "createdOn": DateTime.now()
        // };

        AppUser user = AppUser.getEmptyUser();
        user.name = name;
        user.email = email;
        user.location = Util.geoPoint;
        // AppUser user = AppUser(
        //     name: name,
        //     phone: "",
        //     email: email,
        //     gender: "",
        //     sports: "",
        //     addressLine: "",
        //     city: "",
        //     country: "",
        //     state: "",
        //     location: Util.geoPoint,
        //     role: "",
        //     dateOfBirth: DateTime.now(),
        //     age: 0,
        //     isRepresentedAnyClub: false,
        //     highestLevelPlayed: "",
        //     clubName: "",
        //     schoolCollegeOrgName: "",
        //     username: "",
        //     imageUrl: "",
        //     createdOn: DateTime.now());

        Map<String, dynamic> userData = user.toMap();

        // Add a new document with a generated ID
        // db.collection("users").add(user).then((DocumentReference doc) =>
        //     print('DocumentSnapshot added with ID: ${doc.id}'));

        // 4. Use firebase firestore to create new document in user collection
        db.collection("users").doc(uid).set(userData).then((value) {
          Util.user = user;
          Navigator.of(context).pushReplacementNamed("/home");
        });

        print("Credentials: $credential");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      print(
          "Details of registered user are == email: $email || password: $password");
    } else {
      print("Missing Details == email: $email || password: $password");
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
      //     "Register",
      //     style: TextStyle(fontSize: 25, color: Colors.white),
      //   )),
      //   backgroundColor: Colors.blue,
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
                    child: "Register".text.xl5.white.makeCentered()),
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    80.heightBox,
                    Column(
                      children: [
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          controller: nameController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: Colors.white,
                              hintText: "name",
                              hintStyle: TextStyle(color: Colors.white),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
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
                          controller: emailController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: Colors.white,
                              hintText: "email",
                              hintStyle: TextStyle(color: Colors.white),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
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
                                  child: obscureText? const Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              ) :  const Icon(
                                Icons.visibility,
                                color: Colors.white,
                              )),
                              hintText: "password",
                              hintStyle: const TextStyle(color: Colors.white),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
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
                            onPressed: register,
                            child: const Text("Register")),
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.green[50]),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("/login");
                            },
                            child: const Text(
                              "Existing User? Login Here",
                              style: TextStyle(color: Color(0xFF1A3636)),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
