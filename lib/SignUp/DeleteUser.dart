import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/SignUp/Bloc/Repo/bloc_repo.dart';
import 'Bloc/bloc/bloc.dart';
import 'Bloc/bloc/events.dart';

class DeleteUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(User_Repo()),
      ),
    ], child: Delete_Button(context));
  }
}

Widget Delete_Button(BuildContext context) {
  return BlocProvider(
    create: (context) => UserBloc(
      User_Repo(),
    ),
    child: Scaffold(
        appBar: AppBar(
          title: Text("Delete"),
        ),
        body: Builder(builder: (innercontext) {
          return Container(
            child: Center(
              child: Column(
                children: [
                  Text("Are you sure you want to delete your account?"),
                  ElevatedButton(
                    onPressed: () {
                      User? user = FirebaseAuth.instance.currentUser!;
                      BlocProvider.of<UserBloc>(innercontext)
                          .add(userDelete_Event(uid: user.uid));
                      user.delete();
                      Navigator.popUntil(context, ModalRoute.withName("/"));
                    },
                    child: Text("DELETE_ACCOUNT"),
                  ),
                ],
              ),
            ),
          );
        })),
  );
}
