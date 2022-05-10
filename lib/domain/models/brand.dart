import 'dart:convert';

class Brand {
  int? id;
  bool? status;
  String? description;
  Brand({
    this.id,
    this.status,
    this.description,
  });

  Brand copyWith({
    int? id,
    bool? status,
    String? description,
  }) {
    return Brand(
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

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id']?.toInt(),
      status: map['status'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  @override
  String toString() =>
      'Brand(id: $id, status: $status, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Brand &&
        other.id == id &&
        other.status == status &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ description.hashCode;
}
