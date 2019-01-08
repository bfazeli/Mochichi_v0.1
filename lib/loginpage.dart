import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './services/loader.dart';
import './services/user_crud.dart';
import 'strings.dart';

const padding = EdgeInsets.all(25.0);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  RegExp exp = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$");

  String _email;
  String _password;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  final key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _emailController.text = _email;
    _passwordController.text = _password;
    super.initState();
  }

  void loginUser() {
    print(_email);
    print(_password);
    setState(() {
      _loading = true;
    });
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((FirebaseUser user) {
          UserManagement().fetchCurrentUser().then((res) {
            print("Fetching current user: ${res.name}");
          });

          UserManagement().fetchAllUsers(user.uid);
          
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((error) {
      var message = "";
      print(error.code.toString());
      message = (error.code.toString() == "Error 17020")
          ? "Please check network and try again"
          : "User not found";

      setState(() {
        _loading = false;
        showSnackBarWith(message);
      });
      print(error);
    });
  }

  void showSnackBarWith(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'bebas-neue'),
      ),
      duration: Duration(milliseconds: 2500),
      backgroundColor: Colors.redAccent,
    );
    key.currentState.showSnackBar(snackBar);
    // _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      // appBar: AppBar(
      //   title: Text(Strings.login),
      // ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 75, top: 30),
                  child: Image.asset('assets/images/banner.jpg'),
                ),
                _loading
                    ? Center(child: Loader())
                    : Expanded(
                        child: ListView(
                          children: <Widget>[
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              child: Text('Login'),
                              color: Colors.blue,
                              textColor: Colors.white,
                              elevation: 7.0,
                              onPressed:
                                  ((_email != null && _email.contains(exp)) &&
                                          (_password != null &&
                                              _password.length >= 6))
                                      ? loginUser
                                      : null,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Don't have an account?",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RaisedButton(
                              child: Text('Sign Up'),
                              color: Colors.blue,
                              textColor: Colors.white,
                              elevation: 7.0,
                              onPressed: () {
                                Navigator.of(context).pushNamed('/signup');
                              },
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
