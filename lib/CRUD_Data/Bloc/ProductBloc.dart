import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/CRUD_Data/Bloc/ProductEvent.dart';
import '/CRUD_Data/Bloc/ProductState.dart';
import '/CRUD_Data/ProductsModel.dart';
import '/CRUD_Data/Repo/ProductRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _PRepo;

  ProductBloc(this._PRepo) : super(ProductLoad()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductLoad());
      try {
        if (event is ProductAddEvent) {
          await _PRepo.AddProduct(event.name, event.Email, event.phone);
          List<ProductModels> data = [];
          emit(ProductSuccess(data));
        }

        if (event is ProductDeleteEvent) {
          await _PRepo.DeleteProduct(event.id);
          List<ProductModels> data = [];
          emit(ProductSuccess(data));
        }

        if (event is readProductEvent) {
          final ProductModels data = await _PRepo.ReadProduct(event.id);
          List<ProductModels> data1 = [data];
          emit(ProductSuccess(data1));
        }

        if (event is readAllProductEvent) {
          final List<ProductModels> data = await _PRepo.ReadAllProduct();
          emit(ProductSuccess(data));
        }

        if (event is ProductUpdateEvent) {
          await _PRepo.UpdateProduct(event.name, event.Email, event.phone);
          List<ProductModels> data = [];
          emit(ProductSuccess(data));
        }
      } catch (e) {
        print(e);
        emit(ProductError(e.toString()));
      }
    });
  }
}
