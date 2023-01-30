import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopky/screens/my_order_screen/my_order_controller.dart';

import 'my_orders_model.dart';
import 'my_order_details.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    final Size size = Get.size;
    return Container(
      color: Colors.teal[800],
      child: SafeArea(child: GetBuilder<MyOrderController>(builder: (value) {
        if (!value.isLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("My Orders"),
              backgroundColor: Colors.teal[800],
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                  itemCount: value.model.length,
                  itemBuilder: (context, index) {
                    return listviewBuilderItems(size, value.model[index]);
                  }),
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

  Widget listviewBuilderItems(Size size, MyOrdersModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(() => MyOrderDetailsScreen(
                model: model,
              ));
        },
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
                        text: "${model.name}"
                            "\n",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        children: [
                      TextSpan(
                        text: model.status == 0
                            ? "Status : Pending"
                            : "Status : Delivered",
                        style: TextStyle(
                            fontSize: 16,
                            color: model.status == 0
                                ? Colors.grey[500]
                                : Colors.green,
                            fontWeight: FontWeight.w500),
                      ),
                    ])),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
