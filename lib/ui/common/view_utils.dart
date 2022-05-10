import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
}
