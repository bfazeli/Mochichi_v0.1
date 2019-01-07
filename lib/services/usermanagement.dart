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
  Future<void> fetchCurrentUser() async {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection("users")
          .document(user.uid)
          .get()
          .then((snapshot) {
            print(snapshot.data);
            // Work on this portion
            //  - Need to send data over to homepage,
            //      (look into this)
            var currentUser = UserViewModel.fromJson(snapshot.data);
          });
    });
  }
}
