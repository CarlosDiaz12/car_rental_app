import 'dart:convert';

class VehicleType {
  int? id;
  bool? status;
  String? description;

  VehicleType({
    this.id,
    this.status,
    this.description,
  });

  VehicleType copyWith({
    int? id,
    bool? status,
    String? description,
  }) {
    return VehicleType(
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

  factory VehicleType.fromMap(Map<String, dynamic> map) {
    return VehicleType(
      id: map['id']?.toInt(),
      status: map['status'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleType.fromJson(String source) =>
      VehicleType.fromMap(json.decode(source));

  @override
  String toString() =>
      'VehicleType(id: $id, status: $status, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleType &&
        other.id == id &&
        other.status == status &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ description.hashCode;
}
