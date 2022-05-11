import 'dart:convert';

import 'package:car_rental_app/domain/enums/work_shift.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';

class Employee {
  int? id;
  bool? status;
  String? name;
  String? idCard;
  DateTime? hireDate;
  double? comissionPercentage;
  WorkShift? workShift;
  Employee({
    this.id,
    this.status,
    this.name,
    this.idCard,
    this.hireDate,
    this.comissionPercentage,
    this.workShift,
  });

  Employee copyWith({
    int? id,
    bool? status,
    String? name,
    String? idCard,
    DateTime? hireDate,
    double? comissionPercentage,
    WorkShift? workShift,
  }) {
    return Employee(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      idCard: idCard ?? this.idCard,
      hireDate: hireDate ?? this.hireDate,
      comissionPercentage: comissionPercentage ?? this.comissionPercentage,
      workShift: workShift ?? this.workShift,
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
    if (name != null) {
      result.addAll({'name': name});
    }
    if (idCard != null) {
      result.addAll({'idCard': idCard});
    }
    if (hireDate != null) {
      result.addAll({'hireDate': ViewUtils.formatDate(hireDate!)});
    }
    if (comissionPercentage != null) {
      result.addAll({'comissionPercentage': comissionPercentage});
    }
    if (workShift != null) {
      result.addAll({'workShift': workShift!.index});
    }

    return result;
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id']?.toInt(),
      status: map['status'],
      name: map['name'],
      idCard: map['idCard'],
      hireDate:
          map['hireDate'] != null ? DateTime.parse(map['hireDate']) : null,
      comissionPercentage: map['comissionPercentage']?.toDouble(),
      workShift:
          map['workShift'] != null ? WorkShift.values[map['workShift']] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(id: $id, status: $status, name: $name, idCard: $idCard, hireDate: $hireDate, comissionPercentage: $comissionPercentage, workShift: $workShift)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.id == id &&
        other.status == status &&
        other.name == name &&
        other.idCard == idCard &&
        other.hireDate == hireDate &&
        other.comissionPercentage == comissionPercentage &&
        other.workShift == workShift;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        name.hashCode ^
        idCard.hashCode ^
        hireDate.hashCode ^
        comissionPercentage.hashCode ^
        workShift.hashCode;
  }
}
