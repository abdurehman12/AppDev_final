import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../US_model.dart';

abstract class BlocState extends Equatable {
  const BlocState();
}

class BlocLoad extends BlocState {
  const BlocLoad();

  @override
  List<Object> get props => [];
}

class BlocSuccess extends BlocState {
  final List<US_model> data;
  const BlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BlocError extends BlocState {
  final String message;
  const BlocError(this.message);

  @override
  List<Object> get props => [message];
}
