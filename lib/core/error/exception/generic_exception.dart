///
/// # 異常系規定クラス
///
/// 基本的にはこのクラスを開発者が触る想定ではない。
/// このクラスを継承した[AppInternalError] および [ServerError] を使用すること。
///
/// ## 各種パラメータ
///
/// [errorCode] : エラーコードを定義。ErrorCodeをEnumで継承して実装すること
///
/// [info] : その他の補足情報を格納する。具象クラスにてgetterによるoverrideで利用すること
///
/// [notifyTitle] : エラータイトル
///
/// [notifyContentText] : 画面に描画するエラーメッセージを取得
///
/// ## 各種メソッド
///
/// [toString] : Loggerなどに使用する用の文字列変換メソッド
///
/// ## 使用例
///
/// *NOTE*
/// XXXExceptionクラスの具体的な実装例を以下に示す。
///
/// ``` dart
/// class AppInternalError extends GenericException {
///   AppInternalError({
///     required AppInternalErrorCode error,
///     dynamic info,
///   }) : super(error, info: info);
/// }
/// ```
///
abstract class GenericException implements Exception {
  const GenericException(this.errorCode, {this.info});

  /// 内部管理用エラーコード
  final ErrorCode errorCode;

  /// その他のエラー情報(任意項目) 利用する際は具体的な型でOverrideして使用すること
  final dynamic info;

  /// エラー表示Widgetのタイトル
  String get notifyTitle => errorCode.errorTitle;

  /// エラー表示Widgetのボディテキスト
  String get notifyContentText =>
      '${errorCode.errorMessage}（${errorCode.errorCode}）';

  /// ログに表示するときに使用する想定
  @override
  String toString() =>
      'This is $runtimeType. ErrorCode: ${errorCode.errorCode}';
}

///
/// # エラーコード抽象クラス
///
/// GenericExceptionの具体的なエラーのバリエーションを定義する
///
/// ## 各種パラメータ
///
/// [errorCode] : エラー一覧で定義されたエラーコードを定義する
///
/// [errorTitle] : エラー画面に表示されるタイトルを定義する
///
/// [errorMessage] : エラー画面に表示される文言を定義する
///
/// ## 実装例
///
/// Enumで継承して使用することを想定している。以下にErrorCodeの具象クラスの実装例を示す
///
/// ``` dart
/// enum AppInternalErrorCode implements ErrorCode {
///   failedGetLocalFile('E2001', 'エラー', 'エラーが発生しました。しばらくしてもう一度お試しください。'),
///   failedEncrypt('E2002', 'エラー', 'エラーが発生しました。しばらくしてもう一度お試しください。'),
///   failedJsonParse('E2003', 'エラー', 'エラーが発生しました。しばらくしてもう一度お試しください。'),
///   ;
///
///   const AppInternalErrorCode(
///       this._errorCode, this._errorTitle, this._errorMessage);
///
///   // サーバーエラーコードの場合の実装例
///   static AppInternalErrorCode? fromResponseCode(String? errorCode) {
///     return values.firstWhereOrNull((element) => element.errorCode == errorCode);
///   }
///
///   final String _errorCode;
///
///   final String _errorTitle;
///
///   final String _errorMessage;
///
///   @override
///   String get errorCode => _errorCode;
///
///   @override
///   String get errorTitle => _errorTitle;
///
///   @override
///   String get errorMessage => _errorMessage;
/// }
/// ```
///
abstract class ErrorCode {
  const ErrorCode();

  /// 内部エラーコード
  String get errorCode;

  /// エラータイトル
  String get errorTitle;

  /// エラーメッセージ
  String get errorMessage;
}
