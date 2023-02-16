import 'package:collection/collection.dart';

import 'generic_exception.dart';

///
/// # API異常系規定クラス
///
/// APIのエラーはこのクラスを継承して作成する
///
/// ## 各種パラメータ
///
/// [errorCode] : エラーコードを定義。ErrorCodeをEnumで継承して実装すること
///
/// [info] : その他の補足情報を格納する。具象クラスにてgetterによるoverrideで利用すること
///
/// [statusCode] : HTTP Statusを格納すること
///
/// ## 各種メソッド
///
/// [toString] : Loggerなどに使用する用の文字列変換メソッド
///
/// [notifyTitle] : エラーをViewに表示する際のタイトル
///
/// [notifyContentText] : エラーをViewに表示する際のコンテンツテキスト
///
/// ## 使用例
///
/// *NOTE*
/// XXXExceptionクラスの具体的な実装例を以下に示す。
///
/// ``` dart
/// class AuthException extends ServerError {
///   AuthException._({
///     required ErrorCode errorCode,
///     required int statusCode,
///   }) : super(error: errorCode, statusCode: statusCode);
///
///   factory AuthException.fromDioError(DioError error) {
///     final response = error.response;
///     if (response != null) {
///       final statusCode = response.statusCode ?? 500;
///       final data = response.data;
///
///       final errorCode = ServerErrorCodeFactory.create(
///         LogoutErrorCode.fromResponseCode, data['result_code']);
///
///       return AuthException._(
///         errorCode: errorCode,
///         statusCode: statusCode,
///       );
///     }
///
///     return AuthException._(
///       errorCode: LogoutErrorCode.internalServerError,
///       statusCode: 500,
///     );
///   }
/// }
/// ```
///
abstract class ServerError extends GenericException {
  ServerError({
    required ErrorCode error,
    required this.statusCode,
    dynamic info,
  }) : super(error, info: info);

  final int statusCode;
}

///
/// # API個別エラー共通エラーコード
///
/// ## 変数定義
///
/// [errorCode] : アプリ内エラーコード
///
/// [errorTitle] : エラータイトル
///
/// [errorMessage] : 画面表示用エラーメッセージ
///
enum ServerCommonErrorCode implements ErrorCode {
  systemError(
    'E0000001',
    'エラー',
    'エラーが発生しました。しばらくしてもう一度お試しください。\n\n何度か試しても改善しない場合はアプリを再起動してください。',
  ),
  expiredError('E0000002', 'エラー', '長時間ご利用がなかったため、ログアウトします。再度ログインしてください。'),
  overseasError('E0000003', 'エラー', '本サービスは日本国内でのみご利用いただけます。'),
  highLoadError('E0000004', 'エラー', 'エラーが発生しました。しばらくしてもう一度お試しください。');

  const ServerCommonErrorCode(
    this._errorCode,
    this._errorTitle,
    this._errorMessage,
  );

  static ServerCommonErrorCode? fromCode(String errorCode) =>
      values.firstWhereOrNull((element) => element.errorCode == errorCode);

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

///
/// # アプリ内未定義サーバーエラーコード
///
/// ## 変数定義
///
/// [errorCode] : サーバー定義エラーコード
///
/// [errorTitle] : エラータイトル
///
/// [errorMessage] : 画面表示用エラーメッセージ
///
/// ## エラー時の挙動の仕様
///
/// 本エラーコードを検知した場合はエラーダイアログ上で以下の動作を行う
///
/// - 「OK」ボタンを表示。アクション：OKを押下するとモーダルを閉じる
///
/// 参考：https://docomo-common.atlassian.net/browse/OWL-9799?focusedCommentId=590215
///
class UnknownServerErrorCode implements ErrorCode {
  const UnknownServerErrorCode(this._serverErrorCode);

  final String? _serverErrorCode;

  @override
  String get errorCode => _serverErrorCode ?? 'E2999';

  @override
  String get errorTitle => 'エラー';

  @override
  String get errorMessage =>
      'エラーが発生しました。しばらくしてもう一度お試しください。改善しない場合はアプリを再起動してください。';
}

typedef CodeFactory = ErrorCode? Function(String errorCode);

// ignore: avoid_classes_with_only_static_members
///
/// # サーバーエラーコード作成Factory
///
/// 本クラスを用いることで
///   - サーバー共通エラー
///   - アプリ内定義エラー
///   - アプリ内未定義エラー
/// のErrorCodeを自動的に判定し、生成することが可能となる。
///
/// ## 使用例
///
/// ``` dart
/// if (response != null) {
///   final statusCode = response.statusCode ?? 500;
///   final data = response.data;
///
///   final errorCode = ServerErrorCodeFactory.create(
///     AuthDaccountUserinfoErrorCode.fromResponseCode, data['result_code']);
///
///   return AuthDaccountUserinfoException._(
///     errorCode: errorCode,
///     statusCode: statusCode,
///   );
/// }
/// ```
///
class ServerErrorCodeFactory {
  static ErrorCode create(CodeFactory factory, String? errorCode) {
    if (errorCode == null) {
      return UnknownServerErrorCode(errorCode);
    }

    return factory(errorCode) ??
        ServerCommonErrorCode.fromCode(errorCode) ??
        UnknownServerErrorCode(errorCode);
  }
}
