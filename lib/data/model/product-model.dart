class ProductModel {
  String title, description, category, image;
  dynamic id ;
  dynamic price;

  // Rate rate;

  ProductModel(
      {
      required this.title,
      required this.description,
      required this.category,
      required this.image,
      required this.price,
      required this.id,
      });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json["title"],
      description: json["description"],
      category: json["category"],
      image: json["image"],
      price: json["price"],
      id: json["id"],
      // rate: Rate.fromJson(json["rate"]),
    );
  }
//

//

}

// class Rate {
//   dynamic rate;
//
//   Rate({required this.rate});
//
//   factory Rate.fromJson(Map<String, dynamic> json) {
//     return Rate(
//       rate: Rate.fromJson(json["rate"]),
//     );
//   }
// //
//
// }
