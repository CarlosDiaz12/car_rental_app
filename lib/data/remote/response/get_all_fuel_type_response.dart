import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/fuel_type.dart';

class GetAllFuelTypeResponse {
  bool? success;
  String? errorMessage;
  List<FuelType>? data;
  GetAllFuelTypeResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllFuelTypeResponse copyWith({
    bool? success,
    String? errorMessage,
    List<FuelType>? data,
  }) {
    return GetAllFuelTypeResponse(
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

  factory GetAllFuelTypeResponse.fromMap(Map<String, dynamic> map) {
    return GetAllFuelTypeResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<FuelType>.from(map['data']?.map((x) => FuelType.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllFuelTypeResponse.fromJson(String source) =>
      GetAllFuelTypeResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllFuelTypeResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllFuelTypeResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
