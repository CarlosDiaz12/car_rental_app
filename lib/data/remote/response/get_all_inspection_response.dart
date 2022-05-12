import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/inspection.dart';

class GetAllInspectionResponse {
  bool? success;
  String? errorMessage;
  List<Inspection>? data;
  GetAllInspectionResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllInspectionResponse copyWith({
    bool? success,
    String? errorMessage,
    List<Inspection>? data,
  }) {
    return GetAllInspectionResponse(
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

  factory GetAllInspectionResponse.fromMap(Map<String, dynamic> map) {
    return GetAllInspectionResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<Inspection>.from(
              map['data']?.map((x) => Inspection.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllInspectionResponse.fromJson(String source) =>
      GetAllInspectionResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllInspectionResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllInspectionResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
