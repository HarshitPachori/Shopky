import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopky/screens/categories_and_featured/categories_and_featured_screen.dart';
import 'package:shopky/utils/drawer.dart';

import '../../models/categories_models.dart';
import '../cart_screen/cart_screen.dart';
import '../item_screen/items_screen.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    final Size size = Get.size;
    return Container(
      color: Colors.teal[800],
      child: SafeArea(child: GetBuilder<HomeScreenController>(builder: (value) {
        if (!value.isLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("E-Commerce App"),
              backgroundColor: Colors.teal[800],
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(() => CartScreen());
                    },
                    icon: const Icon(Icons.add_shopping_cart))
              ],
            ),
            drawer: const HomeScreenDrawer(),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // banner
                    SizedBox(
                      height: size.height / 3.5,
                      width: size.width,
                      child: PageView.builder(
                          itemCount: controller.bannerData.length,
                          onPageChanged: controller.changeIndicator,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          controller.bannerData[index].image),
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
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < controller.isSelected.length;
                                i++)
                              indicator(size, controller.isSelected[i].value),
                          ],
                        ),
                      ),
                    ),
                    // categories
                    categoriesTitle(size, "All Categories", () {
                      Get.to(() => CategoriesScreen(
                            model: controller.categoriesData,
                          ));
                    }),
                    CategorylistviewBuilder(size, controller.categoriesData),
                    SizedBox(
                      height: size.height / 25,
                    ),
                    categoriesTitle(size, "Featured", () {
                      Get.to(() => FeaturedScreen(
                            model: controller.featuredData,
                          ));
                    }),
                    FeaturedlistviewBuilder(size, controller.featuredData),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      })),
    );
  }

  Widget CategorylistviewBuilder(Size size, List<CategoriesModel> data) {
    return SizedBox(
      height: size.height / 7,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return CategorylistviewItems(size, data[index]);
          }),
    );
  }
  Widget FeaturedlistviewBuilder(Size size, List<FeaturedModel> data) {
    return SizedBox(
      height: size.height / 7,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return FeaturedlistviewItems(size, data[index]);
          }),
    );
  }

  Widget CategorylistviewItems(Size size, CategoriesModel categories) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ItemsScreen(
                categoryId: categories.id,
                categoryTitle: categories.title,
              ));
        },
        child: SizedBox(
          height: size.height / 7,
          width: size.width / 4.2,
          child: Column(
            children: [
              Container(
                height: size.height / 12,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          categories.image,
                        ),
                        fit: BoxFit.contain)),
              ),
              Expanded(
                  child: SizedBox(
                child: Text(
                  categories.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
  Widget FeaturedlistviewItems(Size size, FeaturedModel categories) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ItemsScreen(
                categoryId: categories.id,
                categoryTitle: categories.title,
              ));
        },
        child: SizedBox(
          height: size.height / 7,
          width: size.width / 4.2,
          child: Column(
            children: [
              Container(
                height: size.height / 12,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          categories.image,
                        ),
                        fit: BoxFit.contain)),
              ),
              Expanded(
                  child: SizedBox(
                child: Text(
                  categories.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget categoriesTitle(Size size, String title, Function function) {
    return SizedBox(
      height: size.height / 17,
      width: size.width / 1.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () => function(),
            child: Text(
              "View More",
              style: TextStyle(fontSize: 15, color: Colors.teal[800]),
            ),
          ),
        ],
      ),
    );
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
