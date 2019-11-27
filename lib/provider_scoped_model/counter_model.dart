import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _counter;

  int get counter => _counter;
  set counter(int newValue) {
    _counter = newValue;
    notifyListeners();
  }

  CounterModel([this._counter = 0]);
}
