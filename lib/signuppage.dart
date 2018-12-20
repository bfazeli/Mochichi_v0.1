import 'package:flutter/material.dart';
import './signupform.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpForm(),
    );
  }
}