import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
// import '../US_model.dart';
import '../Products_model.dart';

abstract class BlocState2 extends Equatable {
  const BlocState2();
}

class BlocLoad2 extends BlocState2 {
  const BlocLoad2();

  @override
  List<Object> get props => [];
}

class BlocSuccess2 extends BlocState2 {
  final List<Products> data;
  const BlocSuccess2(this.data);

  @override
  List<Object?> get props => [data];
}

class BlocError2 extends BlocState2 {
  final String message;
  const BlocError2(this.message);

  @override
  List<Object> get props => [message];
}
