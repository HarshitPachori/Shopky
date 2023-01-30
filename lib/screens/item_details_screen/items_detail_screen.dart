import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../cart_screen/cart_screen.dart';
import 'item_details_controller.dart';

class ItemsDetailScreen extends StatelessWidget {
  final String id;
  const ItemsDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final controller = Get.put(ItemDetailController());
    controller.getItemDetails(id);
    return Container(
      color: Colors.teal[800],
      child: SafeArea(child: GetBuilder<ItemDetailController>(
        builder: (value) {
          if (!controller.isLoading) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal[800],
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart)),
                ],
              ),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //banner
                      SizedBox(
                        height: size.height / 3,
                        width: size.width,
                        child: PageView.builder(
                            itemCount: controller.model.banners.length,
                            // onPageChanged: controller.changeIndicator,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            controller.model.banners[index]),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              );
                            }),
                      ),
                      // indicator
                      SizedBox(
                        height: size.height / 25,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < controller.model.banners.length;
                                i++)
                              indicator(size, false),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 25,
                      ),
                      SizedBox(
                        width: size.width / 1.1,
                        child: Text(
                          controller.model.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 35,
                      ),
                      SizedBox(
                        width: size.width / 1.1,
                        child: RichText(
                            text: TextSpan(
                                text: "${controller.model.totalPrice}",
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough),
                                children: [
                              TextSpan(
                                text: "${controller.model.sellingPrice}",
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.grey[800],
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              TextSpan(
                                text: "${controller.discount}% off",
                                style: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.green,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ])),
                      ),

                      SizedBox(
                        height: size.height / 25,
                      ),
                      SizedBox(
                        width: size.width / 1.1,
                        child: Text(
                          controller.model.description,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 25,
                      ),
                      SizedBox(
                        width: size.width / 1.1,
                        child: const Text(
                          description,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 25,
                      ),
                      ListTile(
                        onTap: () {},
                        title: const Text("See Reviews"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        leading: const Icon(Icons.star),
                      ),
                      SizedBox(
                        height: size.height / 25,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: size.height / 14,
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: customButton(size, () {
                      if (controller.isAlreadyAvailable) {
                        Get.to(() => CartScreen());
                      } else {
                        controller.addItemsToCart();
                      }
                    },
                            Colors.redAccent,
                            controller.isAlreadyAvailable
                                ? "Go to Cart"
                                : "Add to Cart")),
                    Expanded(
                        child:
                            customButton(size, () {}, Colors.white, "Buy Now")),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  Widget customButton(Size size, Function function, Color color, String title) {
    return GestureDetector(
        onTap: () => function(),
        child: Container(
          color: color,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: color == Colors.redAccent ? Colors.white : Colors.black),
          ),
        ));
  }

  Widget indicator(Size size, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: isSelected ? size.height / 80 : size.height / 100,
        width: isSelected ? size.width / 80 : size.width / 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}
