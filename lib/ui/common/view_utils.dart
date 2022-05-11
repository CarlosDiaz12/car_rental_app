import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/enums/tax_payer_type.dart';
import 'package:car_rental_app/domain/enums/work_shift.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ViewUtils {
  static DataCell buildTableCell(dynamic e, {Function()? onTap}) => DataCell(
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8),
          height: 28,
          child: Text('$e'),
        ),
        onTap: onTap,
      );

  static DataCell buildActionTableCell(
          {required Widget child, required Function() onTap}) =>
      DataCell(
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8),
          height: 28,
          child: child,
        ),
        onTap: onTap,
      );

  static Widget confirmDialog(BuildContext context) => ContentDialog(
        title: Text('Desea eliminar?'),
        actions: [
          Button(
            child: Text('Eliminar'),
            onPressed: () {
              AutoRouter.of(context).pop(true);
            },
          ),
          Button(
            child: Text('Cancelar'),
            onPressed: () {
              AutoRouter.of(context).pop(false);
            },
          )
        ],
      );

  static FilteringTextInputFormatter numericInputFormatter() =>
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  static String getTaxPayerText(TaxPayerType type) {
    switch (type) {
      case TaxPayerType.PHYSICAL:
        return 'Fisica';
      case TaxPayerType.LEGAL:
        return 'Legal';
      default:
        return 'Desconocido';
    }
  }

  static String getWorkShiftText(WorkShift type) {
    switch (type) {
      case WorkShift.DAY:
        return 'Dia';
      case WorkShift.AFTERNOON:
        return 'Tarde';
      case WorkShift.NIGHT:
        return 'Nocturno';
      default:
        return 'Desconocido';
    }
  }

  static MaskTextInputFormatter getIdentificationNumberMask() =>
      MaskTextInputFormatter(
          mask: '###-#######-#', filter: {"#": RegExp(r'[0-9]')});

  // validate id number
  static bool isValidIdNumber(String str) {
    var regex = RegExp(r'^[0-9]{3}-?[0-9]{7}-?[0-9]{1}$');
    if (!regex.hasMatch(str)) {
      return false;
    }
    str = str.replaceAll(RegExp('-'), '');
    if (str.split('').every((element) => element == '0')) return false;
    return _checkDigit(str);
  }

  static bool _checkDigit(String str) {
    var sum = 0;
    for (var i = 0; i < 10; ++i) {
      var n = ((i + 1) % 2 != 0 ? 1 : 2) * int.parse(str[i]);
      sum += (n <= 9 ? n : n % 10 + 1);
    }
    var dig = ((10 - sum % 10) % 10);

    return dig == int.parse(str[10]);
  }

  static String formatDate(DateTime date) =>
      '${date.year}-${date.month < 10 ? '0' : ''}${date.month}-${date.day}';
}
