import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/model.dart';

class GetAllModelResponse {
  bool? success;
  String? errorMessage;
  List<Model>? data;
  GetAllModelResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllModelResponse copyWith({
    bool? success,
    String? errorMessage,
    List<Model>? data,
  }) {
    return GetAllModelResponse(
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

  factory GetAllModelResponse.fromMap(Map<String, dynamic> map) {
    return GetAllModelResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<Model>.from(map['data']?.map((x) => Model.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllModelResponse.fromJson(String source) =>
      GetAllModelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllModelResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllModelResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
