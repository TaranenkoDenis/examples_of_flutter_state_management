import 'package:base_approach/redux/actions.dart';
import 'package:base_approach/redux/app_state.dart';

AppState appReducer(AppState appState, action) {
  return AppState(
    count: counterReducer(appState.count, action),
  );
}

int counterReducer(int oldValue, dynamic action) {
  if (action is Increment) {
    return oldValue + 1;
  } else if (action is Decrement) {
    return oldValue - 1;
  }
  return oldValue;
}
