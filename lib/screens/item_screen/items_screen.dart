import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopky/screens/search/search_screen.dart';

import 'item_screen_data_model.dart';
import '../item_details_screen/items_detail_screen.dart';
import 'item_screen_controller.dart';

class ItemsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;
  ItemsScreen({Key? key, required this.categoryId, required this.categoryTitle})
      : super(key: key);
  final controller = Get.put(ItemScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    controller.categoryTitle = categoryTitle;
    controller.categoryId = categoryId;
    controller.getPaginedData();

    return Container(
      color: Colors.teal[800],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.teal[800],
            title: Text(categoryTitle),
            centerTitle: true,
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 40,
                ),
                searchBar(size, context),
                Expanded(child: SizedBox(
                  child: GetBuilder<ItemScreenController>(builder: (value) {
                    if (!value.isLoading) {
                      return ListView.builder(
                        controller: controller.scrollController,
                        itemCount: value.itemsData.length,
                        itemBuilder: (context, index) {
                          return listviewBuilderItems(
                              size, value.itemsData[index]);
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                )),
                Obx(() {
                  if (controller.isLoading1.value) {
                    return Container(
                      height: size.height / 10,
                      width: size.width,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listviewBuilderItems(Size size, ItemsDataModel model) {
    int discount =
        controller.calculateDiscount(model.totalPrice, model.sellingPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ItemsDetailScreen(
                id: model.detailsId,
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
                        text: "${model.title}"
                            "\n",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        children: [
                      TextSpan(
                        text: "${model.totalPrice}\t",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text: "${model.sellingPrice}\n",
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
    );
  }

  Widget searchBar(Size size, BuildContext context) {
    return Hero(
      tag: "Search Bar",
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: SearchScreen());
        },
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
          child: Container(
            height: size.height / 15,
            width: size.width / 1.1,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Search here..."),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
