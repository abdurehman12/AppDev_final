import 'package:final_exam/Screens/login.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/SignUp/DeleteUser.dart';
// import 'package:flutter_application_1/SignUp/UpdateUser.dart';
import './bloc/block_repo/Block_Repo.dart';
import "package:firebase_core/firebase_core.dart";
import './bloc/UI.dart';
// import './Login/login.dart';
import "./SignUp/SignUp.dart";
import 'CRUD_Data/AddUI.dart';
import 'CRUD_Data/CRUD_UI.dart';
import 'CRUD_Data/adding.dart';
import 'SignUp/DeleteUser.dart';
import 'SignUp/UpdateUser.dart';
import 'bbloc/UI_Bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => LoginPage(),
        "/SignUp": (context) => SignUp(),
        "/home": (context) => crudUI(),
        "/Delete_User": (context) => DeleteUser(),
        "/Update_user": (context) => UpdateUI(),
        "/databloc": (context) => AddUI(),
      },
      title: 'Flutter Demo',
      // theme: ThemeData.light(), // Provide light theme.
      // darkTheme: ThemeData.dark(), // Provide dark theme.
      // themeMode: ThemeMode.system,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: MyUI(),
      initialRoute: "/home",
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   BlockRepo blockRepo = BlockRepo();

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     blockRepo.getBlock();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
