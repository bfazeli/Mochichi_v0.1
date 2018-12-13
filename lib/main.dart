import 'package:flutter/material.dart';

void main() => runApp(new Mochichi());

class Mochichi extends StatefulWidget {
  @override
  _MochichiState createState() => _MochichiState();
}

class _MochichiState extends State<Mochichi> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("Mochichi"),
        ),
      ),
    );
  }
}