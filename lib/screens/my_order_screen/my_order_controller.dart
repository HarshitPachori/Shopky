import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'my_orders_model.dart';

class MyOrderController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MyOrdersModel> model = [];
  bool isLoading = true;

  Future<void> getMyOrders() async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('myorders')
          .get()
          .then((value) {
        model =
            value.docs.map((e) => MyOrdersModel.fromJson(e.data())).toList();

        isLoading = false;
        update();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onInit() {
    //
    super.onInit();
    getMyOrders();
  }
}
