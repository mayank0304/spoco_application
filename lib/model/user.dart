import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spoco_app/utils/util.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String name;
  String phone;
  String email;
  String gender;
  String sports;
  String addressLine;
  String city;
  String country;
  String state;
  GeoPoint location;
  String role;
  DateTime dateOfBirth;
  int age;
  bool isRepresentedAnyClub;
  String highestLevelPlayed;
  String clubName;
  String schoolCollegeOrgName;
  String username;
  String imageUrl;
  DateTime createdOn;
  AppUser({
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.sports,
    required this.addressLine,
    required this.city,
    required this.country,
    required this.state,
    required this.location,
    required this.role,
    required this.dateOfBirth,
    required this.age,
    required this.isRepresentedAnyClub,
    required this.highestLevelPlayed,
    required this.clubName,
    required this.schoolCollegeOrgName,
    required this.username,
    required this.imageUrl,
    required this.createdOn,
  });

  static AppUser getEmptyUser() {
    return AppUser(
        name: "",
        phone: "",
        email: "",
        gender: "",
        sports: "",
        addressLine: "",
        city: "",
        country: "",
        state: "",
        location: Util.geoPoint,
        role: "",
        dateOfBirth: DateTime.now(),
        age: 0,
        isRepresentedAnyClub: false,
        highestLevelPlayed: "",
        clubName: "",
        schoolCollegeOrgName: "",
        username: "",
        imageUrl: "",
        createdOn: DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'gender': gender,
      'sports': sports,
      'addressLine': addressLine,
      'city': city,
      'country': country,
      'state': state,
      'location': location,
      'role': role,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'age': age,
      'isRepresentedAnyClub': isRepresentedAnyClub,
      'highestLevelPlayed': highestLevelPlayed,
      'clubName': clubName,
      'schoolCollegeOrgName': schoolCollegeOrgName,
      'username': username,
      'imageUrl': imageUrl,
      'createdOn': createdOn,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      gender: map['gender'],
      sports: map['sports'],
      addressLine: map['addressLine'],
      city: map['city'],
      country: map['country'],
      state: map['state'],
      location: map['location'],
      role: map['role'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      age: map['age'],
      isRepresentedAnyClub: map['isRepresentedAnyClub'],
      highestLevelPlayed: map['highestLevelPlayed'],
      clubName: map['clubName'],
      schoolCollegeOrgName: map['schoolCollegeOrgName'],
      username: map['username'],
      imageUrl: map['imageUrl'],
      createdOn: map['createdOn'],
    );
  }
}
