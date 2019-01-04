import 'dart:io';

class UserViewModel {
  final String id;
  final String name;
  final String age;
  final String about;
  final String school;
  final String height;
  final String occupation;
  final String employer;
  final String education;

  final String lie;
  final String truth1;
  final String truth2;

  final List<File> images;

  UserViewModel({
    this.id,
    this.name,
    this.age,
    this.about,
    this.school,
    this.height,
    this.occupation,
    this.employer,
    this.education,
    this.lie,
    this.truth1,
    this.truth2,
    this.images,
  });
}
