import 'dart:convert';

import 'package:car_rental_app/domain/models/brand.dart';
import 'package:car_rental_app/domain/models/fuel_type.dart';
import 'package:car_rental_app/domain/models/model.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';

class Vehicle {
  int? id;
  bool? status;
  String? description;
  int? chassisNumber;
  int? engineNumber;
  int? plateNumber;
  int? vehicleTypeId;
  VehicleType? vehicleType;
  int? brandId;
  Brand? brand;
  int? modelId;
  Model? model;
  int? fuelTypeId;
  FuelType? fuelType;
  Vehicle({
    this.id,
    this.status,
    this.description,
    this.chassisNumber,
    this.engineNumber,
    this.plateNumber,
    this.vehicleTypeId,
    this.brandId,
    this.brand,
    this.modelId,
    this.model,
    this.fuelTypeId,
    this.fuelType,
  });

  Vehicle copyWith({
    int? id,
    bool? status,
    String? description,
    int? chassisNumber,
    int? engineNumber,
    int? plateNumber,
    int? vehicleTypeId,
    int? brandId,
    Brand? brand,
    int? modelId,
    Model? model,
    int? fuelTypeId,
    FuelType? fuelType,
  }) {
    return Vehicle(
      id: id ?? this.id,
      status: status ?? this.status,
      description: description ?? this.description,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      engineNumber: engineNumber ?? this.engineNumber,
      plateNumber: plateNumber ?? this.plateNumber,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
      brandId: brandId ?? this.brandId,
      brand: brand ?? this.brand,
      modelId: modelId ?? this.modelId,
      model: model ?? this.model,
      fuelTypeId: fuelTypeId ?? this.fuelTypeId,
      fuelType: fuelType ?? this.fuelType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (chassisNumber != null) {
      result.addAll({'chassisNumber': chassisNumber});
    }
    if (engineNumber != null) {
      result.addAll({'engineNumber': engineNumber});
    }
    if (plateNumber != null) {
      result.addAll({'plateNumber': plateNumber});
    }
    if (vehicleTypeId != null) {
      result.addAll({'vehicleTypeId': vehicleTypeId});
    }
    if (brandId != null) {
      result.addAll({'brandId': brandId});
    }
    if (brand != null) {
      result.addAll({'brand': brand!.toMap()});
    }
    if (modelId != null) {
      result.addAll({'modelId': modelId});
    }
    if (model != null) {
      result.addAll({'model': model!.toMap()});
    }
    if (fuelTypeId != null) {
      result.addAll({'fuelTypeId': fuelTypeId});
    }
    if (fuelType != null) {
      result.addAll({'fuelType': fuelType!.toMap()});
    }

    return result;
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id']?.toInt(),
      status: map['status'],
      description: map['description'],
      chassisNumber: map['chassisNumber']?.toInt(),
      engineNumber: map['engineNumber']?.toInt(),
      plateNumber: map['plateNumber']?.toInt(),
      vehicleTypeId: map['vehicleTypeId']?.toInt(),
      brandId: map['brandId']?.toInt(),
      brand: map['brand'] != null ? Brand.fromMap(map['brand']) : null,
      modelId: map['modelId']?.toInt(),
      model: map['model'] != null ? Model.fromMap(map['model']) : null,
      fuelTypeId: map['fuelTypeId']?.toInt(),
      fuelType:
          map['fuelType'] != null ? FuelType.fromMap(map['fuelType']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vehicle(id: $id, status: $status, description: $description, chassisNumber: $chassisNumber, engineNumber: $engineNumber, plateNumber: $plateNumber, vehicleTypeId: $vehicleTypeId, brandId: $brandId, brand: $brand, modelId: $modelId, model: $model, fuelTypeId: $fuelTypeId, fuelType: $fuelType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vehicle &&
        other.id == id &&
        other.status == status &&
        other.description == description &&
        other.chassisNumber == chassisNumber &&
        other.engineNumber == engineNumber &&
        other.plateNumber == plateNumber &&
        other.vehicleTypeId == vehicleTypeId &&
        other.brandId == brandId &&
        other.brand == brand &&
        other.modelId == modelId &&
        other.model == model &&
        other.fuelTypeId == fuelTypeId &&
        other.fuelType == fuelType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        description.hashCode ^
        chassisNumber.hashCode ^
        engineNumber.hashCode ^
        plateNumber.hashCode ^
        vehicleTypeId.hashCode ^
        brandId.hashCode ^
        brand.hashCode ^
        modelId.hashCode ^
        model.hashCode ^
        fuelTypeId.hashCode ^
        fuelType.hashCode;
  }
}
