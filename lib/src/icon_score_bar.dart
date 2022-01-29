import 'package:fl_score_bar/src/custom_clipper.dart';
import 'package:fl_score_bar/src/custom_track_shape.dart';
import 'package:flutter/material.dart';

class IconScoreBar extends StatefulWidget {
  /// IconData that used for RatingItem
  final IconData scoreIcon;

  /// RatingItem color
  final Color iconColor;

  /// Current score value
  /// initialize score value in [readOnly] mode
  final double score;

  /// Maximum score can't be greater than 8.
  /// and can't be lower than 2
  final int maxScore;

  /// If true, the user can't change the score value
  /// else, the user can define score value in [IconScoreBar]
  /// default value is false
  final bool readOnly;

  const IconScoreBar({
    Key? key,
    required this.scoreIcon,
    required this.iconColor,
    required this.score,
    required this.maxScore,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _IconScoreBarState createState() => _IconScoreBarState();
}

class _IconScoreBarState extends State<IconScoreBar> {
  /// [currentValue] is the current score value
  /// It's value will change when the user changes the score value.
  late double currentValue;

  @override
  void initState() {
    /// Initialize current value with [widget.score]
    currentValue = widget.score;
    super.initState();
  }

  /// First of all, we create [IconScoreBar] structure with 0 to [widget.maxScore]th RatingItem
  /// with 0.4 opacity.
  /// Then, we create main score row widget based on [widget.score] value.
  /// Then, we had to put an invisible [Slider] on the score widget.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
              widget.maxScore,
              (index) => Expanded(
                    child: Icon(
                      widget.scoreIcon,
                      color: widget.iconColor.withOpacity(0.3),
                      size: 48,
                    ),
                  )),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
              widget.maxScore, (index) => _buildRatingItem(index)),
        ),
        Visibility(
          maintainSize: true,
          maintainInteractivity: true,
          maintainState: true,
          maintainAnimation: true,
          maintainSemantics: true,
          visible: false,
          child: SliderTheme(
            data: SliderThemeData(trackShape: CustomTrackShape()),
            child: Slider(
              min: 0,
              max: widget.maxScore.toDouble(),
              value: currentValue,
              inactiveColor: Colors.transparent,
              activeColor: Colors.transparent,
              onChanged: widget.readOnly
                  ? null
                  : (value) {
                      setState(() {
                        currentValue = value;
                      });
                    },
            ),
          ),
        ),
      ],
    );
  }

  /// Returns [Icon] when [index] is lower than [currentValue].
  /// Returns [Icon] wrapped in [ClipRect] with [HalfClipper] CustomClipper to
  /// clip the icon.
  /// Returns [Container] when the [index] is greater than [currentValue] to
  /// show nothing.
  /// All widgets wrapped in [Expanded] because of their [Row] parent. So they
  /// stick together with the same width size.
  Widget _buildRatingItem(int index) {
    if (index < currentValue.toInt()) {
      return Expanded(
        child: Icon(
          widget.scoreIcon,
          color: widget.iconColor,
          size: 48,
        ),
      );
    } else if (index == currentValue.toInt()) {
      return Expanded(
        child: ClipRect(
            clipper: HalfClipper(clip: currentValue - currentValue.toInt()),
            child: Icon(
              widget.scoreIcon,
              color: widget.iconColor,
              size: 48,
            )),
      );
    }
    return Expanded(child: Container());
  }
}
