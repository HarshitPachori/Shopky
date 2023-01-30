class ItemsDataModel {
  late String detailsId;
  late String id;
  late String image;
  late String title;
  late int totalPrice;
  late int sellingPrice;
  ItemsDataModel(
      {required this.detailsId,
      required this.id,
      required this.image,
      required this.title,
      required this.sellingPrice,
      required this.totalPrice});
  ItemsDataModel.fromJson(Map<String, dynamic> map) {
    detailsId = map['details_id'];
    id = map['id'];
    image = map['img'];
    sellingPrice = map['sell_price'];
    title = map['title'];
    totalPrice = map['total_price'];
  }
}
