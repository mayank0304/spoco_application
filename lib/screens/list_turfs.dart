import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/turf.dart';

class ListTurfs extends StatefulWidget {
  const ListTurfs({super.key});

  @override
  _ListTurfsState createState() => _ListTurfsState();
}

class _ListTurfsState extends State<ListTurfs> {
  signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: signout,
              icon: const Icon(Icons.logout_rounded),
            ),
          ]),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("turfs").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong. Please try again"),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text("No data found"),
              );
            }

            List<Turf> turfs = snapshot.data!.docs
                .map((doc) => Turf.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView(
              children: turfs
                  .map((turf) => Card(
                    color: Colors.blue[50],
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                            Image.network(turf.photos[0], height: 250, width: 250,),
                            const SizedBox(
                              height: 10,
                            ),
                             Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(turf.name, style: const TextStyle(fontSize: 20, color: Colors.blue),),
                                  Text(turf.description, style: const TextStyle(fontSize: 20,),),
                                  Text(turf.condition, style: const TextStyle(fontSize: 20),),
                                  Text("\u20b9 ${turf.rent} per hour", style: const TextStyle(fontSize: 20, color: Colors.red),),
                                ],
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
                                  IconButton(onPressed: () {}, icon: const Icon(Icons.update)),
                                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
                                ],
                               ),
                             )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
    );
  }
}
