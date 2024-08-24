class ProductModel {
  String? title;
  String? image;
  String? desc;
  String? id;
  String? category;
  String? skinType;

  ProductModel({
    this.title,
    this.image,
    this.desc,
    this.id,
    this.category,
    this.skinType,
  });

  ProductModel copyWith({
    String? title,
    String? image,
    String? desc,
    String? id,
    String? category,
    String? skinType,
  }) =>
      ProductModel(
        title: title ?? this.title,
        image: image ?? this.image,
        desc: desc ?? this.desc,
        id: id ?? this.id,
        category: category ?? this.category,
        skinType: skinType ?? this.skinType,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        title: json["title"],
        image: json["image"],
        desc: json["desc"],
        id: json["id"],
        category: json["category"],
        skinType: json["skinType"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "desc": desc,
        "id": id,
        "category": category,
        "skinType": skinType,
      };
}
