import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserManagement {
  storeNewUser(user, images, context)  {
    final List<String> fileNames = [Uuid().v4().toString(), Uuid().v4().toString()];

    for (var i = 0; i < images.length; ++i) {
      FirebaseStorage.instance.ref()
      .child('${user.uid}/' + fileNames[i])
      .putFile(images[i]);
    }

    Firestore.instance
        .collection('/users')
        .add({'email': user.email, 'profilePicId': fileNames[0], 'uid': user.uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((error) {
      print(error);
    });
  }
  
}
