class CustomException implements Exception {
  final String msg;
  final String prefix;

  CustomException({required this.msg, required this.prefix});

  @override
  String toString() {
    return "$prefix$msg";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(msg: message!, prefix: "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(msg: message!, prefix: "");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message])
      : super(msg: message!, prefix: "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message])
      : super(msg: message!, prefix: "Invalid Input: ");
}

class BadResponseException extends CustomException {
  BadResponseException([String? message])
      : super(msg: message!, prefix: "Bad Response: ");
}

class APINotRespondingException extends CustomException {
  APINotRespondingException([String? message])
      : super(msg: "", prefix: "API not responded in time");
}
