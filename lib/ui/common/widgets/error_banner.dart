import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

import '../../../core/error/exceptions.dart';

class ErrorBanner extends StatelessWidget {
  final Exception exception;
  final VoidCallback? callBack;
  const ErrorBanner({
    Key? key,
    required this.exception,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var exceptionError = (exception) as BaseException;
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      child: material.MaterialBanner(
        backgroundColor: Colors.red,
        actions: <Widget>[
          TextButton(
            onPressed: callBack,
            child: Text(
              'Reintentar',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
        content: Text(
          exceptionError.cause,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
