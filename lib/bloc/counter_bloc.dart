import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';

class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class CounterState {
  final int counter;

  CounterState.initState({this.counter = 0});
  CounterState.afterOperation(this.counter);
}

class CounterBloc {
  PublishSubject<CounterEvent> _eventController =
      PublishSubject<CounterEvent>();
  BehaviorSubject<CounterState> _stateController =
      BehaviorSubject<CounterState>();

  ///
  /// To be invoked to emit an event
  ///
  Function(CounterEvent) get emitEvent => _eventController.sink.add;

  ///
  /// Current/New state
  ///
  Stream<CounterState> get state => _stateController.stream;

  Stream<CounterState> _eventHandler(
      CounterEvent event, CounterState currentState) async* {
    if (event is IncrementEvent) {
      yield CounterState.afterOperation(currentState.counter + 1);
    } else if (event is DecrementEvent) {
      yield CounterState.afterOperation(currentState.counter - 1);
    }

    // For example you need to make async request to backend
    // if (event is IncrementEvent) {
    //   yield CounterState.loading()
    //   --- making request and getting response --
    //   if (response.hasError){
    //      yeild CounterState.exception(response.error);
    //   }
    //   else {
    //      yield CounterState.afterOperation(response.data);
    //   }
    // }
  }

  final CounterState initialState;

  CounterBloc({
    @required this.initialState,
  }) {
    //
    // For each received event, we invoke the [eventHandler] and
    // emit any resulting newState
    //
    _eventController.listen((CounterEvent event) {
      // get current state
      CounterState currentState = _stateController.value ?? initialState;
      // handle current state
      _eventHandler(event, currentState).forEach((CounterState newState) {
        // emit new state
        _stateController.sink.add(newState);
      });
    });
  }

  dispose() {
    _stateController.close();
    _eventController.close();
  }
}
