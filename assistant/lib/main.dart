import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/exercise_view.dart';
import 'view_model/exercise_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ExerciseViewModel(),
      child: MaterialApp(
          title: 'MrYed Api',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ExerciseView()),
    );
  }
}
