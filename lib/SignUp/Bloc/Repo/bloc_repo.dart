import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../bloc/BLOC/bloc_state.dart';
import '../../UserModel.dart';

class User_Repo {
  AddUser(User? CurrentUser, Email, Fname, Lname, String uid) async {
    userModel user = userModel(
        email: Email, Fname: Fname, Lname: Lname, uid: CurrentUser!.uid);

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(CurrentUser.uid);
    userDocRef
        .set(user.toJson(), SetOptions(merge: true))
        .then((value) => print("Data set successfully"))
        .catchError((error) => print("Failed to set data: $error"));
  }

  Delete_User(String uid) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(uid);
    userDocRef
        .delete()
        .then((value) => print("Data Deleted successfully"))
        .catchError((error) => print("Failed to Delete data: $error"));
  }

  Future<userModel> Read_User(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(uid);
    userModel user = userModel();
    try {
      DocumentSnapshot userSnapshot = await userDocRef.get();
      if (userSnapshot.exists) {
        user.fromJson(userSnapshot.data() as Map<String, dynamic>);
        print("Data Read successfully");
      } else {
        print("No such user");
      }
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return user;
  }

  UpdateUser(Email, Fname, Lname, String uid) async {
    userModel user =
        userModel(email: Email, Fname: Fname, Lname: Lname, uid: uid);

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(uid);
    userDocRef
        .set(user.toJson(), SetOptions(merge: true))
        .then((value) => print("Data set successfully"))
        .catchError((error) => print("Failed to set data: $error"));
  }
}
