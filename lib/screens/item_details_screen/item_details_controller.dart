import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'item_details_model.dart';

class ItemDetailController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ItemDetailModel model;
  bool isLoading = true;
  bool isAlreadyAvailable = false;
  int discount = 0;
  Future<void> getItemDetails(String id) async {
    try {
      await _firestore.collection('products').doc(id).get().then((value) {
        model = ItemDetailModel.fromJson(value.data()!);
        discount = calculateDiscount(model.totalPrice, model.sellingPrice);
        isLoading = false;
        update();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> checkIfAlreadyInCart() async {
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .where('id', isEqualTo: model.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isAlreadyAvailable = true;
        }
        isLoading = false;
        update();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addItemsToCart() async {
    isLoading = true;
    update();
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(model.id)
          .set({'id': model.id}).then((value) {
        checkIfAlreadyInCart();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;
    return discount.toInt();
  }
}
