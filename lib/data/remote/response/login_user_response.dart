import 'dart:convert';

import 'package:car_rental_app/domain/models/user.dart';

class LoginUserResponse {
  bool? success;
  String? errorMessage;
  User? data;
  LoginUserResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  LoginUserResponse copyWith({
    bool? success,
    String? errorMessage,
    User? data,
  }) {
    return LoginUserResponse(
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (success != null) {
      result.addAll({'success': success});
    }
    if (errorMessage != null) {
      result.addAll({'errorMessage': errorMessage});
    }
    if (data != null) {
      result.addAll({'data': data!.toMap()});
    }

    return result;
  }

  factory LoginUserResponse.fromMap(Map<String, dynamic> map) {
    return LoginUserResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null ? User.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUserResponse.fromJson(String source) =>
      LoginUserResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginUserResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginUserResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        other.data == data;
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
