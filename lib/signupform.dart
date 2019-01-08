import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './services/user_crud.dart';
import './services/loader.dart';
import 'package:image_picker/image_picker.dart';

const padding = EdgeInsets.all(25.0);

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPassController = TextEditingController();
  final _registerPassController2 = TextEditingController();

  var _loading = false;

  File _image1, _image2;

  void validateAndSave() {
    final form = _formKey.currentState;
    setState(() {
      _loading = true;
    });

    if (form.validate() && _image1 != null && _image2 != null) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _registerEmailController.text,
        password: _registerPassController2.text,
      )
          .then((signedInUser) {
        List<File> images = [_image1, _image2];
        UserManagement().storeNewUser(
            signedInUser, _registerNameController.text, images, context);
      }).catchError((error) {
        final snackBar = SnackBar(
          content: Text(
            error.getErrorCode().toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'bebas-neue'),
          ),
          duration: Duration(milliseconds: 2500),
          backgroundColor: Colors.redAccent,
        );
        setState(() {
          _loading = false;
        });

        Scaffold.of(context).showSnackBar(snackBar);
      });
    } else if (_image1 == null || _image2 == null) {
      final snackBar = SnackBar(
        content: Text(
          "We request all our users to upload 2 images",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'bebas-neue'),
        ),
        duration: Duration(milliseconds: 2500),
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        _loading = false;
      });

      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        _loading = false;
      });

      print("Form is not valid");
    }
  }

  Future getFirstImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery); // Change this to camera later
    setState(() {
      _image1 = image;
    });
  }

  Future getSecondImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery); // Change this to camera later
    setState(() {
      _image2 = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Container(
          padding: padding,
          child: _loading
              ? Center(
                  child: Loader(),
                )
              : ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 10, color: Colors.tealAccent),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0))),
                            margin: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: getFirstImage,
                              child: _image1 == null
                                  ? Image.asset(
                                      'assets/images/place_holder_image.png')
                                  : Image.file(_image1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 10, color: Colors.tealAccent),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0))),
                            margin: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                                onTap: getSecondImage,
                                child: _image2 == null
                                    ? Image.asset(
                                        'assets/images/place_holder_image.png')
                                    : Image.file(_image2)),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _registerNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          RegExp exp = new RegExp(
                              "(^[A-Z][a-z,.'-]+ [A-Z][a-z,.'-]+)|(^[A-Z][a-z,.'-]+)|(^[a-z]+)\$");
                          return value.contains(exp)
                              ? null
                              : "Name is not valid";
                        }
                      },
                      autofocus: true,
                      autocorrect: false,
                      maxLines: 1,
                      maxLengthEnforced: true,
                      maxLength: 70,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      controller: _registerEmailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an Email';
                        } else {
                          RegExp exp = new RegExp(
                              "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$");
                          return value.contains(exp)
                              ? null
                              : "Email is not valid";
                        }
                      },
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _registerPassController,
                      validator: (value) => value.length < 6
                          ? 'Please enter a password with at least 6 characters'
                          : null,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _registerPassController2,
                      validator: (value) =>
                          (value != _registerPassController.text)
                              ? 'Password does not match'
                              : null,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      child: Text('Sign Up'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 7.0,
                      onPressed: validateAndSave,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
