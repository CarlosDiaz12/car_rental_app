import 'dart:convert';

import 'package:car_rental_app/domain/models/client.dart';
import 'package:car_rental_app/domain/models/employee.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';

class Rent {
  int? id;
  bool? status;
  int? employeeId;
  Employee? employee;
  int? vehicleId;
  Vehicle? vehicle;
  int? clientId;
  Client? client;
  DateTime? rentDate;
  DateTime? returnDate;
  bool? returned;
  double? ratePerDay;
  int? daysQuantity;
  String? comment;
  Rent({
    this.id,
    this.status,
    this.employeeId,
    this.employee,
    this.vehicleId,
    this.vehicle,
    this.clientId,
    this.client,
    this.rentDate,
    this.returnDate,
    this.returned,
    this.ratePerDay,
    this.daysQuantity,
    this.comment,
  });

  Rent copyWith({
    int? id,
    bool? status,
    int? employeeId,
    Employee? employee,
    int? vehicleId,
    Vehicle? vehicle,
    int? clientId,
    Client? client,
    DateTime? rentDate,
    DateTime? returnDate,
    bool? returned,
    double? ratePerDay,
    int? daysQuantity,
    String? comment,
  }) {
    return Rent(
      id: id ?? this.id,
      status: status ?? this.status,
      employeeId: employeeId ?? this.employeeId,
      employee: employee ?? this.employee,
      vehicleId: vehicleId ?? this.vehicleId,
      vehicle: vehicle ?? this.vehicle,
      clientId: clientId ?? this.clientId,
      client: client ?? this.client,
      rentDate: rentDate ?? this.rentDate,
      returnDate: returnDate ?? this.returnDate,
      returned: returned ?? this.returned,
      ratePerDay: ratePerDay ?? this.ratePerDay,
      daysQuantity: daysQuantity ?? this.daysQuantity,
      comment: comment ?? this.comment,
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
    if (employeeId != null) {
      result.addAll({'employeeId': employeeId});
    }
    if (employee != null) {
      result.addAll({'employee': employee!.toMap()});
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
    if (rentDate != null) {
      result.addAll({'rentDate': ViewUtils.formatDate(rentDate!)});
    }
    if (returnDate != null) {
      result.addAll({'returnDate': ViewUtils.formatDate(returnDate!)});
    }
    if (returned != null) {
      result.addAll({'returned': returned});
    }
    if (ratePerDay != null) {
      result.addAll({'ratePerDay': ratePerDay});
    }
    if (daysQuantity != null) {
      result.addAll({'daysQuantity': daysQuantity});
    }
    if (comment != null) {
      result.addAll({'comment': comment});
    }

    return result;
  }

  factory Rent.fromMap(Map<String, dynamic> map) {
    return Rent(
      id: map['id']?.toInt(),
      status: map['status'],
      employeeId: map['employeeId']?.toInt(),
      employee:
          map['employee'] != null ? Employee.fromMap(map['employee']) : null,
      vehicleId: map['vehicleId']?.toInt(),
      vehicle: map['vehicle'] != null ? Vehicle.fromMap(map['vehicle']) : null,
      clientId: map['clientId']?.toInt(),
      client: map['client'] != null ? Client.fromMap(map['client']) : null,
      rentDate:
          map['rentDate'] != null ? DateTime.parse(map['rentDate']) : null,
      returnDate:
          map['returnDate'] != null ? DateTime.parse(map['returnDate']) : null,
      returned: map['returned'],
      ratePerDay: map['ratePerDay']?.toDouble(),
      daysQuantity: map['daysQuantity']?.toInt(),
      comment: map['comment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Rent.fromJson(String source) => Rent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Rent(id: $id, status: $status, employeeId: $employeeId, employee: $employee, vehicleId: $vehicleId, vehicle: $vehicle, clientId: $clientId, client: $client, rentDate: $rentDate, returnDate: $returnDate, returned: $returned, ratePerDay: $ratePerDay, daysQuantity: $daysQuantity, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rent &&
        other.id == id &&
        other.status == status &&
        other.employeeId == employeeId &&
        other.employee == employee &&
        other.vehicleId == vehicleId &&
        other.vehicle == vehicle &&
        other.clientId == clientId &&
        other.client == client &&
        other.rentDate == rentDate &&
        other.returnDate == returnDate &&
        other.returned == returned &&
        other.ratePerDay == ratePerDay &&
        other.daysQuantity == daysQuantity &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        employeeId.hashCode ^
        employee.hashCode ^
        vehicleId.hashCode ^
        vehicle.hashCode ^
        clientId.hashCode ^
        client.hashCode ^
        rentDate.hashCode ^
        returnDate.hashCode ^
        returned.hashCode ^
        ratePerDay.hashCode ^
        daysQuantity.hashCode ^
        comment.hashCode;
  }
}
