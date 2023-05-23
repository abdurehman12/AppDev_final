import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class user_Event extends Equatable {
  const user_Event();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class userAdd_Event extends user_Event {
  final User? user;
  final String Lname;
  final String Fname;
  final String email;
  final String uid;

  const userAdd_Event(
      {required this.user,
      required this.Lname,
      required this.Fname,
      required this.email,
      required this.uid});

  @override
  List<Object?> get props => [];
}

class userDelete_Event extends user_Event {
  final String uid;

  const userDelete_Event({required this.uid});

  @override
  List<Object?> get props => [];
}

class readUser_Event extends user_Event {
  final String uid;

  const readUser_Event({required this.uid});

  @override
  List<Object?> get props => [];
}

class userUpdate_Event extends user_Event {
  final String Lname;
  final String Fname;
  final String email;
  final String uid;

  const userUpdate_Event(
      {required this.Lname,
      required this.Fname,
      required this.email,
      required this.uid});

  @override
  List<Object?> get props => [];
}
