import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/vehicle.dart';

class GetAllVehicleResponse {
  bool? success;
  String? errorMessage;
  List<Vehicle>? data;
  GetAllVehicleResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllVehicleResponse copyWith({
    bool? success,
    String? errorMessage,
    List<Vehicle>? data,
  }) {
    return GetAllVehicleResponse(
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

  factory GetAllVehicleResponse.fromMap(Map<String, dynamic> map) {
    return GetAllVehicleResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<Vehicle>.from(map['data']?.map((x) => Vehicle.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllVehicleResponse.fromJson(String source) =>
      GetAllVehicleResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllVehicleResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllVehicleResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
