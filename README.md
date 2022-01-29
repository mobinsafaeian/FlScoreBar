## FlScoreBar

A simple flutter score bar that can be used in 2 states. `immutable` is the state that can be shown to the user.
And `mutable` is the state that can be changed by the user action.

## Usage

First of all, you must add the package to your `pubspec.yaml`:

```yaml
fl_score_bar: ^0.2.2
```

or enter this in your command line: 

```yaml
flutter pub add fl_score_bar
```


## Sample

![fl_score_bar](https://github.com/mobinsafaeian/FlScoreBar/blob/master/fl_score_bar.gif)

## FlScoreBar

FlScoreBar can be added to your widget tree like this:

```dart
  //immutable
  FlScoreBar( 
    title: 'score',
    maxScore: 5,
    score: 4.3,
    averageScoreColor: Colors.yellow,
    highScoreColor: Colors.green,
    lowScoreColor: Colors.red,
    textStyle: TextStyle(color: Colors.black),
  );
```

or 

```dart
  //mutable
  FlScoreBar.editable(
    title: 'score',
    maxScore: 5,
    score: 4.3,
    averageScoreColor: Colors.yellow,
    highScoreColor: Colors.green,
    lowScoreColor: Colors.red,
    textStyle: const TextStyle(color: Colors.black),
    onChanged: (value) {
      print('FlScoreBar updated value -> $value');
    },
   )
```

## IconScoreBar

IconScoreBar can be added to your widget tree like this:

```dart
  IconScoreBar(
    scoreIcon: Icons.star,
    iconColor: Colors.amber,
    score: 2.6,
    maxScore: 5,
    readOnly: false,
    onChanged: (value) {
      print('IconScoreBar updated value -> $value');
    },
   )
```

