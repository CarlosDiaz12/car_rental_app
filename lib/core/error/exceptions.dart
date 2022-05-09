class BaseException implements Exception {
  String cause;
  BaseException(this.cause);
}

class ServerException extends BaseException {
  ServerException(String message) : super(message);
}

class LoginFailedException extends BaseException {
  LoginFailedException(String message) : super(message);
}

class NotFoundException extends BaseException {
  NotFoundException(String message) : super(message);
}

class UnknownErrorException extends BaseException {
  UnknownErrorException(String message) : super(message);
}

class NotAuthorizedException extends BaseException {
  NotAuthorizedException(String message) : super(message);
}
