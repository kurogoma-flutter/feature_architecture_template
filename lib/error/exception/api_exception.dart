import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_exception.freezed.dart';

@freezed
abstract class ApiException with _$ApiException {
  @Implements<Exception>()
  const factory ApiException.requestTimeout() = _RequestTimeout;
  @Implements<Exception>()
  const factory ApiException.responseError() = _ResponseError;
  @Implements<Exception>()
  const factory ApiException.sslVerificationError() = _SslVerificationError;
  @Implements<Exception>()
  const factory ApiException.requestException() = _RequestException;
  @Implements<Exception>()
  const factory ApiException.unexpectedException() = _UnexpectedException;

  factory ApiException.getApiException(exception) {
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectionError:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.connectionTimeout:
          return const ApiException.requestTimeout();
        case DioErrorType.badResponse:
          return const ApiException.responseError();
        case DioErrorType.badCertificate:
          return const ApiException.sslVerificationError();
        case DioErrorType.cancel:
        case DioErrorType.unknown:
          return exception.error is HandshakeException
              ? const ApiException.sslVerificationError()
              : const ApiException.requestException();
      }
    }
    return const ApiException.unexpectedException();
  }
}
