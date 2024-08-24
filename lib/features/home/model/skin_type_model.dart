class SkinType {
  SkinType({
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
  late final List<SkinTypeItem> items;

  SkinType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items =
        List.from(json['items']).map((e) => SkinTypeItem.fromJson(e)).toList();
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

class SkinTypeItem {
  SkinTypeItem({
    required this.id,
    required this.name,
    required this.status,
    required this.V,
  });
  late final String id;
  late final String name;
  late final int status;
  late final int V;

  SkinTypeItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    status = json['status'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    _data['__v'] = V;
    return _data;
  }
}
