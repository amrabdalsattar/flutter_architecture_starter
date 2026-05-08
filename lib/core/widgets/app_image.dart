import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../helpers/log_helper.dart';
import '../services/user_service/user_service.dart';

class AppImage extends StatelessWidget {
  final ImageParams params;
  AppImage(
    String path, {
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    Widget? errorWidget,
    super.key,
  }) : params = ImageParams(
         path,
         width: width,
         errorWidget: errorWidget,
         height: height,
         fit: fit,
         color: color,
       );

  const AppImage.fromImageParams(this.params, {super.key});

  String get path => params.path;

  bool get isNetwork => path.startsWith('http');
  bool get isSvg => path.endsWith('.svg');
  bool get isLottie => path.endsWith('.json');

  @override
  Widget build(BuildContext context) {
    if (params.path.isEmpty) return const SizedBox.shrink();

    if (isLottie && isNetwork) return _AppLottie.network(params);
    if (isLottie) return _AppLottie.asset(params);

    if (isSvg && isNetwork) return _SvgImage.network(params);
    if (isSvg) return _SvgImage.asset(params);

    if (isNetwork) return _NetworkImage(params);
    return _AssetImage(params);
  }
}

class _AppLottie extends StatelessWidget {
  final bool isAsset;
  final ImageParams params;

  const _AppLottie.asset(this.params) : isAsset = true;
  const _AppLottie.network(this.params) : isAsset = false;

  @override
  Widget build(BuildContext context) {
    if (isAsset) {
      return Lottie.asset(
        params.path,
        fit: params.fit,
        width: params.width,
        height: params.height,
        addRepaintBoundary: true,
        frameRate: FrameRate.composition,
      );
    } else {
      return Lottie.network(
        params.path,
        fit: params.fit,
        width: params.width,
        height: params.height,
        addRepaintBoundary: true,
        frameRate: FrameRate.composition,
        headers: UserService.getHeaders(),
      );
    }
  }
}

class _SvgImage extends StatelessWidget {
  final ImageParams params;
  final bool _isAsset;
  const _SvgImage.asset(this.params) : _isAsset = true;
  const _SvgImage.network(this.params) : _isAsset = false;

  @override
  Widget build(BuildContext context) {
    if (_isAsset) {
      return SvgPicture.asset(
        params.path,
        fit: params.fit ?? BoxFit.contain,
        width: params.width,
        height: params.height,
        // ignore:  deprecated_member_use
        color: params.color,
      );
    }

    return SvgPicture.network(
      params.path,
      fit: params.fit ?? BoxFit.contain,
      width: params.width,
      height: params.height,
      // ignore:  deprecated_member_use
      color: params.color,
      headers: UserService.getHeaders(),
    );
  }
}

class _AssetImage extends StatelessWidget {
  final ImageParams params;
  const _AssetImage(this.params);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      params.path,
      width: params.width,
      height: params.height,
      fit: params.fit,
      color: params.color,
    );
  }
}

class _NetworkImage extends StatelessWidget {
  final ImageParams params;
  const _NetworkImage(this.params);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: params.path,
      fit: params.fit,
      width: params.width,
      height: params.height,
      errorWidget: (context, url, error) {
        LogHelper.logError('error loading image: $url, error: $error');
        return params.errorWidget ?? const Icon(Icons.error);
      },
      httpHeaders: UserService.getHeaders(),
      fadeInDuration: Duration.zero,
    );
  }
}

class ImageParams {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Widget? errorWidget;

  const ImageParams(
    this.path, {
    this.errorWidget,
    this.width,
    this.height,
    this.fit,
    this.color,
  });

  ImageParams copyWithPath(String path) {
    return ImageParams(
      path,
      width: width,
      errorWidget: errorWidget,
      height: height,
      fit: fit,
      color: color,
    );
  }
}
