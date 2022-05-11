import 'dart:convert';

import 'package:car_rental_app/domain/enums/tax_payer_type.dart';

class Client {
  int? id;
  bool? status;
  String? name;
  String? identificationCard;
  String? creditCardNumber;
  TaxPayerType? taxPayerType;
  double? creditLimit;
  Client({
    this.id,
    this.status,
    this.name,
    this.identificationCard,
    this.creditCardNumber,
    this.taxPayerType,
    this.creditLimit,
  });

  Client copyWith({
    int? id,
    bool? status,
    String? name,
    String? identificationCard,
    String? creditCardNumber,
    TaxPayerType? taxPayerType,
    double? creditLimit,
  }) {
    return Client(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      identificationCard: identificationCard ?? this.identificationCard,
      creditCardNumber: creditCardNumber ?? this.creditCardNumber,
      taxPayerType: taxPayerType ?? this.taxPayerType,
      creditLimit: creditLimit ?? this.creditLimit,
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
    if (identificationCard != null) {
      result.addAll({'identificationCard': identificationCard});
    }
    if (creditCardNumber != null) {
      result.addAll({'creditCardNumber': creditCardNumber});
    }
    if (taxPayerType != null) {
      result.addAll({'taxPayerType': taxPayerType!.index});
    }
    if (creditLimit != null) {
      result.addAll({'creditLimit': creditLimit});
    }

    return result;
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id']?.toInt(),
      status: map['status'],
      name: map['name'],
      identificationCard: map['identificationCard'],
      creditCardNumber: map['creditCardNumber'],
      taxPayerType: map['taxPayerType'] != null
          ? TaxPayerType.values[map['taxPayerType']]
          : null,
      creditLimit: map['creditLimit']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) => Client.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Client(id: $id, status: $status, name: $name, identificationCard: $identificationCard, creditCardNumber: $creditCardNumber, taxPayerType: $taxPayerType, creditLimit: $creditLimit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Client &&
        other.id == id &&
        other.status == status &&
        other.name == name &&
        other.identificationCard == identificationCard &&
        other.creditCardNumber == creditCardNumber &&
        other.taxPayerType == taxPayerType &&
        other.creditLimit == creditLimit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        name.hashCode ^
        identificationCard.hashCode ^
        creditCardNumber.hashCode ^
        taxPayerType.hashCode ^
        creditLimit.hashCode;
  }
}
