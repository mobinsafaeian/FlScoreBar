import 'package:flutter/material.dart';

class HalfClipper extends CustomClipper<Rect> {
  /// This property defines the amount of clipping to clip the icon.
  final double clip;

  const HalfClipper({required this.clip});

  /// Create a [Rect] on widget ViewPort to clip the widget
  /// based on [clip] value
  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(0, 0, size.width * clip, size.height);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
