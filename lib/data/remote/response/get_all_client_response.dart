import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:car_rental_app/domain/models/client.dart';

class GetAllClientResponse {
  bool? success;
  String? errorMessage;
  List<Client>? data;
  GetAllClientResponse({
    this.success,
    this.errorMessage,
    this.data,
  });

  GetAllClientResponse copyWith({
    bool? success,
    String? errorMessage,
    List<Client>? data,
  }) {
    return GetAllClientResponse(
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

  factory GetAllClientResponse.fromMap(Map<String, dynamic> map) {
    return GetAllClientResponse(
      success: map['success'],
      errorMessage: map['errorMessage'],
      data: map['data'] != null
          ? List<Client>.from(map['data']?.map((x) => Client.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllClientResponse.fromJson(String source) =>
      GetAllClientResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllClientResponse(success: $success, errorMessage: $errorMessage, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllClientResponse &&
        other.success == success &&
        other.errorMessage == errorMessage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ data.hashCode;
}
