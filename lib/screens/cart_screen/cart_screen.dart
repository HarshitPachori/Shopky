import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../item_details_screen/item_details_model.dart';
import '../address_screen/address_screen.dart';
import 'cart_screen_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final controller = Get.put(CartScreenController());
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: Colors.teal[800],
      child: SafeArea(child: GetBuilder<CartScreenController>(builder: (value) {
        if (!controller.isLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("My Cart"),
              backgroundColor: Colors.teal[800],
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                  itemCount: controller.productDetails.length,
                  itemBuilder: (context, index) {
                    return cartItems(size, controller.productDetails[index]);
                  }),
            ),
            bottomNavigationBar: SizedBox(
              height: size.height / 12,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rs ${value.totalPrice}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const AddressScreen());
                      },
                      child: Container(
                        height: size.height / 18,
                        width: size.width / 2.8,
                        color: Colors.blueAccent,
                        alignment: Alignment.center,
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                              fontSize: 17.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      })),
    );
  }

  Widget cartItems(Size size, ItemDetailModel model) {
    int discount =
        controller.calculateDiscount(model.totalPrice, model.sellingPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Container(
        height: size.height / 3,
        width: size.width / 1.05,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: size.height / 8,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    Container(
                      height: size.height / 8,
                      width: size.width / 4.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                model.image,
                              ),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      width: size.width / 22,
                    ),
                    Expanded(
                        child: SizedBox(
                      child: RichText(
                          text: TextSpan(
                              text: "${model.title} \n",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              children: [
                            TextSpan(
                              text: "${model.totalPrice}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: "${model.sellingPrice}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "$discount% off",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            ),
                          ])),
                    ))
                  ],
                ),
              ),
            ),
            Text(
              "Will be delivered in ${model.deliveryDays} days ",
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                  fontSize: 15),
            ),
            ListTile(
              title: const Text("Remove from Cart"),
              onTap: () {
                controller.removeFromCart(model.id);
              },
              trailing: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
