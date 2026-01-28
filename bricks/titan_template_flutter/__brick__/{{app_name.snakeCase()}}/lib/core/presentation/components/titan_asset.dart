import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/assets_enum.dart';
import '../../utils/responsive_utils.dart';

class TitanAsset extends StatelessWidget {
  final AssetsEnum? assetPath;

  final String? networkUrl;

  final double? width;

  final double? height;

  final Color? color;

  final BoxFit fit;

  final AlignmentGeometry alignment;

  final String? semanticsLabel;

  final AssetType _assetType;

  final BorderRadiusGeometry borderRadius;

  final Map<String, String>? httpHeaders;

  final Widget Function(BuildContext, String)? placeholder;

  final Widget Function(
    BuildContext,
    String,
  )? errorWidget;

  const TitanAsset.svg({
    required this.assetPath,
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  })  : _assetType = AssetType.svg,
        borderRadius = BorderRadius.zero,
        networkUrl = null,
        httpHeaders = null,
        placeholder = null,
        errorWidget = null;

  const TitanAsset.image({
    required this.assetPath,
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
    this.borderRadius = BorderRadius.zero,
  })  : _assetType = AssetType.image,
        networkUrl = null,
        httpHeaders = null,
        placeholder = null,
        errorWidget = null;

  const TitanAsset.network({
    required this.networkUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
    this.borderRadius = BorderRadius.zero,
    this.httpHeaders,
    this.placeholder,
    this.errorWidget,
  })  : _assetType = AssetType.network,
        assetPath = null,
        color = null;

  @override
  Widget build(BuildContext context) {
    final responsiveUtils = ResponsiveUtils();

    switch (_assetType) {
      case AssetType.svg:
        return SvgPicture.asset(
          assetPath!.path,
          width: width != null
              ? width! * responsiveUtils.getImageScale(context)
              : null,
          height: height != null
              ? height! * responsiveUtils.getImageScale(context)
              : null,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          fit: fit,
          alignment: alignment,
          semanticsLabel: semanticsLabel,
        );
      case AssetType.image:
        return ClipRRect(
          borderRadius: borderRadius,
          child: Image.asset(
            assetPath!.path,
            width: width != null
                ? width! * responsiveUtils.getImageScale(context)
                : null,
            height: height != null
                ? height! * responsiveUtils.getImageScale(context)
                : null,
            fit: fit,
            alignment: alignment,
            semanticLabel: semanticsLabel,
            color: color,
          ),
        );

      case AssetType.network:
        return ClipRRect(
          borderRadius: borderRadius,
          child: CachedNetworkImage(
            imageUrl: networkUrl!,
            width: width != null
                ? width! * responsiveUtils.getImageScale(context)
                : null,
            height: height != null
                ? height! * responsiveUtils.getImageScale(context)
                : null,
            fit: fit,
            httpHeaders: httpHeaders,
            placeholder: placeholder,
            errorWidget: errorWidget != null
                ? (context, url, error) => errorWidget!(context, url)
                : null,
          ),
        );
    }
  }
}

enum AssetType { svg, image, network }
