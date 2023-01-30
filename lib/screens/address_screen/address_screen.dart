import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../confirmation_screen/confirmation_screen.dart';
import 'address_screen_controller.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressScreenController>(
        init: AddressScreenController(),
        builder: (value) {
          if (value.isAddressAvailable) {
            return EditAddressScreen();
          } else {
            return AddAddressScreen();
          }
        });
  }
}

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key? key}) : super(key: key);
  final controller = Get.find<AddressScreenController>();
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Container(
      color: Colors.teal[800],
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Address"),
          backgroundColor: Colors.teal[800],
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              SizedBox(
                height: size.height / 30,
              ),
              SizedBox(
                height: size.height / 10,
                width: size.width / 1.1,
                child: TextField(
                  controller: controller.nameController,
                  maxLength: 15,
                  decoration: const InputDecoration(
                      hintText: "Full  Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              SizedBox(
                height: size.height / 5,
                width: size.width / 1.1,
                child: TextField(
                  controller: controller.addressController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      hintText: "Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              SizedBox(
                height: size.height / 10,
                width: size.width / 1.1,
                child: TextField(
                  controller: controller.pincodeController,
                  maxLength: 6,
                  decoration: const InputDecoration(
                      hintText: "Pin code",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            controller.onTap();
          },
          child: Container(
            height: size.height / 12,
            color: Colors.teal[800],
            alignment: Alignment.center,
            child: const Text(
              "Save",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class EditAddressScreen extends StatelessWidget {
  EditAddressScreen({Key? key}) : super(key: key);
  final controller = Get.find<AddressScreenController>();
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Container(
      color: Colors.teal[800],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal[800],
            title: const Text("Address"),
          ),
          body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  addressCard(size),
                ],
              )),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              Get.to(() => ConfirmationScreen());
            },
            child: Container(
                height: size.height / 12,
                width: size.width / 1.2,
                color: Colors.teal[800],
                alignment: Alignment.center,
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget addressCard(Size size) {
    return Material(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: size.width / 1.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                controller.address,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              controller.pincode,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            GestureDetector(
              onTap: () {
                controller.onEdit();
              },
              child: Container(
                  height: size.height / 18,
                  width: size.width / 1.2,
                  color: Colors.teal[800],
                  alignment: Alignment.center,
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
