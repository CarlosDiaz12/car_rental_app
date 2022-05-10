import 'package:flutter/material.dart';

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
}
