import 'dart:io';
import 'package:tuple/tuple.dart';

class UserViewModel {
  const UserViewModel({
    this.uid,
    this.email,
    this.name,
    this.age,
    this.ethnicity,
    this.religion,
    this.about,
    this.school,
    this.height,
    this.occupation,
    this.employer,
    this.education,
    this.lie,
    this.truth1,
    this.truth2,
    this.location,
    this.imageUrls,
  });


  final String uid;
  final String email;
  final String name;
  final String age;
  final String ethnicity;
  final String religion;
  final String about;
  final String school;
  final String height;
  final String occupation;
  final String employer;
  final String education;

  final String lie;
  final String truth1;
  final String truth2;
  final Map<String, String> location;
  final Map<String, String> imageUrls;

  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
      uid: json['uid'] ?? "",
      email: json['email'] ?? "",
      name: json['name'] ?? "",
      age: json['age'] ?? "",
      ethnicity: json['ethnicity'] ?? "",
      religion: json['religion'] ?? "",
      about: json['about'] ?? "",
      school: json['school'] ?? "",
      height: json['height'] ?? "",
      occupation: json['occupation'] ?? "",
      employer: json['employer'] ?? "",
      education: json['education'] ?? "",
      lie: json['lie'] ?? "",
      truth1: json['truth1'] ?? "",
      truth2: json['truth2'] ?? "",
      location: Map<String, String>.from(json['location'] ?? {}),
      imageUrls: Map<String, String>.from(json['imageUrls'] ?? {}),
    );
  }
}
