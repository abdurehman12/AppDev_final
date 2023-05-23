import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/CRUD_Data/ProductsModel.dart';

@immutable
class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductLoad extends ProductState {
  const ProductLoad();

  @override
  List<Object?> get props => [];
}

class ProductSuccess extends ProductState {
  final List<ProductModels> data;
  const ProductSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
