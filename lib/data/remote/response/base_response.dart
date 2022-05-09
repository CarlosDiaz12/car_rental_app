import 'dart:convert';

class BaseResponse<T> {
  bool? success;
  String? errorMessage;
  BaseResponse({
    this.success,
    this.errorMessage,
  });
}
