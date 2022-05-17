import 'dart:convert';

class LoginDto {
  String userName;
  String password;
  LoginDto({
    required this.userName,
    required this.password,
  });

  LoginDto copyWith({
    String? userName,
    String? password,
  }) {
    return LoginDto(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'password': password});

    return result;
  }

  factory LoginDto.fromMap(Map<String, dynamic> map) {
    return LoginDto(
      userName: map['userName'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDto.fromJson(String source) =>
      LoginDto.fromMap(json.decode(source));

  @override
  String toString() => 'LoginDto(userName: $userName, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginDto &&
        other.userName == userName &&
        other.password == password;
  }

  @override
  int get hashCode => userName.hashCode ^ password.hashCode;
}
