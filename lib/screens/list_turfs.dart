import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/turf.dart';
import 'package:velocity_x/velocity_x.dart';

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
      backgroundColor: Color(0xFF1A3636),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          title: const Center(
            child:  Text(
              "Turfs",
              style: TextStyle(color: Colors.white, fontWeight:  FontWeight.bold),
            ),
          ),
          ),
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
                        color: Colors.white,
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              turf.photos.isNotEmpty &&
                                      turf.photos.isNotEmpty
                                  ? FanCarouselImageSlider.sliderType2(
                                      imagesLink: 
                                        turf.photos.map((index) => index).toList(),
                                      isAssets: false,
                                      autoPlay: false,
                                      sliderHeight: 250,
                                      currentItemShadow: const [],
                                      sliderDuration:
                                          const Duration(milliseconds: 200),
                                      imageRadius: 10,
                                      slideViewportFraction: 1,
                                    )
                                  : Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/spoco-cc192.appspot.com/o/turf-pics%2FIMG-20240728-WA0002.jpg?alt=media&token=cc922efa-ba94-4d40-8e26-3df13fac51ee"),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        turf.name,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                      Text(
                                        "${turf.city}, ${turf.state}, ${turf.country}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      // 
                                      Text(
                                        "\u20b9 ${turf.rent} per hour",
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed("/turfdetail", arguments: turf);
                                        },
                                        icon: const Icon(Icons.info_outline)),
                                    
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(Color(0xFF1A3636)),
                                        foregroundColor: WidgetStatePropertyAll(Colors.white)
                                      ),
                                      onPressed: () {
                                      Navigator.of(context).pushNamed("/turfdetail", arguments: turf);
                                    }, child: "Book Now".text.makeCentered()),
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: const Icon(Icons.delete))
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