import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spoco_app/utils/util.dart';

class Turf {
  String name;
  String description;
  String addressLine;
  String country;
  String city;
  String state;
  GeoPoint location;
  List<String> photos;
  int rent;
  String condition; // new, old
  int capacity;
  String visibility; // day or night or both
  String uid;
  DateTime createdOn;

  Turf({
    required this.name,
    required this.description,
    required this.addressLine,
    required this.country,
    required this.city,
    required this.state,
    required this.location,
    required this.photos,
    required this.rent,
    required this.condition,
    required this.capacity,
    required this.visibility,
    required this.uid,
    required this.createdOn,
  });

  // Convert a Turf object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'addressLine': addressLine,
      'country': country,
      'city': city,
      'state': state,
      'location': location,
      'photos': photos,
      'rent': rent,
      'condition': condition,
      'capacity': capacity,
      'visibility': visibility,
      'uid': uid,
      'createdOn': createdOn,
    };
  }

  // Create a Turf object from a map
  factory Turf.fromMap(Map<String, dynamic> map) {
    return Turf(
      name: map['name'],
      description: map['description'],
      addressLine: map['addressLine'],
      country: map['country'],
      city: map['city'],
      state: map['state'],
      location: map['location'],
      photos: List<String>.from(map['photos']),
      rent: map['rent'],
      condition: map['condition'],
      capacity: map['capacity'],
      visibility: map['visibility'],
      uid: map['uid'],
      createdOn: (map['createdOn'] as Timestamp).toDate(),
    );
  }

  static Turf getEmptyObject() {
    return Turf(
        name: "",
        description: "",
        addressLine: "",
        country: "",
        city: "",
        state: "",
        location: Util.geoPoint,
        photos: [],
        rent: 0,
        condition: "Select Condition",
        capacity: 0,
        visibility: "Select Visibilty",
        uid: Util.UID,
        createdOn: DateTime.now());
  }
}