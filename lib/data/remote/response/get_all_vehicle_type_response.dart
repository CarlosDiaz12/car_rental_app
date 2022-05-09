import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_movies_app/domain/models/vehicle_type.dart';

class GetAllVehicleTypeResponse {
  bool? success;
  String? errorMessage;
  List<VehicleType>? data;
  GetAllVehicleTypeResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllVehicleTypeResponse copyWith({
    bool? success,
    String? errorMessage,
    List<VehicleType>? data,
  }) {
    return GetAllVehicleTypeResponse(
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

  factory GetAllVehicleTypeResponse.fromMap(Map<String, dynamic> map) {
    return GetAllVehicleTypeResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<VehicleType>.from(
              map['data']?.map((x) => VehicleType.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllVehicleTypeResponse.fromJson(String source) =>
      GetAllVehicleTypeResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllVehicleTypeResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllVehicleTypeResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
