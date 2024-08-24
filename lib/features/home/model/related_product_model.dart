class RelatedProductCat {
  final String name;
  final String image;
  final String id;

  const RelatedProductCat({
    required this.name,
    required this.id,
    required this.image,
  });

  factory RelatedProductCat.fromJson(Map<String, dynamic> json) {
    return RelatedProductCat(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'id': id,
    };
  }
}

class AllSymptoms {
  AllSymptoms({
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
  late final List<Symptoms> items;

  AllSymptoms.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = List.from(json['items']).map((e) => Symptoms.fromJson(e)).toList();
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

class Symptoms {
  Symptoms({
    required this.id,
    required this.symptomName,
    required this.symptomImage,
    required this.status,
    required this.timestamp,
    required this.V,
  });
  late final String id;
  late final String symptomName;
  late final List<String> symptomImage;
  late final int status;
  late final String timestamp;
  late final int V;

  Symptoms.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    symptomName = json['symptomName'];
    symptomImage = List.castFrom<dynamic, String>(json['symptomImage']);
    status = json['status'];
    timestamp = json['timestamp'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['symptomName'] = symptomName;
    _data['symptomImage'] = symptomImage;
    _data['status'] = status;
    _data['timestamp'] = timestamp;
    _data['__v'] = V;
    return _data;
  }
}
