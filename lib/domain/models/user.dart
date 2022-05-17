import 'dart:convert';

class User {
  int? id;
  bool? status;
  String? userName;
  String? name;
  String? password;
  User({
    this.id,
    this.status,
    this.userName,
    this.name,
    this.password,
  });

  User copyWith({
    int? id,
    bool? status,
    String? userName,
    String? name,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      status: status ?? this.status,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      password: password ?? this.password,
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
    if (userName != null) {
      result.addAll({'userName': userName});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (password != null) {
      result.addAll({'password': password});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      status: map['status'],
      userName: map['userName'],
      name: map['name'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, status: $status, userName: $userName, name: $name, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.status == status &&
        other.userName == userName &&
        other.name == name &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        userName.hashCode ^
        name.hashCode ^
        password.hashCode;
  }
}
