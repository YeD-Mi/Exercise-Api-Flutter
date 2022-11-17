import 'package:flutter/foundation.dart';
import '../model/exercise.dart';
import '../service/web_service.dart';

enum ExerciseState { IDLE, BUSY, ERROR }

class ExerciseViewModel with ChangeNotifier {
  ExerciseState? _state;

  List<Exercise>? exerciseList;

  ExerciseViewModel() {
    exerciseList = [];
    _state = ExerciseState.IDLE;
    fetchExercises();
  }

  ExerciseState? get state => _state;
  set state(ExerciseState? state) {
    _state = state;
    notifyListeners();
  }

  Future<List<Exercise>?> fetchExercises() async {
    try {
      state = ExerciseState.BUSY;
      exerciseList = await WebService().fetchExercises();
      state = ExerciseState.IDLE;
      return exerciseList;
    } catch (e) {
      state = ExerciseState.ERROR;
      return [];
    }
  }
}
