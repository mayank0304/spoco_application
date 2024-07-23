// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
name
city
state 
location
photos 
rent 
condition
capacity
visibility preference
*/
import 'package:cloud_firestore/cloud_firestore.dart';

class Turf {
  String name;
  String description;
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
}
