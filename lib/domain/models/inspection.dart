import 'dart:convert';

import 'package:car_rental_app/domain/enums/inspection_type.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';

import '../enums/fuel_quantity.dart';
import 'client.dart';
import 'employee.dart';
import 'vehicle.dart';

class Inspection {
  int? id;
  bool? status;
  int? vehicleId;
  Vehicle? vehicle;
  int? clientId;
  Client? client;
  bool? hasScratches;
  FuelQuantity? fuelQuantity;
  bool? hasSpareTire;
  bool? hasManualJack;
  bool? hasGlassBreakage;
  bool? firstTireCondition;
  bool? secondTireCondition;
  bool? thirdTireCondition;
  bool? fourthTireCondition;
  DateTime? inspectionDate;
  int? employeeId;
  Employee? employee;
  InspectionType? inspectionType;
  Inspection({
    this.id,
    this.status,
    this.vehicleId,
    this.vehicle,
    this.clientId,
    this.client,
    this.hasScratches,
    this.fuelQuantity,
    this.hasSpareTire,
    this.hasManualJack,
    this.hasGlassBreakage,
    this.firstTireCondition,
    this.secondTireCondition,
    this.thirdTireCondition,
    this.fourthTireCondition,
    this.inspectionDate,
    this.employeeId,
    this.employee,
    this.inspectionType,
  });

  Inspection copyWith(
      {int? id,
      bool? status,
      int? vehicleId,
      Vehicle? vehicle,
      int? clientId,
      Client? client,
      bool? hasScratches,
      FuelQuantity? fuelQuantity,
      bool? hasSpareTire,
      bool? hasManualJack,
      bool? hasGlassBreakage,
      bool? firstTireCondition,
      bool? secondTireCondition,
      bool? thirdTireCondition,
      bool? fourthTireCondition,
      DateTime? inspectionDate,
      int? employeeId,
      Employee? employee,
      InspectionType? inspectionType}) {
    return Inspection(
        id: id ?? this.id,
        status: status ?? this.status,
        vehicleId: vehicleId ?? this.vehicleId,
        vehicle: vehicle ?? this.vehicle,
        clientId: clientId ?? this.clientId,
        client: client ?? this.client,
        hasScratches: hasScratches ?? this.hasScratches,
        fuelQuantity: fuelQuantity ?? this.fuelQuantity,
        hasSpareTire: hasSpareTire ?? this.hasSpareTire,
        hasManualJack: hasManualJack ?? this.hasManualJack,
        hasGlassBreakage: hasGlassBreakage ?? this.hasGlassBreakage,
        firstTireCondition: firstTireCondition ?? this.firstTireCondition,
        secondTireCondition: secondTireCondition ?? this.secondTireCondition,
        thirdTireCondition: thirdTireCondition ?? this.thirdTireCondition,
        fourthTireCondition: fourthTireCondition ?? this.fourthTireCondition,
        inspectionDate: inspectionDate ?? this.inspectionDate,
        employeeId: employeeId ?? this.employeeId,
        employee: employee ?? this.employee,
        inspectionType: inspectionType ?? this.inspectionType);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (vehicleId != null) {
      result.addAll({'vehicleId': vehicleId});
    }
    if (vehicle != null) {
      result.addAll({'vehicle': vehicle!.toMap()});
    }
    if (clientId != null) {
      result.addAll({'clientId': clientId});
    }
    if (client != null) {
      result.addAll({'client': client!.toMap()});
    }
    if (hasScratches != null) {
      result.addAll({'hasScratches': hasScratches});
    }
    if (fuelQuantity != null) {
      result.addAll({'fuelQuantity': fuelQuantity!.index});
    }
    if (hasSpareTire != null) {
      result.addAll({'hasSpareTire': hasSpareTire});
    }
    if (hasManualJack != null) {
      result.addAll({'hasManualJack': hasManualJack});
    }
    if (hasGlassBreakage != null) {
      result.addAll({'hasGlassBreakage': hasGlassBreakage});
    }
    if (firstTireCondition != null) {
      result.addAll({'firstTireCondition': firstTireCondition});
    }
    if (secondTireCondition != null) {
      result.addAll({'secondTireCondition': secondTireCondition});
    }
    if (thirdTireCondition != null) {
      result.addAll({'thirdTireCondition': thirdTireCondition});
    }
    if (fourthTireCondition != null) {
      result.addAll({'fourthTireCondition': fourthTireCondition});
    }
    if (inspectionDate != null) {
      result.addAll({'inspectionDate': ViewUtils.formatDate(inspectionDate!)});
    }
    if (employeeId != null) {
      result.addAll({'employeeId': employeeId});
    }
    if (employee != null) {
      result.addAll({'employee': employee!.toMap()});
    }

    if (inspectionType != null) {
      result.addAll({'inspectionType': inspectionType!.index});
    }

    return result;
  }

