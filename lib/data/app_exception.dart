class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication: ');
  
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}

class ForbiddenException extends AppException {
  ForbiddenException([String? message]) : super(message, 'Access Forbidden: ');
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, 'Resource Not Found: ');
}

class InternalServerException extends AppException {
  InternalServerException([String? message])
      : super(message, 'Internal Server Error: ');
}

class TimeoutException extends AppException {
  TimeoutException([String? message]) : super(message, 'Request Timed Out: ');
}

class ConflictException extends AppException {
  ConflictException([String? message]) : super(message, 'Conflict Occurred: ');
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException([String? message]) : super(message, 'Service Unavailable: ');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message,'Server error');
}
