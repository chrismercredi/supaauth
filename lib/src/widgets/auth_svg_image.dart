import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSVGImage extends StatelessWidget {
  final String assetName;
  final double width;

  const AuthSVGImage({
    Key? key,
    required this.assetName,
    this.width = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      package: 'supaauth',
      width: width,
    );
  }
}
