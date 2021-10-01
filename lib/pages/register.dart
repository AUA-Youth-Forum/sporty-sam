import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sporty_sam/components/loading.dart';
import 'package:sporty_sam/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = new GlobalKey<FormState>();

  late String _email;
  late String _password;
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    if (isAuthenticated()) {
      print("Authenticated");
      Navigator.popAndPushNamed(context, "/home");
    } else {
      print("Not Authenticated");
    }
    super.initState();
  }

  bool validateForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    if (validateForm()) {
      late String userId;
      print("Credentials: " + _email + " " + _password);
      register(_email, _password).then((value) {
        userId = value;
        print("User Id: " + userId);
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.check_circle, color: Colors.white),
                  ),
                  TextSpan(text: '\tRegistration successful'),
                ],
              ),
            ),
            duration: const Duration(milliseconds: 5000),
            width: 280.0, // Width of the SnackBar.
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
        signOut().then((value) => Navigator.pop(context));
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.cancel, color: Colors.white),
                  ),
                  TextSpan(
                      text: error == 0
                          ? '\tWeak password'
                          : (error == 1
                              ? '\tEmail already exists'
                              : '\tRegistration error')),
                ],
              ),
            ),
            duration: const Duration(milliseconds: 5000),
            width: 280.0, // Width of the SnackBar.
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
        print(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Sporty Sam\n',
                        style: TextStyle(
                          fontFamily: 'PortLligatSans',
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo,
                        ),
                        children: [
                          TextSpan(
                            text: 'Keep Moving and Save Sam',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          )
                        ]),
                  ),
                  Hero(
                    tag: 'hero',
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 48.0,
                        child: Image(
                          image: AssetImage('lib/assets/login-img.png'),
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: 'Email', prefixIcon: Icon(Icons.mail)),
                      validator: (value) => value != null
                          ? value.isEmpty
                              ? 'Email can\'t be empty'
                              : null
                          : null,
                      onSaved: (value) =>
                          _email = value != null ? value.trim() : "",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: TextFormField(
                      maxLines: 1,
                      obscureText: _obscureText,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: new GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: new Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) => value != null
                          ? value.isEmpty
                              ? 'Password can\'t be empty'
                              : null
                          : null,
                      onSaved: (value) =>
                          _password = value != null ? value.trim() : "",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                    child: SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          primary: Color(0xffdf8e33),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        child: Text('Sign Up',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        onPressed: (signUp),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: TextButton(
                        onPressed: (() => Navigator.of(context).pop()),
                        child: Text("Already have an account? Sign In",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400)),
                      )),
                ],
              ),
            ),
          ),
          _isLoading
              ? Loading()
              : Container(
                  height: 0.0,
                )
        ]));
  }
}
