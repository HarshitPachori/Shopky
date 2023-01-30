import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'item_screen_data_model.dart';

class ItemScreenController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();
  String categoryId = "";
  String categoryTitle = "";
  List<ItemsDataModel> itemsData = [];
  List<ItemsDataModel> searchResults = [];
  bool isLoading = true;
  bool isSearchLoading = false;
  bool hasMoreData = true;
  var isLoading1 = false.obs;
  DocumentSnapshot? lastDocument;
  int documentLimit = 7;

  void getAllData() async {
    await Future.wait([getSubCategoryData()]).then((value) {
      log("data");
      log(itemsData[0].image);

      isLoading = false;
      update();
    });
  }

  Future<void> getSubCategoryData() async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryTitle)
          .get()
          .then((value) {
        itemsData =
            value.docs.map((e) => ItemsDataModel.fromJson(e.data())).toList();
        isLoading = false;

        update();
        log(itemsData.toString());
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;
    return discount.toInt();
  }

  Future<void> searchProducts(String query) async {
    if (query.isNotEmpty) {
      isSearchLoading = true;
      Future.delayed(Duration.zero, () {
        update();
      });
    }
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryTitle)
          .where(
            'title',
            isGreaterThanOrEqualTo: query,
          )
          .get()
          .then((value) {
        searchResults =
            value.docs.map((e) => ItemsDataModel.fromJson(e.data())).toList();
        isSearchLoading = false;
        update();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void getPaginedData() async {
    if (hasMoreData) {
      if (!isLoading1.value) {
        await getSubCategoryDataInParts();
      }
    } else {
      log("No more data");
    }
  }

  Future<void> getSubCategoryDataInParts() async {
    if (lastDocument == null) {
      await _firebaseFirestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData
            .addAll(value.docs.map((e) => ItemsDataModel.fromJson(e.data())));
        isLoading = false;
        update();
        lastDocument = value.docs.last;
        if (value.docs.length < documentLimit) {
          hasMoreData = false;
        }
      });
    } else {
      isLoading1.value = true;
      await _firebaseFirestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData
            .addAll(value.docs.map((e) => ItemsDataModel.fromJson(e.data())));
        isLoading1.value = false;
        update();
        lastDocument = value.docs.last;
        if (value.docs.length < documentLimit) {
          hasMoreData = false;
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      double currentPosition = scrollController.position.pixels;
      double height20 = Get.size.height * 0.20;
      if (maxScrollExtent - currentPosition <= height20) {
        getPaginedData();
      }
    });
  }
}
