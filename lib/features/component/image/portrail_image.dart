import 'package:flutter/material.dart';

import 'cached_image.dart';

///
/// コンテンツ_横
/// 横長の角丸画像表示用のView
///
/// URLで指定されたサムネイル画像を角丸で表示する際に使用される想定。
/// [imageUrl]に縦長サムネイル画像のURLを指定した場合はアスペクト比を保ったまま表示領域の縦幅に合わせ縮小し余白を黒塗りにする。
///
class RoundedLandscapeImage extends StatelessWidget {
  ///
  /// 横長の角丸画像表示用のView(デフォルト)
  ///
  /// [imageUrl] : 画像のURL
  ///
  /// [onTap] : タップ時動作
  ///
  /// [height] : 画像表示表示領域の高さ
  ///
  /// [width] : 画像表示表示領域の幅
  ///
  /// [colorCode] : 余白の色
  ///
  /// [topIconList] : 左上に表示するステータスアイコン
  ///
  /// [bottomIcon] : 右下に表示するステータスアイコン
  ///
  const RoundedLandscapeImage({
    required this.imageUrl,
    this.onTap,
    this.height = _thumbnailHeight,
    this.width = _thumbnailWidth,
    this.colorCode = 0xFF111111,
    Key? key,
  }) : super(key: key);

  ///
  /// 横長の角丸画像表示用のView(幅を指定すると固定のアスペクト比に従って高さを計算する)
  ///
  /// [imageUrl] : 画像のURL
  ///
  /// [onTap] : タップ時動作
  ///
  /// [width] : 画像表示表示領域の幅
  ///
  /// [colorCode] : 余白の色
  ///
  /// [topIconList] : 左上に表示するステータスアイコン
  ///
  /// [bottomIcon] : 右下に表示するステータスアイコン
  ///
  const RoundedLandscapeImage.fromWidth({
    required this.imageUrl,
    this.onTap,
    required this.width,
    this.colorCode = 0xFF111111,
    Key? key,
  })  : height = width * _aspectRatio,
        super(key: key);

  ///
  /// 横長の角丸画像表示用のView(幅を指定すると固定のアスペクト比に従って高さを計算する)
  ///
  /// [imageUrl] : 画像のURL
  ///
  /// [onTap] : タップ時動作
  ///
  /// [width] : 画像表示表示領域の幅
  ///
  /// [colorCode] : 余白の色
  ///
  /// [topIconList] : 左上に表示するステータスアイコン
  ///
  /// [bottomIcon] : 右下に表示するステータスアイコン
  ///
  const RoundedLandscapeImage.fromWidthThumbnailAndIcon({
    required this.imageUrl,
    this.onTap,
    required this.width,
    this.colorCode = 0xFF111111,
    Key? key,
  })  : height = width * _aspectRatio,
        super(key: key);

  static const double _aspectRatio = _thumbnailHeight / _thumbnailWidth;
  static const double _thumbnailWidth = 150.0;
  static const double _thumbnailHeight = 84.0;

  /// タップ時処理
  ///
  /// タップ時処理は必須の想定では無いためnullable指定にしている
  final VoidCallback? onTap;

  /// 画像表示領域の幅
  final double width;

  /// 画像表示領域の高さ
  final double height;

  /// 画像のURL。PreLoad済の画像URLであること
  final String imageUrl;

  /// 縦長サムネイル表示時の余白のカラーコード
  final int colorCode;

  @override
  Widget build(BuildContext context) {
    final double thumbnailRatio = width / _thumbnailWidth;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0 * thumbnailRatio),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Color(colorCode),
          width: width,
          height: height,
          child: SizedBox(
            width: width,
            height: height,
            child: CachedImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
