import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/Repo/bloc_repo.dart';
import 'Bloc/bloc/bloc.dart';
import 'Bloc/bloc/events.dart';
import 'UserModel.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String dropdownValue = 'Male';
  late String Error_text_Fname;
  late String Error_text_Lname;
  late String Error_text_Email;
  late String Error_text_Password;

  bool showError_Fname = false;
  bool showError_Lname = false;
  bool showError_Email = false;
  bool showError_Password = false;

  final TextEditingController _controller_Fname = TextEditingController();
  final TextEditingController _controller_Lname = TextEditingController();
  final TextEditingController _controller_Email = TextEditingController();
  final TextEditingController _controller_Password = TextEditingController();

  bool _loading = false;

  static final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  static final RegExp _passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<User?> SignUpUsingEmailAndPass({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await Firebase.initializeApp();
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.updateDisplayName("$_controller_Fname");
      ;
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  HandleSignUp(BuildContext context) async {
    // shoud be true to give error
    // showError_Email = true;
    HandleValidate_Fname();
    HandleValidate_Lname();
    HandleValidate_Email();
    HandleValidate_Password();

    if (_formkey.currentState!.validate()) {
      print('Validated');
      User? user = await SignUpUsingEmailAndPass(
        email: _controller_Email.text,
        password: _controller_Password.text,
        context: context,
      ).catchError((e) {
        print(e);
        return null;
      });

      if (user != null) {
        // _loading = false;
        print('User Created');

        BlocProvider.of<UserBloc>(context).add(
          userAdd_Event(
              Fname: _controller_Fname.text,
              Lname: _controller_Lname.text,
              email: _controller_Email.text,
              user: user,
              uid: user.uid),
        );

        // AddUser(user, _controller_Email.text, _controller_Fname.text,
        //     _controller_Lname.text);

        Navigator.popUntil(context, ModalRoute.withName('/'));
      } else {
        setState(() {
          //_loading = true;
        });
      }
    } else {
      print('Not Validated');
    }
  }

  HandleValidate_Fname() {
    if (_controller_Fname.text.isEmpty) {
      showError_Fname = true;
      Error_text_Fname = 'Please Enter First Name';
    } else {
      showError_Fname = false;
    }
  }

  HandleValidate_Lname() {
    if (_controller_Lname.text.isEmpty) {
      showError_Lname = true;
      Error_text_Lname = 'Please Enter Last Name';
    } else {
      showError_Lname = false;
    }
  }

  HandleValidate_Email() {
    if (_controller_Email.text.isEmpty) {
      setState(() {
        showError_Email = true;
        Error_text_Email = 'Please Enter Email';
      });
    } else if (!_emailRegex.hasMatch(_controller_Email.text)) {
      showError_Email = true;
      Error_text_Email = 'Please Enter Valid Email';
    } else {
      showError_Email = false;
    }
  }

  HandleValidate_Password() {
    if (_controller_Password.text.isEmpty) {
      showError_Password = true;
      Error_text_Password = 'Please Enter Password';
    } else if (!_passwordRegex.hasMatch(_controller_Password.text)) {
      showError_Password = true;
      Error_text_Password =
          'Password must contain at least 8 characters, including uppercase,\nlowercase letters and numbers';
    } else {
      showError_Password = false;
    }
  }

  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(User_Repo()),
      ),
    ], child: myBody(context));
  }

  @override
  Widget myBody(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc(
              User_Repo(),
            ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
          ),
          body: Center(
            child: Builder(
              builder: (BuildContext context) {
                if (_loading)
                  return const CircularProgressIndicator();
                else
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RichText(
                                  text: const TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 237, 132, 20),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: TextFormField(
                                        controller: _controller_Fname,
                                        validator: (value) {
                                          if (showError_Fname) {
                                            return Error_text_Fname;
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 237, 132, 20),
                                          ),
                                          label: Text('First Name'),
                                          hintText: "First Name",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 237, 132, 20)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: TextFormField(
                                        controller: _controller_Lname,
                                        validator: (value) {
                                          if (showError_Lname) {
                                            return Error_text_Lname;
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 237, 132, 20),
                                          ),
                                          label: Text('Last Name'),
                                          hintText: " Name",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 237, 132, 20)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _controller_Email,
                                  validator: (value) {
                                    if (showError_Email) {
                                      return Error_text_Email;
                                      // return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 237, 132, 20),
                                    ),
                                    label: Text('Email'),
                                    hintText: "xyz@abc.com",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 237, 132, 20)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _controller_Password,
                                  obscureText: true,
                                  validator: (value) {
                                    if (showError_Password) {
                                      return Error_text_Password;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 237, 132, 20),
                                    ),
                                    hintText: '********',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 237, 132, 20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  items: <String>["Male", "Female", "Other"]
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 237, 132, 20),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    HandleSignUp(context);

                                    // Navigator.pushNamed(context, '/');
                                  },
                                  child: const Text('Sign Up'),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 237, 132, 20),
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
              },
            ),
          ),
        ));
  }
}
