class ImgurException implements Exception {
  final String message;
  final String exceptionType;

  ImgurException(
    this.message, {
    this.exceptionType = "ImgurException",
  });

  @override
  String toString() {
    return "$exceptionType($message)";
  }
}

class ImgurSocketException extends ImgurException {
  ImgurSocketException(String message)
      : super(message, exceptionType: "ImgurSocketException");
}

class ImgurBadRequestException extends ImgurException {
  ImgurBadRequestException(String message)
      : super(message, exceptionType: "ImgurBadRequestException");
}

class ImgurUnauthorisedException extends ImgurException {
  ImgurUnauthorisedException(String message)
      : super(message, exceptionType: "ImgurUnauthorisedException");
}

class ImgurForbiddenException extends ImgurException {
  ImgurForbiddenException(String message)
      : super(message, exceptionType: "ImgurForbiddenException");
}

class ImgurNotFoundException extends ImgurException {
  ImgurNotFoundException(String message)
      : super(message, exceptionType: "ImgurNotFoundException");
}

class ImgurServerErrorException extends ImgurException {
  ImgurServerErrorException(String message)
      : super(message, exceptionType: "ImgurServerErrorException");
}
