import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserManagement {
  storeNewUser(user, images, context) async {
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
      uploadTask = ref.child('${user.uid}/' + fileNames[i])
      .putFile(images[i]);
      imageUrls['imageUrl${i + 1}'] = (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    }
    

    final docData = {
      'email': user.email, 
      'uid': user.uid, 
      'imageUrl1' : imageUrls['imageUrl1'], 
      'imageUrl2' : imageUrls['imageUrl1'], 
    };

    Firestore.instance
        .collection('users')
        .document(user.uid.toString())
        .setData(docData);
  }
}