  factory Inspection.fromMap(Map<String, dynamic> map) {
    return Inspection(
        id: map['id']?.toInt(),
        status: map['status'],
        vehicleId: map['vehicleId']?.toInt(),
        vehicle:
            map['vehicle'] != null ? Vehicle.fromMap(map['vehicle']) : null,
        clientId: map['clientId']?.toInt(),
        client: map['client'] != null ? Client.fromMap(map['client']) : null,
        hasScratches: map['hasScratches'],
        fuelQuantity: map['fuelQuantity'] != null
            ? FuelQuantity.values[map['fuelQuantity']]
            : null,
        hasSpareTire: map['hasSpareTire'],
        hasManualJack: map['hasManualJack'],
        hasGlassBreakage: map['hasGlassBreakage'],
        firstTireCondition: map['firstTireCondition'],
        secondTireCondition: map['secondTireCondition'],
        thirdTireCondition: map['thirdTireCondition'],
        fourthTireCondition: map['fourthTireCondition'],
        inspectionDate: map['inspectionDate'] != null
            ? DateTime.parse(map['inspectionDate'])
            : null,
        employeeId: map['employeeId']?.toInt(),
        employee:
            map['employee'] != null ? Employee.fromMap(map['employee']) : null,
        inspectionType: map['inspectionType'] != null
            ? InspectionType.values[map['inspectionType']]
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Inspection.fromJson(String source) =>
      Inspection.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Inspection(id: $id, status: $status, vehicleId: $vehicleId, vehicle: $vehicle, clientId: $clientId, client: $client, hasScratches: $hasScratches, fuelQuantity: $fuelQuantity, hasSpareTire: $hasSpareTire, hasManualJack: $hasManualJack, hasGlassBreakage: $hasGlassBreakage, firstTireCondition: $firstTireCondition, secondTireCondition: $secondTireCondition, thirdTireCondition: $thirdTireCondition, fourthTireCondition: $fourthTireCondition, inspectionDate: $inspectionDate, employeeId: $employeeId, employee: $employee)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Inspection &&
        other.id == id &&
        other.status == status &&
        other.vehicleId == vehicleId &&
        other.vehicle == vehicle &&
        other.clientId == clientId &&
        other.client == client &&
        other.hasScratches == hasScratches &&
        other.fuelQuantity == fuelQuantity &&
        other.hasSpareTire == hasSpareTire &&
        other.hasManualJack == hasManualJack &&
        other.hasGlassBreakage == hasGlassBreakage &&
        other.firstTireCondition == firstTireCondition &&
        other.secondTireCondition == secondTireCondition &&
        other.thirdTireCondition == thirdTireCondition &&
        other.fourthTireCondition == fourthTireCondition &&
        other.inspectionDate == inspectionDate &&
        other.employeeId == employeeId &&
        other.employee == employee;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        vehicleId.hashCode ^
        vehicle.hashCode ^
        clientId.hashCode ^
        client.hashCode ^
        hasScratches.hashCode ^
        fuelQuantity.hashCode ^
        hasSpareTire.hashCode ^
        hasManualJack.hashCode ^
        hasGlassBreakage.hashCode ^
        firstTireCondition.hashCode ^
        secondTireCondition.hashCode ^
        thirdTireCondition.hashCode ^
        fourthTireCondition.hashCode ^
        inspectionDate.hashCode ^
        employeeId.hashCode ^
        employee.hashCode;
  }
}
