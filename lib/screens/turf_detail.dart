import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/turf.dart';
import 'package:velocity_x/velocity_x.dart';

class TurfDetail extends StatefulWidget {
  const TurfDetail({super.key});

  @override
  _TurfDetailState createState() => _TurfDetailState();
}

class _TurfDetailState extends State<TurfDetail> {
  @override
  Widget build(BuildContext context) {
    var turf = ModalRoute.of(context)!.settings.arguments as Turf;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: turf.name.text.make(),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF1A3636),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF1A3636),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonBar(
            children: [
              Text(
                "\u20b9 ${turf.rent} per hour",
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFF1A3636)),
                      foregroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed("/turfdetail", arguments: turf);
                  },
                  child: "Book Now".text.make()),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: VxArc(
              height: 20,
              child: Container(
                color: const Color(0xFF1A3636),
                child: Column(
                  children: [
                    turf.photos.isNotEmpty && turf.photos.isNotEmpty
                        ? FanCarouselImageSlider.sliderType1(
                            imagesLink:
                                turf.photos.map((index) => index).toList(),
                            isAssets: false,
                            autoPlay: false,
                            sliderHeight: 250,
                            currentItemShadow: const [],
                            sliderDuration: const Duration(milliseconds: 200),
                            imageRadius: 10,
                            slideViewportFraction: 1,
                          )
                        : Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/spoco-cc192.appspot.com/o/turf-pics%2FIMG-20240728-WA0002.jpg?alt=media&token=cc922efa-ba94-4d40-8e26-3df13fac51ee"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              turf.name.text.make(),
              turf.description.text.make(),
              Text(
                "${turf.city}, ${turf.state}, ${turf.country}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                turf.condition,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
