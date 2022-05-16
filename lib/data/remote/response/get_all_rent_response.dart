import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/rent.dart';

class GetAllRentResponse {
  bool? success;
  String? errorMessage;
  List<Rent>? data;
  GetAllRentResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllRentResponse copyWith({
    bool? success,
    String? errorMessage,
    List<Rent>? data,
  }) {
    return GetAllRentResponse(
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
      result.addAll({'data': data!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetAllRentResponse.fromMap(Map<String, dynamic> map) {
    return GetAllRentResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<Rent>.from(map['data']?.map((x) => Rent.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllRentResponse.fromJson(String source) =>
      GetAllRentResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllRentResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllRentResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
