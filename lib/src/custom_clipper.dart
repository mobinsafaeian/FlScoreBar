import 'package:flutter/material.dart';

/// IconClipper gets clip and direction values to clip the icon widget to make the half rating item.
class IconClipper extends CustomClipper<Rect> {
  /// This property defines the amount of clipping to clip the icon.
  final double clip;

  /// This property defines the way of clipping process based on direction(rtl/ltr).
  final bool isRtl;

  const IconClipper({
    required this.clip,
    required this.isRtl,
  });

  /// Create a [Rect] on widget ViewPort to clip the widget
  /// based on [clip] value
  @override
  Rect getClip(Size size) => isRtl
      ? Rect.fromLTRB(
          size.width,
          0,
          size.width - (size.width * clip),
          size.height,
        )
      : Rect.fromLTRB(
          0,
          0,
          size.width * clip,
          size.height,
        );

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
