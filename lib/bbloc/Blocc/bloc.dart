import 'package:final_exam/bbloc/Products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:finals/data_bloc/repo/user_repo.dart';
// import 'package:finals/data_bloc/ui_bloc/state.dart';
// import 'package:finals/data_bloc/ui_bloc/event.dart';

import '../../bloc/BLOC/bloc_state.dart';
import '../Blocc_repo/Blocc_repo.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class UserBloc2 extends Bloc<UserEvent, BlocState2> {
  final BlockRepo2 _userRepository;
  UserBloc2(this._userRepository) : super(BlocLoad2()) {
    on<LoadUserEvent>((event, emit) async {
      emit(BlocLoad2());
      //just to show loader on UI for Presentation
      // await Future.delayed(Duration(seconds: 3));
      try {
        final List<Products> users = await _userRepository.getBlock();
        emit(BlocSuccess2(users));
      } catch (e) {
        emit(BlocError2(e.toString()));
      }
    });
  }
}
