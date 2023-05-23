import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/SignUp/Bloc/bloc/bloc.dart';
import 'UserModel.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/Repo/bloc_repo.dart';
import 'Bloc/bloc/bloc.dart';
import 'Bloc/bloc/events.dart';
import 'Bloc/bloc/states.dart';

class UpdateUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(User_Repo()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Flutter Demo Home Page'),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/Delete_User");
                      },
                      child: Icon(
                        Icons.search,
                        size: 26.0,
                      ),
                    )),
              ]),
          body: myBody(context)),
    );
  }
}

Widget myBody(BuildContext context) {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _email = TextEditingController();

  HandleUpdate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser!;
      BlocProvider.of<UserBloc>(context).add(
        userUpdate_Event(
          Fname: _fname.text,
          Lname: _lname.text,
          email: _email.text,
          uid: user.uid,
        ),
      );
      Navigator.pop(context);
    }
  }

  return BlocProvider(
      create: (context) => UserBloc(
            User_Repo(),
          )..add(readUser_Event(uid: FirebaseAuth.instance.currentUser!.uid)),
      child: Scaffold(
        body: BlocBuilder<UserBloc, StateBlock>(
          builder: (context, state) {
            if (state is BlocLoad) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BlocSuccess) {
              setState() {
                _fname.text = state.data.Fname as String;
                _lname.text = state.data.Lname as String;
                _email.text = state.data.email as String;
              }

              setState();

              return Container(
                // child: Text(state.data.Fname as String),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Text(state.data.email as String),
                        TextFormField(
                          controller: _fname,
                          // initialValue: "string" as String?,
                          decoration: InputDecoration(
                            hintText:
                                state.data.Fname as String? ?? "First Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your first name";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _lname,
                          // initialValue: state.data.Lname as String,
                          decoration: InputDecoration(
                            hintText:
                                state.data.Lname as String? ?? "Last Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your last name";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _email,
                          // initialValue: state.data.email as String,
                          decoration: InputDecoration(
                            hintText: state.data.email as String? ?? "Email",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            HandleUpdate(context);
                          },
                          child: Text("Update"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text("Something went wrong");
            }
          },
        ),
      ));
}
