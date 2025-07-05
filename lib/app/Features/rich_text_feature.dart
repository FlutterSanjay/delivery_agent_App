import 'dart:ui';
import 'package:flutter/material.dart';

class RichTextFeature<T> extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final double primaryFontSize;
  final double secondaryFontSize;
  final FontWeight fontWeight;
  final T? controller;

  const RichTextFeature({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.primaryFontSize,
    required this.secondaryFontSize,
    required this.fontWeight,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: primaryText,
        style: TextStyle(color: primaryTextColor, fontSize: primaryFontSize),
        children: [
          TextSpan(
            text: secondaryText,
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: secondaryFontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
