## FlScoreBar

A simple flutter score bar that can be used in 2 states. `immutable` is the state that can be shown to the user.
And `mutable` is the state that can be changed by the user action.

## Usage

First of all, you must add the package to your `pubspec.yaml`:

```fl_score_bar: ^0.0.1```

or enter this in your command line: 

```flutter pub add fl_score_bar```


## Sample

FlScoreBar can be added to your widget tree like this:

```
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

```
  //mutable
  FlScoreBar.editable( 
    title: 'score',
    maxScore: 5,
    score: 4.3,
    averageScoreColor: Colors.yellow,
    highScoreColor: Colors.green,
    lowScoreColor: Colors.red,
    textStyle: TextStyle(color: Colors.black),
  );
```


