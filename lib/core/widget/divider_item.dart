import 'package:flutter/material.dart';

class DividerItem extends StatelessWidget {
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final BorderRadiusGeometry? radius;

  const DividerItem({
    super.key,
    this.color,
    this.thickness,
    this.endIndent,
    this.indent,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        thickness: 2,
        color: color,
        indent: indent,
        endIndent: endIndent,
        radius: radius,
      ),
    );
  }
}
