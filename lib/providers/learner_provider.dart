import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/learner.dart';

class LearnerManager extends StateNotifier<List<Learner>> {
  LearnerManager() : super([]);

  Learner? _lastRemovedLearner;
  int? _lastRemovedIndex;

  void addLearner(Learner learner) {
    state = [...state, learner];
  }

  void updateLearner(int index, Learner updatedLearner) {
    final updatedList = [...state];
    updatedList[index] = updatedLearner;
    state = updatedList;
  }

  void removeLearner(int index) {
    _lastRemovedLearner = state[index];
    _lastRemovedIndex = index;

    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
  }

  void undoRemove() {
    if (_lastRemovedLearner != null && _lastRemovedIndex != null) {
      final updatedList = [...state];
      updatedList.insert(_lastRemovedIndex!, _lastRemovedLearner!);

      state = updatedList;

      _lastRemovedLearner = null;
      _lastRemovedIndex = null;
    }
  }
}

final learnersProvider =
    StateNotifierProvider<LearnerManager, List<Learner>>((ref) {
  return LearnerManager();
});
