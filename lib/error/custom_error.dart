import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

import 'exception/generic_exception.dart';
import 'exception/server_error.dart';

///
/// 使用例
///
class CustomApiException extends ServerError {
  CustomApiException._({
    required ErrorCode errorCode,
    required int statusCode,
  }) : super(error: errorCode, statusCode: statusCode);

  factory CustomApiException.fromDioError(DioError error) {
    final response = error.response;
    if (response != null) {
      final statusCode = response.statusCode ?? 500;
      final data = response.data;
      final errorCode = ServerErrorCodeFactory.create(
        CustomApiErrorCode.fromResponseCode,
        data['result_code'],
      );

      return CustomApiException._(
        errorCode: errorCode,
        statusCode: statusCode,
      );
    }

    return CustomApiException._(
      errorCode: CustomApiErrorCode.internalServerError,
      statusCode: 500,
    );
  }
}

///
/// カスタムAPI異常系エラーコード
///
enum CustomApiErrorCode implements ErrorCode {
  invalidRequest('CE000001', 'エラー', 'エラーが発生しました。しばらくしてもう一度お試しください。'),
  internalServerError('CE000002', 'エラー', 'エラーが発生しました。しばらくしてもう一度お試しください。'),
  failedToFetch('CE000003', 'エラー', 'エラーが発生しました。しばらくしてもう一度お試しください。'),
  ;

  const CustomApiErrorCode(
    this._errorCode,
    this._errorTitle,
    this._errorMessage,
  );

  static CustomApiErrorCode? fromResponseCode(String? errorCode) {
    return values.firstWhereOrNull((element) => element.errorCode == errorCode);
  }

  final String _errorCode;

  final String _errorTitle;

  final String _errorMessage;

  @override
  String get errorCode => _errorCode;

  @override
  String get errorTitle => _errorTitle;

  @override
  String get errorMessage => _errorMessage;
}
