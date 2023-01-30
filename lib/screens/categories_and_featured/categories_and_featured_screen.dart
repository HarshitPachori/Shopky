import 'package:flutter/material.dart';

import '../../models/categories_models.dart';
import 'package:get/get.dart';

import '../item_screen/items_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key, required this.model})
      : super(key: key);
  final List<CategoriesModel> model;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[800],
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("All Categories"),
          backgroundColor: Colors.teal[800],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: model.length,
              itemBuilder: (context, index) {
                return gridviewItems(Get.size, model[index]);
              }),
        ),
      )),
    );
  }

  Widget gridviewItems(Size size, CategoriesModel categories) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ItemsScreen(
                categoryTitle: categories.title,
                categoryId: categories.id,
              ));
        },
        child: SizedBox(
          height: size.height / 8,
          width: size.width / 4.2,
          child: Column(
            children: [
              Container(
                height: size.height / 8,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(categories.image),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Expanded(
                  child: SizedBox(
                child: Text(
                  categories.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({Key? key, required this.model})
      : super(key: key);
  final List<FeaturedModel> model;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[800],
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("All Categories"),
          backgroundColor: Colors.teal[800],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: model.length,
              itemBuilder: (context, index) {
                return gridviewItems(Get.size, model[index]);
              }),
        ),
      )),
    );
  }

  Widget gridviewItems(Size size, FeaturedModel categories) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ItemsScreen(
                categoryTitle: categories.title,
                categoryId: categories.id,
              ));
        },
        child: SizedBox(
          height: size.height / 8,
          width: size.width / 4.2,
          child: Column(
            children: [
              Container(
                height: size.height / 8,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(categories.image),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Expanded(
                  child: SizedBox(
                child: Text(
                  categories.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
