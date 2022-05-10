import 'dart:convert';

class FuelType {
  int? id;
  bool? status;
  String? description;
  FuelType({
    this.id,
    this.status,
    this.description,
  });

  FuelType copyWith({
    int? id,
    bool? status,
    String? description,
  }) {
    return FuelType(
      id: id ?? this.id,
      status: status ?? this.status,
      description: description ?? this.description,
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

    return result;
  }

  factory FuelType.fromMap(Map<String, dynamic> map) {
    return FuelType(
      id: map['id']?.toInt(),
      status: map['status'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelType.fromJson(String source) =>
      FuelType.fromMap(json.decode(source));

  @override
  String toString() =>
      'FuelType(id: $id, status: $status, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FuelType &&
        other.id == id &&
        other.status == status &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ description.hashCode;
}
