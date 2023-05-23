import 'package:flutter/material.dart';
import '/../bloc/US_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../block_repo/Block_Repo.dart';
import '../BLOC/bloc_event.dart';
import '../BLOC/bloc_state.dart';

class BlocBloc extends Bloc<US_Event, BlocState> {
  final BlockRepo _USRepo;

  BlocBloc(this._USRepo) : super(BlocLoad()) {
    on<US_LoadEvent>((event, emit) async {
      emit(BlocLoad());
      try {
        final List<US_model> data = await _USRepo.getBlock();
        emit(BlocSuccess(data));
      } catch (e) {
        print(e);
        emit(BlocError(e.toString()));
      }
    });
  }
}
