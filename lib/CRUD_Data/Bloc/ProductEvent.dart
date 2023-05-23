import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

@immutable
class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductAddEvent extends ProductEvent {
  final String name;
  // final String description;
  // final String price;
  // final String image;
  // final String id;
  // final String Category;
  // final String Color;
  final String Email;
  final String phone;

  const ProductAddEvent(
      {required this.name,
      // required this.description,
      required this.Email,
      required this.phone});

  @override
  List<Object?> get props => [];
}

class ProductDeleteEvent extends ProductEvent {
  final String id;

  const ProductDeleteEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class readProductEvent extends ProductEvent {
  final String id;

  const readProductEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class readAllProductEvent extends ProductEvent {
  const readAllProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductUpdateEvent extends ProductEvent {
  final String name;
  // final String description;
  // final String price;
  // final String image;
  // final String id;
  // final String Category;
  // final String Color;
  final String Email;
  final String phone;

  const ProductUpdateEvent(
      {required this.name,
      // required this.description,
      required this.Email,
      required this.phone});

  @override
  List<Object?> get props => [];
}
