import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './services/usermanagement.dart';

const padding = EdgeInsets.all(25.0);

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _registerPassController = TextEditingController();
  final _registerPassController2 = TextEditingController();

  String _email;
  String _password;
  String _confirmPass;
  String _error;

  void validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _email,
                    password: _password
                  )
                  .then((signedInUser) {
                    UserManagement().storeNewUser(signedInUser, context);
                  })
                  .catchError( (error) {
                    
                    print(error.getErrorCoder());
                  });
    }
    else {
      print("Form is not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter an Email';
                  } else {
                    RegExp exp = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$");
                    return value.contains(exp) ? null : "Email is not valid";
                  }
                },
                decoration: InputDecoration(labelText: 'Email'),
                onFieldSubmitted: ((value) {
                  _email = value;
                }),
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _registerPassController,
                validator: (value) => value.length < 6 ? 'Please enter a password with at least 6 characters' : null,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _registerPassController2,
                validator: (value) => (value != _registerPassController.text) ? 'Password does not match' : null,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                onFieldSubmitted: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              // Text(
              //   _error,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(color: Colors.red),
              // ),
              SizedBox(height: 20.0,),
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