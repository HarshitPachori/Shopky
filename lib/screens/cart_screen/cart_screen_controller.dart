import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../item_details_screen/item_details_model.dart';

class CartScreenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List productId = [];
  List<ItemDetailModel> productDetails = [];
  bool isLoading = true;
  int totalPrice = 0;
  int totalSellingPrice = 0;
  int totalDiscount = 0;

  Future<void> getCartItem() async {
    productDetails = [];
    productId = [];
    try {
      await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .get()
          .then((value) {
        productId = value.docs.map((e) => e.data()['id']).toList();
        getProductDetails();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getProductDetails() async {
    for (var item in productId) {
      try {
        await firebaseFirestore
            .collection("products")
            .doc(item)
            .get()
            .then((value) {
          productDetails.add(ItemDetailModel.fromJson(value.data()!));
        });
      } catch (e) {
        log(e.toString());
      }
    }
    calculatePrice();
    isLoading = false;
    update();
  }

  Future<void> removeFromCart(String id) async {
    isLoading = true;
    update();
    try {
      await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(id)
          .delete()
          .then((value) {
        getCartItem();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;
    return discount.toInt();
  }

  void calculatePrice() {
    for (var item in productDetails) {
      totalPrice = totalPrice + item.totalPrice;
      totalSellingPrice = totalSellingPrice + item.sellingPrice;
    }
    totalDiscount = totalPrice - totalSellingPrice;
  }

  @override
  void onInit() {
    super.onInit();
    getCartItem();
  }
}
