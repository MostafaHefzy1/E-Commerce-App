import '../../presentation/resource/constants-manager.dart';

class CartModel {

  String image, title;
  int quantity;
  dynamic price;
  int id;

  CartModel(
      {required this.image, required this.id, required this.title, required this.quantity, required this.price});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        image: json[columnImage],
        title: json[columnTitle],
        quantity: json[columnQuantity],
        price: json[columnPrice],
        id: json[columnId]
    );
  }

  toJson() {
    return {
      columnImage: image,
      columnTitle: title,
      columnQuantity: quantity,
      columnPrice: price,
      columnId: id,
    };
  }

//

}