import 'package:final_exam/bbloc/Blocc/bloc_state.dart';
import 'package:final_exam/bbloc/Products_model.dart';
import 'package:final_exam/bloc/block_repo/Block_Repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:finals/data_bloc/repo/user_repo.dart';
// import 'package:finals/data_bloc/ui_bloc/bloc.dart';
// import 'package:finals/data_bloc/ui_bloc/state.dart';
// import 'package:finals/data_bloc/ui_bloc/event.dart';
// import 'package:finals/data_bloc/model/user_data_model.dart';

// import '../bloc/BLOC/bloc_state.dart';
// import '../bloc/block_repo/Block_Repo.dart';
import 'Blocc/bloc.dart';
import 'Blocc/bloc_event.dart';
import 'Blocc_repo/Blocc_repo.dart';
import 'Products_model.dart';

class data_bloc_ui extends StatelessWidget {
  const data_bloc_ui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc2(BlockRepo2())..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
            title: const Text('The BloC App'),
            automaticallyImplyLeading: false),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc2(BlockRepo2())..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc2, BlocState2>(
        builder: (context, state) {
          // Build the UI based on the current state.
          if (state is BlocLoad2) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BlocError2) {
            return const Center(child: Text("Error"));
          }

          if (state is BlocSuccess2) {
            List<Products> userList = state.data;
            //print(state);
            print(userList);
            print("Abbasi");

            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(
                        '${userList[index].title}  (${userList[index].brand})',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${userList[index].description}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
