import 'package:flutter/material.dart';
import '/SignUp/Bloc/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SignUp/Bloc/Repo/bloc_repo.dart';
import 'BLOC/bloc.dart';
import 'BLOC/bloc_state.dart';
import 'block_repo/Block_Repo.dart';
import 'BLOC/bloc_event.dart';

class MyUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocBloc>(
          create: (BuildContext context) => BlocBloc(BlockRepo()),
        ),
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
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/Update_user");
                      },
                      child: Icon(
                        Icons.security,
                        size: 26.0,
                      ),
                    )),
              ]),
          body: myBody()),
    );
  }
}

Widget myBody() {
  return BlocProvider(
      create: (context) => BlocBloc(
            BlockRepo(),
          )..add(US_LoadEvent()),
      child: BlocBuilder<BlocBloc, BlocState>(
        builder: (context, state) {
          if (state is BlocLoad) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BlocSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.data[index].name as String),
                  subtitle: Text(state.data[index].type as String),
                );
              },
            );
          } else if (state is BlocError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ));
}
