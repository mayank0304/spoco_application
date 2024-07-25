import 'package:flutter/material.dart';
import 'package:spoco_app/model/turf.dart';
import 'package:spoco_app/services/turf-service.dart';

class MyTurfsPage extends StatefulWidget {
  const MyTurfsPage({ super.key});

  @override
  _MyTurfsPageState createState() => _MyTurfsPageState();
}

class _MyTurfsPageState extends State<MyTurfsPage> {
  Turf turf = Turf.getEmptyObject();
  final formKey = GlobalKey<FormState>();
  TurfService service = TurfService();
  bool ShowProgres = false;

  addTurfToDB() async{
    formKey.currentState!.save();
    final result = await service.addTurf(turf);
    print(result);
    if(result.contains["Successfully"]) {
      setState(() {
        ShowProgres = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.black,
      child: ShowProgres ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            Text("Please wait...")
          ],
        ),
      ) : Padding(
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
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: turf.photos.isEmpty ? const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/spoco-cc192.appspot.com/o/profile-pics%2FWEhJwE1ySoTbnxG8HvlnVQqEAVk2.png?alt=media&token=c16af137-6d7a-4647-ba60-00b0b9f9b5f6") : NetworkImage(turf.photos[0]),
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
                  initialValue: turf.name.isNotEmpty ? turf.name : "",
                  onSaved: (value) {
                    turf.name = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                      hintText: "description",
                      labelStyle: const TextStyle(
                          // color: Colors.grey,
                          // fontWeight: FontWeight.bold
                          ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.blue.withOpacity(0.2),
                      filled: true),
                  initialValue: turf.description.isNotEmpty ? turf.description : "",
                  onSaved: (value) {
                    turf.description = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue:
                      turf.addressLine.isNotEmpty ? turf.addressLine : "",
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
                    turf.addressLine = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: turf.city.isNotEmpty ? turf.city : "",
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
                    turf.city = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: turf.state.isNotEmpty ? turf.state : "",
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
                    turf.state = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: turf.country.isNotEmpty ? turf.country : "",
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
                    turf.country = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
               
                TextFormField(
                  // initialValue: turf.rent.isNotEmpty ? turf.rent : "",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                      hintText: "rent",
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
                    turf.rent = int.parse(value!);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    value: turf.condition,
                    items: ["Select Condition", "new", "old"].map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      turf.condition = value!;
                    }),
                    const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // initialValue: turf.capacity.isNotEmpty ? turf.capacity : "",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                      hintText: "capacity",
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
                    turf.capacity = int.parse(value!);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    value:"Select Visibility",
                    items: [
                      "Select Visibility",
                      "Day",
                      "Night",
                      "Both"
                    ].map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      turf.visibility = value!;
                    }),
                
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState((){
                      ShowProgres = true;
                      addTurfToDB();
                    });
                  },
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
