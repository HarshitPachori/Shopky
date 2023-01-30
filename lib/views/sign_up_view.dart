import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shopky/utils/textfield.dart';

import '../screens/authentication/auth_controller.dart';
import '../utils/constants.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formkey = GlobalKey<FormState>();
    final showPassword = true.obs;

    void passwordVisibilty() {
      showPassword.value = !showPassword.value;
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.teal.shade400,
                Colors.teal.shade300,
                Colors.teal.shade100,
                // Colors.deepOrangeAccent,
                // Colors.orange,
                // Colors.orangeAccent,
                Colors.white
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Shopky",
                    style: TextStyle(
                        fontSize: 65,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Made with Flutter",
                    style: TextStyle(
                        fontSize: 29,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableTextField(
                    controller: nameController,
                    hintText: "Enter your name ",
                    labelText: "Username",
                    textInputType: TextInputType.name,
                    iconData: Icons.person,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReusableTextField(
                    controller: emailController,
                    hintText: "Enter your email ",
                    labelText: "Email",
                    textInputType: TextInputType.emailAddress,
                    iconData: Icons.email,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReusableTextField(
                    controller: phoneController,
                    hintText: "Enter your number ",
                    labelText: "PhoneNumber",
                    textInputType: TextInputType.phone,
                    iconData: Icons.phone,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: Obx(
                      () => TextFormField(
                        validator: (value) {
                          return null;
                        },
                        onSaved: (newValue) {},
                        controller: passwordController,
                        obscureText: showPassword.value,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Enter your password",
                            labelText: "Password",
                            hintStyle: TextStyle(
                                color: Colors.teal.shade200,
                                fontWeight: FontWeight.w400),
                            labelStyle: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.teal,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                (showPassword.value)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.teal,
                              ),
                              onPressed: passwordVisibilty,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AuthController.instance.register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim());
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ), backgroundColor: Colors.white,
                        fixedSize: const Size(320, 60),
                        elevation: 0.5),
                    child: const Text(
                      "Create Account ",
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?  ",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
