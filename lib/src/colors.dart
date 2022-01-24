import 'package:flutter/material.dart';

/// BaseColors used when user doesn't define any color for FlScoreBar
class BaseColors {
  // This color used when the score is more than 80 percent of maxScore
  static const Color highScoreColor = Color(0xFF359138);
  // This color used when the score is between 60 and 80 percent of maxScore
  static const Color averageScoreColor = Color(0xFF40AF44);
  // This color used when the score is lower than 60 percent of maxScore
  static const Color lowScoreColor = Color(0xFFFF9D00);
}
