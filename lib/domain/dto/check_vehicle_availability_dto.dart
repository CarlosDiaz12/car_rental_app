import 'dart:convert';

import 'package:car_rental_app/domain/enums/inspection_type.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';

class CheckVehicleAvailabilityDto {
  int clientId;
  int vehicleId;
  DateTime inspectionDate;
  InspectionType type;
  CheckVehicleAvailabilityDto({
    required this.clientId,
    required this.vehicleId,
    required this.inspectionDate,
    required this.type,
  });

  CheckVehicleAvailabilityDto copyWith({
    int? clientId,
    int? vehicleId,
    DateTime? inspectionDate,
    InspectionType? type,
  }) {
    return CheckVehicleAvailabilityDto(
      clientId: clientId ?? this.clientId,
      vehicleId: vehicleId ?? this.vehicleId,
      inspectionDate: inspectionDate ?? this.inspectionDate,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'clientId': clientId});
    result.addAll({'vehicleId': vehicleId});
    result.addAll({'inspectionDate': ViewUtils.formatDate(inspectionDate)});
    result.addAll({'type': type.index});

    return result;
  }

  factory CheckVehicleAvailabilityDto.fromMap(Map<String, dynamic> map) {
    return CheckVehicleAvailabilityDto(
      clientId: map['clientId']?.toInt() ?? 0,
      vehicleId: map['vehicleId']?.toInt() ?? 0,
      inspectionDate: DateTime.parse(map['inspectionDate']),
      type: InspectionType.values[map['type']],
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckVehicleAvailabilityDto.fromJson(String source) =>
      CheckVehicleAvailabilityDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CheckVehicleAvailabilityDto(clientId: $clientId, vehicleId: $vehicleId, inspectionDate: $inspectionDate, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckVehicleAvailabilityDto &&
        other.clientId == clientId &&
        other.vehicleId == vehicleId &&
        other.inspectionDate == inspectionDate &&
        other.type == type;
  }

  @override
  int get hashCode {
    return clientId.hashCode ^
        vehicleId.hashCode ^
        inspectionDate.hashCode ^
        type.hashCode;
  }
}
