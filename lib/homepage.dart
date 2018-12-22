import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'strings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(Strings.appTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You are now logged in"),
              SizedBox(
                height: 15.0,
              ),
              OutlineButton(
                borderSide: BorderSide(
                  color: Colors.red, style: BorderStyle.solid, width: 3.0
                ),
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut()
                  .then((value) {
                    Navigator.of(context).pushReplacementNamed('/landingpage');
                  })
                  .catchError((error) {
                    print(error);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}