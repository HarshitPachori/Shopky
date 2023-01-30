import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopky/models/banner_data_model.dart';
import 'package:shopky/models/categories_models.dart';
import 'dart:developer';

class HomeScreenController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late List<BannerDataModel> bannerData;
  late List<CategoriesModel> categoriesData;
  late List<FeaturedModel> featuredData;
  bool isLoading = true;
  List<RxBool> isSelected = [];

  void getAllData() async {
    await Future.wait([
      getBannerData(),
      getAllCategories(),
      getFeaturedData(),
    ]).then((value) {
      log("data");
      log(bannerData[0].image);

      isLoading = false;
      update();
    });
  }

  void changeIndicator(int index) {
    for (var i = 0; i < isSelected.length; i++) {
      if (isSelected[i].value) {
        isSelected[i].value = false;
      }
    }
    isSelected[index].value = true;
  }

  Future<void> getBannerData() async {
    await firebaseFirestore.collection("banner").get().then((value) {
      bannerData =
          value.docs.map((e) => BannerDataModel.fromJson(e.data())).toList();
      for (var i = 0; i < bannerData.length; i++) {
        isSelected.add(false.obs);
      }
      isSelected[0].value = true;
    });
  }

  Future<void> getAllCategories() async {
    await firebaseFirestore.collection("categories").get().then((value) {
      categoriesData =
          value.docs.map((e) => CategoriesModel.fromJson(e.data())).toList();
    });
  }

  Future<void> getFeaturedData() async {
    await firebaseFirestore.collection("featured").get().then((value) {
      featuredData =
          value.docs.map((e) => FeaturedModel.fromJson(e.data())).toList();
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAllData();
  }
}
