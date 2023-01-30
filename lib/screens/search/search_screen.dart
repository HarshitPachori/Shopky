import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../item_screen/item_screen_data_model.dart';
import '../item_details_screen/items_detail_screen.dart';
import '../item_screen/item_screen_controller.dart';

class SearchScreen extends SearchDelegate {
  ItemScreenController controller = Get.find();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.searchProducts(query);
    return GetBuilder<ItemScreenController>(builder: (value) {
      if (!value.isSearchLoading) {
        return ListView.builder(
          itemCount: value.searchResults.length,
          itemBuilder: (context, index) {
            return listviewBuilderItems(Get.size, value.searchResults[index]);
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.searchProducts(query);
    return GetBuilder<ItemScreenController>(builder: (value) {
      if (!value.isSearchLoading) {
        return ListView.builder(
          itemCount: value.searchResults.length,
          itemBuilder: (context, index) {
            return listviewBuilderItems(Get.size, value.searchResults[index]);
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
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
                        text: "$discount % off",
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
}
