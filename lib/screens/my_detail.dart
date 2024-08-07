import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/utils/util.dart';
import 'package:spoco_app/widgets/text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class MyDetail extends StatefulWidget {
  const MyDetail({super.key});

  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
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

  @override
  void initState() {
    super.initState();
    print(user.toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A3636),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: "${user.name}'s data".text.make(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5, // Set the elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      initVal: user.name.isNotEmpty ? user.name : "",
                      onSav: (value) {
                        user.name = value!;
                      },
                      hint: "name",
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      initVal: user.phone.isNotEmpty ? user.phone : "",
                      onSav: (value) {
                        user.phone = value!;
                      },
                      hint: "phone",
                      icon: const Icon(Icons.phone),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal: user.email.isNotEmpty ? user.email : "",
                        onSav: (value) {
                          user.email = value!;
                        },
                        hint: "email",
                        icon: const Icon(Icons.email)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Gender",
                            style: TextStyle(
                                color: Color(0xFF1A3636),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          ListTile(
                            title: const Text("Male"),
                            leading: Radio(
                                fillColor: const WidgetStatePropertyAll(
                                    Color(0xFF1A3636)),
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
                                fillColor: const WidgetStatePropertyAll(
                                    Color(0xFF1A3636)),
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
                        // borderRadius: BorderRadius.circular(24),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Color(0xFF1A3636), width: 2.0))),
                        value: user.sports.isNotEmpty
                            ? user.sports
                            : "Select Sports",
                        items: ["Select Sports", "cricket", "soccer"].map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          user.sports = value!;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal:
                            user.addressLine.isNotEmpty ? user.addressLine : "",
                        onSav: (value) {
                          user.addressLine = value!;
                        },
                        hint: "address",
                        icon: const Icon(Icons.location_city)),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal: user.city.isNotEmpty ? user.city : "",
                        onSav: (value) {
                          user.city = value!;
                        },
                        hint: "city",
                        icon: const Icon(Icons.location_city)),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal: user.state.isNotEmpty ? user.state : "",
                        onSav: (value) {
                          user.state = value!;
                        },
                        hint: "state",
                        icon: const Icon(Icons.location_city)),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal: user.country.isNotEmpty ? user.country : "",
                        onSav: (value) {
                          user.country = value!;
                        },
                        hint: "country",
                        icon: const Icon(Icons.location_city)),
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
                                fillColor: const WidgetStatePropertyAll(
                                    Color(0xFF1A3636)),
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
                                fillColor: const WidgetStatePropertyAll(
                                    Color(0xFF1A3636)),
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
                                fillColor: const WidgetStatePropertyAll(
                                    Color(0xFF1A3636)),
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
                        activeColor: const Color(0xFF1A3636),
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Color(0xFF1A3636), width: 2.0))),
                        value: user.highestLevelPlayed.isNotEmpty
                            ? user.highestLevelPlayed
                            : "Highest Level Played",
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
                      tileColor: const Color(0xFF1A3636),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)
                      ),
                      title: Text(user.dateOfBirth.toIso8601String(), style: const TextStyle(color: Colors.white),),
                      trailing: const Icon(Icons.calendar_month, color: Colors.white,),
                      onTap: pickerDateOfBirth,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal: user.clubName.isNotEmpty ? user.clubName : "",
                        onSav: (value) {
                          user.clubName = value!;
                        },
                        hint: "club name",
                        icon: const Icon(Icons.group)),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal: user.schoolCollegeOrgName.isNotEmpty
                            ? user.schoolCollegeOrgName
                            : "",
                        onSav: (value) {
                          user.schoolCollegeOrgName = value!;
                        },
                        hint: "school/ college/ organisation",
                        icon: const Icon(Icons.school)),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        initVal: user.username.isNotEmpty ? user.username : "",
                        onSav: (value) {
                          user.username = value!;
                        },
                        hint: "username",
                        icon: const Icon(Icons.person_2_rounded)),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: saveUserToFirebase,
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xFF1A3636))),
                        child: "Save".text.white.xl.make(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
