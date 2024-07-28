import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/utils/util.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppUser user = Util.user!;
  final formKey = GlobalKey<FormState>();
  bool club = false;

  saveUserToFirebase() {
    formKey.currentState!.save();

    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(Util.UID)
          .set(user.toMap())
          .then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User Data saved")));
      });
    } catch (e) {
      print("Exception while saving user profile");
      print(e);
    }
  }

  pickupProfileImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        print("File Path: ${file.path}");

        final storageRef = FirebaseStorage.instance.ref();
        final profilePicsRef = storageRef.child("profile-pics/${Util.UID}.png");

        print("Starting upload...");
        await profilePicsRef.putFile(file);
        print("Upload complete");

        user.imageUrl = await profilePicsRef.getDownloadURL();
        saveUserToFirebase();
        print("Image Url is: ${user.imageUrl}");
      } else {
        print("User canceled the picker");
      }
    } on FirebaseException catch (e) {
      print("FirebaseException: $e");
    } catch (e) {
      print("Exception: $e");
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }

  @override
  void initState() {
    super.initState();
    print(user.toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          VxArc(
            height: 18,
            child: Container(
              height: 400,
              color: const Color(0xFF1A3636),
              child: Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    35.heightBox,
                    GestureDetector(
                      onTap: pickupProfileImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: user.imageUrl.isEmpty
                            ? const NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/spoco-cc192.appspot.com/o/profile-pics%2FWEhJwE1ySoTbnxG8HvlnVQqEAVk2.png?alt=media&token=c16af137-6d7a-4647-ba60-00b0b9f9b5f6")
                            : NetworkImage(user.imageUrl),
                      ),
                    ),
                    15.heightBox,
                    user.name.text.white.xl.make(),
                    user.email.text.white.xl.make(),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/mydata");
                          },
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.white,
                                  ),
                                  "Edit Profile".text.white.makeCentered(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/mydata");
                          },
                          child: Row(
                            children: [
                              "My Details".text.black.xl.make(),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_right_rounded)
                            ],
                          )),
                      const Spacer(),
                      const Divider(),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/addturf");
                          },
                          child: Row(
                            children: [
                              "Add Turf".text.black.xl.make(),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_right_rounded)
                            ],
                          )),
                      const Spacer(),
                      const Divider(),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              "Settings".text.black.xl.make(),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_right_rounded)
                            ],
                          )),
                      const Spacer(),
                      const Divider(),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              "Support".text.black.xl.make(),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_right_rounded)
                            ],
                          )),
                      const Spacer(),
                      const Divider(),
                      const Spacer(),
                      GestureDetector(
                          onTap: signout,
                          child: Row(
                            children: [
                              "Sign Out".text.black.xl.make(),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_right_rounded)
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
