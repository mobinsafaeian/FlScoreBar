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

  /// onChange method to get the updated score value
  final void Function(double)? onChanged;

  /// [score] must be lower or equal than [maxScore] to make the widget work correctly.
  /// Also, [maxScore] must be between 2 and 8.
  const IconScoreBar({
    Key? key,
    required this.scoreIcon,
    required this.iconColor,
    required this.score,
    required this.maxScore,
    this.readOnly = false,
    this.onChanged,
  })  : assert(score <= maxScore, 'score must be lower or equal than maxScore'),
        assert(maxScore < 8 && maxScore > 2,
            'maxScore must be lower than 8 and greater than 2'),
        super(key: key);

  @override
  _IconScoreBarState createState() => _IconScoreBarState();
}

class _IconScoreBarState extends State<IconScoreBar> {
  /// [currentValue] is the current score value
  /// It's value will change when the user changes the score value.
  late double currentValue;

  /// Current direction(rtl/ltr)
  /// We need this property to set it to the custom clipper for clipping score icon.
  late bool isRtl;

  @override
  void initState() {
    /// Initialize current value with [widget.score]
    currentValue = widget.score;
    super.initState();
  }

  /// First of all, we create [IconScoreBar] structure with 0 to [widget.maxScore]th RatingItem
  /// with 0.3 opacity.
  /// Then, we create main score row widget based on [widget.score] value.
  /// Then, we had to put an invisible [Slider] on the score widget to update
  /// score value by user.
  @override
  Widget build(BuildContext context) {
    /// Set current direction
    isRtl = Directionality.of(context) == TextDirection.rtl;

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
                      /// Rebuild widget to change the current score value
                      /// and re-initialize the [currentValue] and score widget parts
                      setState(() {
                        currentValue = value;
                      });

                      /// call [widget.onChanged] method to notify that
                      /// the score value is updated
                      if (widget.onChanged != null) widget.onChanged!(value);
                    },
            ),
          ),
        ),
      ],
    );
  }

  /// Returns [Icon] when [index] is lower than [currentValue].
  /// Returns [Icon] wrapped in [ClipRect] with [IconClipper] CustomClipper to
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
            clipper: IconClipper(
              isRtl: isRtl,
              clip: currentValue - currentValue.toInt(),
            ),
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
