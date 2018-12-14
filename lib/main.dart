import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';

void main() => runApp(new Mochichi());

class Mochichi extends StatefulWidget {
  @override
  _MochichiState createState() => _MochichiState();
}

class _MochichiState extends State<Mochichi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context) => Mochichi(),
        '/signup': (BuildContext context) => SignUpPage(),
        '/homepage': (BuildContext context) => HomePage(),
      },
    );
  }
}