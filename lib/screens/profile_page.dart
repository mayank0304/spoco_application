import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/utils/util.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // AppUser user = AppUser.getEmptyUser();
  AppUser user = Util.user!;
  final formKey = GlobalKey<FormState>();
  bool club = false;

  pickerDateOfBirth() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime(2024),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

    if (date != null) {
      setState(() {
        user.dateOfBirth = date;
        user.age = DateTime.now().year - date.year;
      });
    }
  }

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

  @override
  void initState() {
    super.initState();
    print(user.toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Personal Details",
                    style: TextStyle(
                        // backgroundColor: Colors.deepPurple,
                        // color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: pickupProfileImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: user.imageUrl.isEmpty ? const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/spoco-cc192.appspot.com/o/profile-pics%2FWEhJwE1ySoTbnxG8HvlnVQqEAVk2.png?alt=media&token=c16af137-6d7a-4647-ba60-00b0b9f9b5f6") : NetworkImage(user.imageUrl),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                      hintText: "name",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  initialValue: user.name.isNotEmpty ? user.name : "",
                  onSaved: (value) {
                    user.name = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                      hintText: "phone",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  initialValue: user.phone.isNotEmpty ? user.phone : "",
                  onSaved: (value) {
                    user.phone = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                      hintText: "email",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  initialValue: user.email.isNotEmpty ? user.email : "",
                  onSaved: (value) {
                    user.email = value!;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ListTile(
                        title: const Text("Male"),
                        leading: Radio(
                            value: "Male",
                            groupValue: user.gender,
                            onChanged: (value) {
                              setState(() {
                                user.gender = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: const Text("Female"),
                        leading: Radio(
                            value: "Female",
                            groupValue: user.gender,
                            onChanged: (value) {
                              setState(() {
                                user.gender = value!;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                DropdownButtonFormField(
                    value: user.sports,
                    items: ["Select Sports", "cricket", "soccer"].map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      user.sports = value!;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue:
                      user.addressLine.isNotEmpty ? user.addressLine : "",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                      hintText: "address",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  onSaved: (value) {
                    user.addressLine = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: user.city.isNotEmpty ? user.city : "",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                      hintText: "city",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  onSaved: (value) {
                    user.city = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: user.state.isNotEmpty ? user.state : "",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                      hintText: "state",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  onSaved: (value) {
                    user.state = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: user.country.isNotEmpty ? user.country : "",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                      hintText: "country",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  onSaved: (value) {
                    user.country = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Role",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ListTile(
                        title: const Text("Player"),
                        leading: Radio(
                            value: "Player",
                            groupValue: user.role,
                            onChanged: (value) {
                              setState(() {
                                user.role = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: const Text("Coach"),
                        leading: Radio(
                            value: "Coach",
                            groupValue: user.role,
                            onChanged: (value) {
                              setState(() {
                                user.role = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: const Text("Ground/Turf owner"),
                        leading: Radio(
                            value: "Ground/Turf owner",
                            groupValue: user.role,
                            onChanged: (value) {
                              setState(() {
                                user.role = value!;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SwitchListTile(
                    title: const Text("Is represented any club? "),
                    value: user.isRepresentedAnyClub,
                    onChanged: (value) {
                      setState(() {
                        club = value;
                        user.isRepresentedAnyClub = value;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    value: user.highestLevelPlayed,
                    items: [
                      "Highest Level Played",
                      "zonal",
                      "district",
                      "state",
                      "national",
                      "international"
                    ].map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      user.highestLevelPlayed = value!;
                    }),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(user.dateOfBirth.toIso8601String()),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: pickerDateOfBirth,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: user.clubName.isNotEmpty ? user.clubName : "",
                  decoration: InputDecoration(
                      labelText: "club name",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  onSaved: (value) {
                    user.clubName = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: user.schoolCollegeOrgName.isNotEmpty
                      ? user.schoolCollegeOrgName
                      : "",
                  decoration: InputDecoration(
                      labelText: "school/ college/ organisation",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  onSaved: (value) {
                    user.schoolCollegeOrgName = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: user.username.isNotEmpty ? user.username : "",
                  decoration: InputDecoration(
                      labelText: "username",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  onSaved: (value) {
                    user.username = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: saveUserToFirebase,
                  style: const ButtonStyle(),
                  child: const Text("Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
