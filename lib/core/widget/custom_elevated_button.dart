import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Widget? child;
  final int? index;

  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.padding,
    this.radius,
    this.child,
    this.borderColor = Colors.transparent,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(radius ?? 8),
        ),
        side: BorderSide(color: borderColor, width: 2),
      ),
      child: child,
    );
  }
}
