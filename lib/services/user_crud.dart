import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart';
import 'package:uuid/uuid.dart';
import 'package:mochichi/user_data.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserManagement {
  storeNewUser(user, name, images, context) async {
    StorageReference ref = FirebaseStorage.instance.ref();
    StorageUploadTask uploadTask;

    final List<String> fileNames = [
      Uuid().v4().toString(),
      Uuid().v4().toString()
    ];
    final Map<String, String> imageUrls = {};

    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/homepage');

    for (var i = 0; i < images.length; i++) {
      uploadTask = ref.child('${user.uid}/' + fileNames[i]).putFile(images[i]);
      imageUrls['imageUrl${i + 1}'] =
          (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    }

    final docData = {
      'name': name,
      'email': user.email,
      'uid': user.uid,
      'imageUrls': imageUrls,
    };

    Firestore.instance
        .collection('users')
        .document(user.uid.toString())
        .setData(docData);
  }

  // Change void to the result from firebase
  Future<UserViewModel> fetchCurrentUser() async {
    return await FirebaseAuth.instance.currentUser().then((user) {
      return Firestore.instance
          .collection("users")
          .document(user.uid)
          .get()
          .then((snapshot) {
        return UserViewModel.fromJson(snapshot.data);
      });
    });
  }

  Future<List<UserViewModel>> fetchAllUsers(uid) async {
    return Firestore.instance
        .collection("users")
        .limit(10)
        .getDocuments()
        .then((result) {
      List<UserViewModel> listOfUsers = [];
      for (var snapShot in result.documents) {
        if (snapShot.data['uid'] != uid) {
          listOfUsers.add(UserViewModel.fromJson(snapShot.data));
        }
      }
      print(listOfUsers);
      return listOfUsers;
    });
  }
}
