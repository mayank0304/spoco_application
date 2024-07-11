import 'package:flutter/material.dart';
import 'package:spoco_app/model/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppUser user = AppUser.getEmptyUser();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const Center(
                child: Text("Personal Details", style: TextStyle(
                  // backgroundColor: Colors.deepPurple,
                  // color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
              ),
              const SizedBox(height: 20,),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.withOpacity(0.2),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration:  InputDecoration(
                  labelText: "Name",
                  labelStyle: const TextStyle(
                    // color: Colors.grey,
                    fontWeight: FontWeight.bold
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  fillColor: Colors.blue.withOpacity(0.2),
                  filled: true
                  ),
                onSaved: (value) {
                  user.name = value!;
                },
              ),
              const SizedBox(height: 20,),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone",
                  labelStyle: const TextStyle(
                    // color: Colors.grey,
                    fontWeight: FontWeight.bold
                  ),
                   border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  fillColor: Colors.blue.withOpacity(0.2),
                  filled: true
                  ),
                onSaved: (value) {
                  user.phone = value!;
                },
              ),
              const SizedBox(height: 20,),

              TextFormField(
                decoration:  InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(
                    // color: Colors.grey,
                    fontWeight: FontWeight.bold
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  fillColor: Colors.blue.withOpacity(0.2),
                  filled: true
                  ),
                onSaved: (value) {
                  user.email = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Gender",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
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
                    DropdownButtonFormField(
                        value: "Select Sports",
                        items: ["Select Sports", "cricket", "soccer"].map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          user.gender = value!;
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
