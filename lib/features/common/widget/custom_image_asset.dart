import 'package:flutter/material.dart';

class CustomImageAsset extends StatelessWidget {
  final String path;
  final Color? color;
  final BlendMode? colorBlendMode;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Widget? errorWidget;
  final double? opacity;
  final FilterQuality filterQuality;
  final bool matchTextDirection;

  const CustomImageAsset({
    super.key,
    required this.path,
    this.color,
    this.colorBlendMode,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.onTap,
    this.errorWidget,
    this.opacity,
    this.filterQuality = FilterQuality.low,
    this.matchTextDirection = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      path,
      color: color,
      colorBlendMode: colorBlendMode,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      filterQuality: filterQuality,
      matchTextDirection: matchTextDirection,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          SizedBox(
            width: width,
            height: height,
            child: const Icon(Icons.broken_image_outlined),
          ),
    );
    if (opacity != null) {
      image = Opacity(opacity: opacity!, child: image);
    }
    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }
    if (onTap != null) {
      image = GestureDetector(onTap: onTap, child: image);
    }
    return image;
  }
}
