// class RelatedProductCategory {
//   final String name;
//   final String id;

//   const RelatedProductCategory({
//     required this.name,
//     required this.id,
//   });

//   factory RelatedProductCategory.fromJson(Map<String, dynamic> json) {
//     return RelatedProductCategory(
//       name: json['name'] ?? '',
//       id: json['id'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'id': id,
//     };
//   }
// }

class ProductCategory {
  ProductCategory({
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
  late final List<RelatedProductCategory> items;

  ProductCategory.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        subCode = json['subCode'],
        message = json['message'],
        error = json['error'],
        items = List<RelatedProductCategory>.from(
          json['items'].map(
            (item) => RelatedProductCategory.fromJson(item),
          ),
        );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['subCode'] = subCode;
    _data['message'] = message;
    _data['error'] = error;
    _data['items'] = items.map((item) => item.toJson()).toList();
    return _data;
  }
}

class RelatedProductCategory {
  RelatedProductCategory({
    required this.id,
    required this.name,
    required this.status,
    required this.V,
  });

  late final String id;
  late final String name;
  late final int status;
  late final int V;

  RelatedProductCategory.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        status = json['status'],
        V = json['__v'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    _data['__v'] = V;
    return _data;
  }
}
