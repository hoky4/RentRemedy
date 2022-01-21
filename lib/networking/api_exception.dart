class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, 'Unauthorized: ');
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, 'Not Found: ');
}

class ForbiddenException extends AppException {
  ForbiddenException([message]) : super(message, 'Forbidden: ');
}