import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  final Color? color;
  final double? size;

  const SvgIcon(
    this.path, {
    this.color,
    this.size,
    Text? title,
    List<ListTile>? children,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      color: color,
      height: size,
      width: size,
    );
  }
}
