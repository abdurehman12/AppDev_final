import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import '../ProductsModel.dart';

// String? Name;
// String? Price;
// String? Description;
// String? Image;
// String? Category;
// String? id;

class ProductRepo {
  AddProduct(String Name, String Email, String phone) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('ProductsV2');
    collectionReference.add({
      'Name': Name,
      // 'Price': Price,
      // 'Description': Description,
      // 'Image': Image,
      // 'Category': Category,
      // 'Color': Color,
      'Email': Email,
      'phone': phone,
    });
  }

  DeleteProduct(String id) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Products');
    collectionReference.doc(id).delete().then((value) => {print("Deleted")});
  }

  Future<ProductModels> ReadProduct(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('ProductsV2');
    DocumentReference documentReference = collectionReference.doc(id);
    ProductModels product = ProductModels();
    try {
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.exists) {
        product.fromJson(documentSnapshot.data() as Map<String, dynamic>);
        print("Data Read successfully");
      } else {
        print("No such user");
      }
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return product;
  }

  Future<List<ProductModels>> ReadAllProduct() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('ProductsV2');
    List<ProductModels> products = [];
    try {
      QuerySnapshot querySnapshot = await collectionReference.get();
      querySnapshot.docs.forEach((element) {
        ProductModels product = ProductModels();
        product.fromJson(element.data() as Map<String, dynamic>);
        product.Email = element.id;
        products.add(product);
      });
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return products;
  }

  UpdateProduct(String Name, String Email, String phone) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Products');
    collectionReference.doc(Email).update({
      'Name': Name,
      // 'Price': Price,
      // 'Description': Description,
      // 'Image': Image,
      // 'Category': Category,
      // 'Color': Color,
      'Email': Email,
      'phone': phone,
    });
  }
}
