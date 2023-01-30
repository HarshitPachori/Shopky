import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:shopky/utils/constants.dart';

import '../address_screen/address_screen_controller.dart';
import '../cart_screen/cart_screen_controller.dart';
import '../home_screen/home_screen.dart';

class ConfirmationScreenController extends GetxController {
  final addressScreenController = Get.find<AddressScreenController>();
  final cartScreenController = Get.find<CartScreenController>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = "", address = "", pincode = "";
  int totalPrice = 0, payablePrice = 0, totalDiscount = 0;
  final Razorpay _razorpay = Razorpay();
  void initializeData() {
    name = addressScreenController.name;
    address = addressScreenController.address;
    pincode = addressScreenController.pincode;
    totalPrice = cartScreenController.totalPrice;
    payablePrice = cartScreenController.totalSellingPrice;
    totalDiscount = cartScreenController.totalDiscount;
  }

  void onPay() {
    var options = {
      'key': 'rzp_test_QQlZst6VcUSk23'
          '',
      'amount': cartScreenController.totalSellingPrice * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    _razorpay.open(options);
  }

  @override
  void onInit() {
    super.onInit();
    initializeData();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> placeOrder(String orderId) async {
    try {
      Map<String, dynamic> details = {
        'orderId': orderId,
        'productIds': cartScreenController.productId,
        'name': name,
        'address': address,
        'pincode': pincode,
        'mobile': _auth.currentUser!.phoneNumber,
        'status': 0,
        'time': FieldValue.serverTimestamp(),
      };

      await _firebaseFirestore.collection('orders').add(details);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addToMyOrders(String orderId) async {
    try {
      for (var i = 0; i < cartScreenController.productDetails.length; i++) {
        Map<String, dynamic> orderDetails = {
          'img': cartScreenController.productDetails[i].image,
          'name': cartScreenController.productDetails[i].title,
          'orderId': orderId,
          'total_price': cartScreenController.productDetails[i].totalPrice,
          'paid_amount': cartScreenController.productDetails[i].sellingPrice,
          'status': 0,
          'order_on': FieldValue.serverTimestamp(),
          'delivered_on': FieldValue.serverTimestamp(),
        };
        await _firebaseFirestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('myorders')
            .add(orderDetails);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    await Future.wait([
      placeOrder(response.orderId ?? ""),
      addToMyOrders(response.orderId ?? ""),
    ]).then((value) {
      showAlert("Payment Successful");
      Get.to(() => const HomeScreen());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showAlert("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    showAlert("Payment Failed");
  }
}
