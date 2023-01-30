import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopky/views/login_view.dart';
import 'dart:developer';

import '../home_screen/home_screen.dart';

class AuthController extends GetxController {
  //AuthController.insatnce...
  static AuthController instance = Get.find();
  // email,password,name...
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(
        auth.currentUser); //typecasting to make firebase user  as Rx user
    _user.bindStream(auth
        .userChanges()); // to notify the _user about any changes like login log out
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      log("login page");
      Get.offAll(() => const LoginView());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<void> register(String name, email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => createUserCredential(name, email));
    } catch (e) {
      Get.snackbar("About user", "User massage",
          backgroundColor: Colors.teal.shade600,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText:
              Text(e.toString(), style: const TextStyle(color: Colors.white)));
    }
  }

  Future<void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About login", "Login massage",
          backgroundColor: Colors.teal.shade600,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText:
              Text(e.toString(), style: const TextStyle(color: Colors.white)));
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> createUserCredential(String name, String email) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set({
        "uid": auth.currentUser!.uid,
        "name": name,
        "email": email,
        "role": "user"
      }).then((value) {
        Get.to(() => const LoginView());
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
