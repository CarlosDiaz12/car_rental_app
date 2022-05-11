import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/employee.dart';

class GetAllEmployeeResponse {
  bool? success;
  String? errorMessage;
  List<Employee>? data;
  GetAllEmployeeResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllEmployeeResponse copyWith({
    bool? success,
    String? errorMessage,
    List<Employee>? data,
  }) {
    return GetAllEmployeeResponse(
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

  factory GetAllEmployeeResponse.fromMap(Map<String, dynamic> map) {
    return GetAllEmployeeResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<Employee>.from(map['data']?.map((x) => Employee.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllEmployeeResponse.fromJson(String source) =>
      GetAllEmployeeResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllEmployeeResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllEmployeeResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
