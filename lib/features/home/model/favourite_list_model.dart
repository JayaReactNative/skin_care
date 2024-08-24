class FavouriteData {
  FavouriteData({
    required this.id,
    required this.userId,
    required this.productId,
    required this.status,
    required this.timestamp,
    required this.V,
    required this.productDetail,
  });
  late final String id;
  late final String userId;
  late final String productId;
  late final int status;
  late final String timestamp;
  late final int V;
  late final List<ProductDetail> productDetail;

  FavouriteData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    productId = json['productId'];
    status = json['status'];
    timestamp = json['timestamp'];
    V = json['__v'];
    productDetail = List.from(json['productDetail'])
        .map((e) => ProductDetail.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['userId'] = userId;
    _data['productId'] = productId;
    _data['status'] = status;
    _data['timestamp'] = timestamp;
    _data['__v'] = V;
    _data['productDetail'] = productDetail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductDetail {
  ProductDetail({
    required this.id,
    required this.categoryId,
    required this.skinTypeId,
    required this.productName,
    required this.description,
    required this.price,
    required this.status,
    required this.timestamp,
    required this.productImage,
  });
  late final String id;
  late final String categoryId;
  late final String skinTypeId;
  late final String productName;
  late final String description;
  late final String price;
  late final int status;
  late final String timestamp;
  late final List<String> productImage;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    categoryId = json['categoryId'];
    skinTypeId = json['skinTypeId'];
    productName = json['productName'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    timestamp = json['timestamp'];
    productImage = List.castFrom<dynamic, String>(json['productImage']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['categoryId'] = categoryId;
    _data['skinTypeId'] = skinTypeId;
    _data['productName'] = productName;
    _data['description'] = description;
    _data['price'] = price;
    _data['status'] = status;
    _data['timestamp'] = timestamp;
    _data['productImage'] = productImage;
    return _data;
  }
}
