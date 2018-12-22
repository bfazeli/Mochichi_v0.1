import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'strings.dart';
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
      title: Strings.appTitle,
      theme: ThemeData.light(),
      home: LoginPage(),
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context) => Mochichi(),
        '/signup': (BuildContext context) => SignUpPage(),
        '/homepage': (BuildContext context) => HomePage(),
      },
    );
  }
}