import 'package:fl_score_bar/fl_score_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Score bar demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // immutable
          const FlScoreBar(
            title: 'score',
            maxScore: 5,
            score: 4.3,
            averageScoreColor: Colors.yellow,
            highScoreColor: Colors.green,
            lowScoreColor: Colors.red,
            textStyle: TextStyle(color: Colors.black),
          ),
          // mutable
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
          ),
          // Icon Score Bar
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
        ],
      ),
    );
  }
}
