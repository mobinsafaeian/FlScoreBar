import 'package:fl_score_bar/src/colors.dart';
import 'package:fl_score_bar/src/custom_track_shape.dart';
import 'package:flutter/material.dart';

class FlScoreBar extends StatefulWidget {
  // title of the scoreBar (Optional)
  final String? title;
  // textStyle sets as a style of all Texts widget declared in this class (Optional)
  final TextStyle? textStyle;
  // current score (Required)
  final double score;
  // max score of the content (Optional - default value is 5)
  final int maxScore;
  // you can define custom colors to show better ui to user in different score values (Optional - default values sets in constructor)
  final Color highScoreColor;
  final Color lowScoreColor;
  final Color averageScoreColor;

  /// if true, user can edit the value
  /// else value is constant
  final bool _editable;

  /// onChange method to get the updated score value
  final void Function(double)? onChanged;

  /// This constructor sets _editable value to false and make slider immutable.
  /// [score] must be lower or equal than [maxScore] to make the widget work correctly.
  /// Also, [maxScore] must be between 2 and 8.
  const FlScoreBar({
    Key? key,
    this.title,
    required this.score,
    this.textStyle,
    this.highScoreColor = BaseColors.highScoreColor,
    this.lowScoreColor = BaseColors.lowScoreColor,
    this.averageScoreColor = BaseColors.averageScoreColor,
    this.maxScore = 5,
  })  : assert(score <= maxScore, 'score must be lower or equal than maxScore'),
        assert(maxScore < 8 && maxScore > 2,
            'maxScore must be lower than 8 and greater than 2'),
        _editable = false,
        onChanged = null,
        super(key: key);

  /// This named constructor sets _editable value to true and make slider visible to the user.
  /// [score] must be lower or equal than [maxScore] to make the widget work correctly.
  /// Also, [maxScore] must be between 2 and 8.
  const FlScoreBar.editable({
    Key? key,
    this.title,
    required this.score,
    this.textStyle,
    this.highScoreColor = BaseColors.highScoreColor,
    this.lowScoreColor = BaseColors.lowScoreColor,
    this.averageScoreColor = BaseColors.averageScoreColor,
    this.maxScore = 5,
    this.onChanged,
  })  : assert(score <= maxScore, 'score must be lower or equal than maxScore'),
        assert(maxScore < 8 && maxScore > 2,
            'maxScore must be lower than 8 and greater than 2'),
        _editable = true,
        super(key: key);

  @override
  _FlScoreBarState createState() => _FlScoreBarState();
}

class _FlScoreBarState extends State<FlScoreBar> {
  // Current score value - can be changed by slider
  late double _currentValue;

  @override
  void initState() {
    _currentValue = widget.score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get bar color based on score value
    Color barColor = _getBarColor(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null
              ? Text(
                  widget.title!,
                  style: widget.textStyle,
                )
              : Container(),
          const SizedBox(
            height: 4,
          ),
          // choose between immutable and mutable states
          widget._editable
              ? _editableScoreBarWidget(barColor) // mutable state
              : _scoreBarWidget(barColor) // immutable state
        ],
      ),
    );
  }

  /// Immutable ScoreBar widget
  Widget _scoreBarWidget(Color barColor) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          for (int i = 0; i < widget.maxScore; i++)
            i != _currentValue.toInt()
                ? Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 6,
                      decoration: BoxDecoration(
                          color: i < _currentValue.toInt()
                              ? barColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  )
                : Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex:
                              ((_currentValue - _currentValue.floorToDouble()) *
                                      10)
                                  .toInt(),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            height: 6,
                            decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                        Expanded(
                          flex: 10 -
                              ((_currentValue - _currentValue.floorToDouble()) *
                                      10)
                                  .toInt(),
                          child: const SizedBox(
                            height: 6,
                          ),
                        )
                      ],
                    ),
                  ),
          const SizedBox(
            width: 8,
          ),
          Text(
            _currentValue.toStringAsFixed(2),
            style: widget.textStyle,
          )
        ],
      );

  /// Mutable ScoreBar Widget using Flutter Slider
  /// we create main score row widget based on [widget.score] value.
  /// Then, we had to put a [Slider] on the score widget to update the score
  /// value by user.
  Widget _editableScoreBarWidget(Color barColor) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (int i = 0; i < widget.maxScore; i++)
                      i != _currentValue.toInt()
                          ? Flexible(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                height: 6,
                                decoration: BoxDecoration(
                                    color: i < _currentValue.toInt()
                                        ? barColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            )
                          : Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: ((_currentValue -
                                                _currentValue.floorToDouble()) *
                                            10)
                                        .toInt(),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: barColor,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10 -
                                        ((_currentValue -
                                                    _currentValue
                                                        .floorToDouble()) *
                                                10)
                                            .toInt(),
                                    child: const SizedBox(
                                      height: 6,
                                    ),
                                  )
                                ],
                              ),
                            ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SliderTheme(
                    data: SliderThemeData(
                        trackShape:
                            CustomTrackShape()), // Defining custom TrackShape to remove the default padding.
                    child: Slider(
                      min: 0,
                      thumbColor: barColor,
                      activeColor: Colors
                          .transparent, // TrackShape colors must be transparent to make them invisible.
                      inactiveColor: Colors
                          .transparent, // TrackShape colors must be transparent to make them invisible.
                      max: widget.maxScore.toDouble(),
                      value: _currentValue,
                      onChanged: (value) {
                        /// Rebuild widget to change the current score value
                        /// and re-initialize the colors and score widget parts (only enabled in mutable state)
                        setState(() {
                          _currentValue = value;
                        });

                        /// call [widget.onChanged] method to notify that
                        /// the score value is updated
                        if (widget.onChanged != null) widget.onChanged!(value);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            _currentValue.toStringAsFixed(2),
            style: widget.textStyle,
          )
        ],
      );

  /// Return Color code based on score value
  Color _getBarColor(BuildContext context) {
    if (_currentValue / widget.maxScore >= 0.8) {
      return widget.highScoreColor;
    } else if (_currentValue / widget.maxScore >= 0.6) {
      return widget.averageScoreColor;
    } else {
      return widget.lowScoreColor;
    }
  }
}
