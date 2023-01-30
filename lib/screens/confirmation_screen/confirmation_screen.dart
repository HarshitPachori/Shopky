import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'confirmation_screen_controller.dart';

class ConfirmationScreen extends StatelessWidget {
  ConfirmationScreen({Key? key}) : super(key: key);
  final controller = Get.put(ConfirmationScreenController());
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    return Container(
      color: Colors.teal[800],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.teal[800],
            title: const Text("Confirmation"),
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
                SizedBox(
                  height: size.height / 30,
                ),
                orderDetails(size),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              controller.onPay();
            },
            child: Container(
                height: size.height / 12,
                width: size.width / 1.2,
                color: Colors.teal[800],
                alignment: Alignment.center,
                child: const Text(
                  "Pay Now",
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
              onTap: () {},
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

  Widget orderDetails(Size size) {
    Widget text(String header, String footer) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            footer,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )
        ],
      );
    }

    return Material(
      elevation: 5,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: size.width / 1.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Price Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            text("Total Price :", "Rs.${controller.totalPrice}"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: text("Discount :", "Rs.${controller.totalDiscount}"),
            ),
            text("Payable Price :", "Rs.${controller.payablePrice}"),
          ],
        ),
      ),
    );
  }
}
