import 'dart:convert';

class Example {
  String? id;
  Example({
    this.id,
  });

  Example copyWith({
    String? id,
  }) {
    return Example(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory Example.fromMap(Map<String, dynamic> map) {
    return Example(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Example.fromJson(String source) =>
      Example.fromMap(json.decode(source));

  @override
  String toString() => 'Example(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Example && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
