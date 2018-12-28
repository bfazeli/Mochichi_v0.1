import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'strings.dart';
import 'profilecard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Widget _buildAppBar() {
  return AppBar(
    backgroundColor: Colors.teal,
    elevation: 0,
    title: Text(
      Strings.appTitle,
      style: TextStyle(
        fontFamily: 'bebas-neue',
        fontSize: 25,
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {},
    ),
  );
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('../assets/images/porter.jpg'),
      //     fit: BoxFit.cover
      //   )
      // ),
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Center(
          child: ProfileCard(),
          //Container(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text("You are now logged in"),
          //       SizedBox(
          //         height: 15.0,
          //       ),
          //       OutlineButton(
          //         borderSide: BorderSide(
          //           color: Colors.red, style: BorderStyle.solid, width: 3.0
          //         ),
          //         child: Text("Logout"),
          //         onPressed: () {
          //           FirebaseAuth.instance.signOut()
          //           .then((value) {
          //             Navigator.of(context).pushReplacementNamed('/landingpage');
          //           })
          //           .catchError((error) {
          //             print(error);
          //           });
          //         },
          //       )
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
