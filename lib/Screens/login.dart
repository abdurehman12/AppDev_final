import 'package:final_exam/SignUp/SignUp.dart';
import 'package:final_exam/bloc/UI.dart';
import 'package:flutter/material.dart';
// import 'package:test_app/components/My_button.dart';

import '../components/text_box.dart';
import '../components/square_tile.dart';
import '../components/My_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../components/constants.dart';

var spacing = const SizedBox(height: 50);

class LoginPage extends StatefulWidget {
  // Function isDark;
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: non_constant_identifier_names

  TextEditingController UsernameController = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController PasswordController = TextEditingController();

  //Sign in method == will use for navigation
  void SignUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //CustomColors().backgroundColor[0],//Colors.grey[375],

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffd89b), Color(0xff19547b)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),

            Row(children: [
              Positioned(
                top: 0,
                left: 0,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Sing in',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Column(children: [
                Center(
                    child: Text(
                  'A world of ',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
                Center(
                    child: Text(
                  'possibilities in an ',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
                Center(
                    child: Text(
                  'app',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
              ]),
            ]),

            const SizedBox(
              height: 25,
            ),
            // ignore: prefer_const_constructors
            MyTextField(
              controller: UsernameController,
              hint: "Username (abdurehman@abc.com)",
              obsecuretext: false,
              characterlength: 50,
              icon: Icon(Icons.email),
            ),
            //password
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: PasswordController,
              hint: "Password (Abdurehman12)",
              obsecuretext: true,
              characterlength: 20,
              icon: Icon(Icons.password),
            ),
            //text saying forget password
            const SizedBox(
              height: 10,
            ),
            Expanded(child: Container()),
            //sign in button
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    padding: EdgeInsets.all(16.0),
                    // ignore: deprecated_member_use
                    child: (MyButton(
                      text: "Sign In",
                      onTap: () {
                        //SignUserIn();
                        signInUser(context, UsernameController.text,
                            PasswordController.text);
                        // Future.delayed(const Duration(milliseconds: 100), () {
                        //   Navigator.pushNamed(context, "/home");
                        // });
                        //Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                    )))),
          ],
        ),
      ),
    );
  }
}

signInUser(context, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(userCredential);
    if (userCredential.user != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.pushNamed(context, "/home");
      });
    } else {
      print("User is null");
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
