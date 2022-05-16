import 'dart:convert';

import 'package:car_rental_app/ui/common/view_utils.dart';

class IsAvailableForRentDto {
  int vehicleId;
  DateTime rentDate;
  DateTime returnDate;
  IsAvailableForRentDto({
    required this.vehicleId,
    required this.rentDate,
    required this.returnDate,
  });

  IsAvailableForRentDto copyWith({
    int? vehicleId,
    DateTime? rentDate,
    DateTime? returnDate,
  }) {
    return IsAvailableForRentDto(
      vehicleId: vehicleId ?? this.vehicleId,
      rentDate: rentDate ?? this.rentDate,
      returnDate: returnDate ?? this.returnDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'vehicleId': vehicleId});
    result.addAll({'rentDate': ViewUtils.formatDate(rentDate)});
    result.addAll({'returnDate': ViewUtils.formatDate(returnDate)});

    return result;
  }

  factory IsAvailableForRentDto.fromMap(Map<String, dynamic> map) {
    return IsAvailableForRentDto(
      vehicleId: map['vehicleId']?.toInt() ?? 0,
      rentDate: DateTime.parse(map['rentDate']),
      returnDate: DateTime.parse(map['returnDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory IsAvailableForRentDto.fromJson(String source) =>
      IsAvailableForRentDto.fromMap(json.decode(source));

  @override
  String toString() =>
      'IsAvailableForRentDto(vehicleId: $vehicleId, rentDate: $rentDate, returnDate: $returnDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IsAvailableForRentDto &&
        other.vehicleId == vehicleId &&
        other.rentDate == rentDate &&
        other.returnDate == returnDate;
  }

  @override
  int get hashCode =>
      vehicleId.hashCode ^ rentDate.hashCode ^ returnDate.hashCode;
}
