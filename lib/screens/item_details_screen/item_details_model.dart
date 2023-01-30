class ItemDetailModel {
  late String id, title, image, deliveryDays, description;
  late List banners;
  late int sellingPrice, totalPrice;

  ItemDetailModel(
      {required this.id,
      required this.title,
      required this.deliveryDays,
      required this.image,
      required this.description,
      required this.banners,
      required this.sellingPrice,
      required this.totalPrice});

  ItemDetailModel.fromJson(Map<String, dynamic> map) {
    banners = map['banner'];
    deliveryDays = map['delivery_days'];
    description = map['des'];
    id = map['id'];
    image = map['img'];
    sellingPrice = map['sell_price'];
    title = map['title'];
    totalPrice = map['total_price'];
  }
}
