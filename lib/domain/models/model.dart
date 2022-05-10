import 'dart:convert';

import 'package:car_rental_app/domain/models/brand.dart';

class Model {
  int? id;
  bool? status;
  String? description;
  int? brandId;
  Brand? brand;
  Model({
    this.id,
    this.status,
    this.description,
    this.brandId,
    this.brand,
  });

  Model copyWith({
    int? id,
    bool? status,
    String? description,
    int? brandId,
    Brand? brand,
  }) {
    return Model(
      id: id ?? this.id,
      status: status ?? this.status,
      description: description ?? this.description,
      brandId: brandId ?? this.brandId,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (brandId != null) {
      result.addAll({'brandId': brandId});
    }
    if (brand != null) {
      result.addAll({'brand': brand!.toMap()});
    }

    return result;
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      id: map['id']?.toInt(),
      status: map['status'],
      description: map['description'],
      brandId: map['brandId']?.toInt(),
      brand: map['brand'] != null ? Brand.fromMap(map['brand']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Model(id: $id, status: $status, description: $description, brandId: $brandId, brand: $brand)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Model &&
        other.id == id &&
        other.status == status &&
        other.description == description &&
        other.brandId == brandId &&
        other.brand == brand;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        description.hashCode ^
        brandId.hashCode ^
        brand.hashCode;
  }
}
