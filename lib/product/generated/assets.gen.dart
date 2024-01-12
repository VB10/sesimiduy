/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsBundleGen {
  const $AssetsBundleGen();

  /// File path: assets/bundle/cities.json
  String get cities => 'assets/bundle/cities.json';

  /// File path: assets/bundle/earthquake_cities.json
  String get earthquakeCities => 'assets/bundle/earthquake_cities.json';

  /// List of all assets
  List<String> get values => [cities, earthquakeCities];
}

class $AssetsDocsGen {
  const $AssetsDocsGen();

  /// File path: assets/docs/kvkk.pdf
  String get kvkk => 'assets/docs/kvkk.pdf';

  /// List of all assets
  List<String> get values => [kvkk];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_app_high_logo.png
  AssetGenImage get icAppHighLogo =>
      const AssetGenImage('assets/icons/ic_app_high_logo.png');

  /// File path: assets/icons/ic_app_logo.png
  AssetGenImage get icAppLogo =>
      const AssetGenImage('assets/icons/ic_app_logo.png');

  /// File path: assets/icons/ic_car_help.png
  AssetGenImage get icCarHelp =>
      const AssetGenImage('assets/icons/ic_car_help.png');

  /// File path: assets/icons/ic_map_help.png
  AssetGenImage get icMapHelp =>
      const AssetGenImage('assets/icons/ic_map_help.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [icAppHighLogo, icAppLogo, icCarHelp, icMapHelp];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/tr.json
  String get tr => 'assets/translations/tr.json';

  /// List of all assets
  List<String> get values => [ar, en, tr];
}

class Assets {
  Assets._();

  static const $AssetsBundleGen bundle = $AssetsBundleGen();
  static const $AssetsDocsGen docs = $AssetsDocsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
