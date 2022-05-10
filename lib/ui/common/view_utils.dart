import 'package:flutter/material.dart';

class ViewUtils {
  static buildTableCell(e) => TableCell(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8),
          height: 28,
          child: Text('$e'),
        ),
      );
}
