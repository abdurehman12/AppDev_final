import 'dart:ffi';

import 'package:flutter/material.dart';
import '/CRUD_Data/Bloc/ProductEvent.dart';
import '/CRUD_Data/Bloc/ProductState.dart';
import '/CRUD_Data/Repo/ProductRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/ProductBloc.dart';

// ignore: camel_case_types
class crudUI extends StatefulWidget {
  const crudUI({super.key});

  @override
  _CRUD_UIState createState() => _CRUD_UIState();
}

// ignore: camel_case_types
class _CRUD_UIState extends State<crudUI> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductBloc(ProductRepo()),
        child: MyBody(context));
  }

  Widget MyBody(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(ProductRepo())..add(readAllProductEvent()),
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(readAllProductEvent());
                      },
                      icon: Icon(Icons.home)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/databloc");
                      },
                      icon: Icon(Icons.person)),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text("CRUD"),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.add,
                      size: 26.0,
                    ),
                  )),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoad) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              if (state is ProductSuccess) {
                // return Text(state.data[0].Name as String);
                return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600'),
                        ),
                        title: Text(state.data[index].Name != null
                            ? state.data[index].Name as String
                            : "qwe"),
                        subtitle: Text(state.data[index].Email != null
                            ? state.data[index].phone as String
                            : "0"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  // print(state.data[index].id as String);
                                  BlocProvider.of<ProductBloc>(context).add(
                                      ProductDeleteEvent(
                                          id: state.data[index].Email
                                              as String));
                                  BlocProvider.of<ProductBloc>(context)
                                      .add(readAllProductEvent());
                                },
                                icon: Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        TextEditingController _Cname =
                                            TextEditingController();
                                        TextEditingController _Cprice =
                                            TextEditingController();
                                        TextEditingController _Cdescription =
                                            TextEditingController();
                                        TextEditingController _Cimage =
                                            TextEditingController();
                                        TextEditingController _Ccategory =
                                            TextEditingController();
                                        TextEditingController _Color =
                                            TextEditingController();

                                        _Cname.text =
                                            state.data[index].Name as String;
                                        _Cprice.text =
                                            state.data[index].Email as String;
                                        _Cdescription.text =
                                            state.data[index].phone as String;
                                        // _Cimage.text =
                                        //     state.data[index].Image as String;
                                        // _Ccategory.text = state
                                        //     .data[index].Category as String;
                                        // _Color.text =
                                        //     state.data[index].Color as String;
                                        return AlertDialog(
                                          title: Text("Update"),
                                          content: SingleChildScrollView(
                                            child: Form(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: _Cname,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: "Name"),
                                                  ),
                                                  TextFormField(
                                                    controller: _Cprice,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: "Email"),
                                                  ),
                                                  TextFormField(
                                                    controller: _Cdescription,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                "Phone number"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(dialogContext);
                                                },
                                                child: Text("Cancel")),
                                            TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<ProductBloc>(
                                                          context)
                                                      .add(ProductUpdateEvent(
                                                    name: _Cname.text,
                                                    Email: _Cprice.text,
                                                    phone: _Cdescription.text,
                                                  ));

                                                  BlocProvider.of<ProductBloc>(
                                                          context)
                                                      .add(
                                                          readAllProductEvent());
                                                  Navigator.pop(dialogContext);
                                                },
                                                child: Text("Update")),
                                          ],
                                        );
                                      });
                                  // BlocProvider.of<ProductBloc>(context).add(
                                  //     ProductUpdateEvent(
                                  //         id: state.data[index].id as String));
                                },
                                icon: Icon(Icons.update)),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: Text("somtheing went wrong"));
              }
            },
          ),
          //add bottom appbar

          floatingActionButton: BlocProvider(
              create: (create) => ProductBloc(ProductRepo()),
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                return FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          TextEditingController _Cname =
                              TextEditingController();
                          TextEditingController _Cprice =
                              TextEditingController();
                          TextEditingController _Cdescription =
                              TextEditingController();
                          TextEditingController _Cimage =
                              TextEditingController();
                          TextEditingController _Ccategory =
                              TextEditingController();
                          TextEditingController _Color =
                              TextEditingController();
                          return AlertDialog(
                            title: Text("Add"),
                            content: SingleChildScrollView(
                              child: Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _Cname,
                                      decoration: const InputDecoration(
                                          labelText: "Name"),
                                    ),
                                    TextFormField(
                                      controller: _Cprice,
                                      decoration: const InputDecoration(
                                          labelText: "Email"),
                                    ),
                                    TextFormField(
                                      controller: _Cdescription,
                                      decoration: const InputDecoration(
                                          labelText: "phone number"),
                                    ),
                                    // TextFormField(
                                    //   controller: _Cimage,
                                    //   decoration: const InputDecoration(
                                    //       labelText: "Image"),
                                    // ),
                                    // TextFormField(
                                    //   controller: _Ccategory,
                                    //   decoration: const InputDecoration(
                                    //       labelText: "Category"),
                                    // ),
                                    // TextFormField(
                                    //   controller: _Color,
                                    //   decoration: const InputDecoration(
                                    //       labelText: "Color"),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    BlocProvider.of<ProductBloc>(context)
                                        .add(ProductAddEvent(
                                      name: _Cname.text,
                                      Email: _Cprice.text,
                                      phone: _Cdescription.text,
                                    ));

                                    Navigator.pop(dialogContext);
                                    Navigator.popAndPushNamed(context, "/home");
                                  },
                                  child: Text("Add")),
                            ],
                          );
                        });
                  },
                  child: Icon(Icons.add),
                );
              }))),
    );
  }
}

toColors(String color) {
  var hexString = color;
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
