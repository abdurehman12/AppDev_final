import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../UserModel.dart';
import "../../UserModel.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repo/bloc_repo.dart';
import '../bloc/events.dart';
import '../bloc/states.dart';

class UserBloc extends Bloc<user_Event, StateBlock> {
  final User_Repo _userRepo;

  UserBloc(this._userRepo) : super(BlocLoad()) {
    on<user_Event>((event, emit) async {
      emit(BlocLoad());
      try {
        if (event is userAdd_Event) {
          await _userRepo.AddUser(
              event.user, event.Lname, event.Fname, event.email, event.uid);
          userModel data = userModel();
          emit(BlocSuccess(data));
        }

        if (event is userDelete_Event) {
          await _userRepo.Delete_User(event.uid);
          userModel data = userModel();
          emit(BlocSuccess(data));
        }

        if (event is readUser_Event) {
          final userModel data = await _userRepo.Read_User(event.uid);
          emit(BlocSuccess(data));
        }

        if (event is userUpdate_Event) {
          await _userRepo.UpdateUser(
              event.email, event.Fname, event.Lname, event.uid);
          // userModel data = userModel();
          emit(BlocLoad());
        }
      } catch (e) {
        print(e);
        emit(BlocError(e.toString()));
      }
    });
  }

  Stream<userModel> _getUser({required String uid}) {
    return _userRepo.Read_User(uid).asStream();
  }
}
