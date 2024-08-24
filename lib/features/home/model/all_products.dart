class AllProduct {
  AllProduct({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });
  late final bool status;
  late final int subCode;
  late final String message;
  late final String error;
  late final List<AllProductsItem> items;

  AllProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = List.from(json['items'])
        .map((e) => AllProductsItem.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['subCode'] = subCode;
    _data['message'] = message;
    _data['error'] = error;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AllProductsItem {
  AllProductsItem({
    required this.id,
    required this.categoryId,
    required this.skinTypeId,
    required this.productName,
    required this.description,
    required this.price,
    required this.status,
    required this.timestamp,
    required this.symptomId,
    required this.V,
    required this.productImage,
  });
  late final String id;
  late final String categoryId;
  late final String skinTypeId;
  late final String symptomId;
  late final String productName;
  late final String description;
  late final String price;
  late final int? status;
  late final String? timestamp;
  late final int? V;
  late final List<String> productImage;

  factory AllProductsItem.fromJson(Map<String, dynamic> json) {
    return AllProductsItem(
      id: json['_id'],
      categoryId: json['categoryId'],
      skinTypeId: json['skinTypeId'],
      productName: json['productName'],
      description: json['description'],
      symptomId: json['symptomId'],
      price: json['price'],
      status: json['status'],
      timestamp: json['timestamp'],
      V: json['__v'],
      productImage: List<String>.from(json['productImage']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['categoryId'] = categoryId;
    _data['skinTypeId'] = skinTypeId;
    _data['symptomId'] = symptomId;
    _data['productName'] = productName;
    _data['description'] = description;
    _data['price'] = price;
    _data['status'] = status;
    _data['timestamp'] = timestamp;
    _data['__v'] = V;
    _data['productImage'] = productImage;
    return _data;
  }
}
