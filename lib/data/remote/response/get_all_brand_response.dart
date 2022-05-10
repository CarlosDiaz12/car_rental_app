import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/brand.dart';

class GetAllBrandResponse {
  bool? success;
  String? errorMessage;
  List<Brand>? data;
  GetAllBrandResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllBrandResponse copyWith({
    bool? success,
    String? errorMessage,
    List<Brand>? data,
  }) {
    return GetAllBrandResponse(
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

  factory GetAllBrandResponse.fromMap(Map<String, dynamic> map) {
    return GetAllBrandResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<Brand>.from(map['data']?.map((x) => Brand.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllBrandResponse.fromJson(String source) =>
      GetAllBrandResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllBrandResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllBrandResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
