import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  CounterWidgetState createState() => CounterWidgetState();

  static Counter of(BuildContext context, {bool rebuild = true}) {
    return rebuild
        ? (context.inheritFromWidgetOfExactType(_MyInherited) as _MyInherited)
            .data
        : (context.ancestorWidgetOfExactType(_MyInherited) as _MyInherited)
            .data;
  }
}

abstract class Counter {
  int get counter;
  void increment();
  void decrement();
}

class CounterWidgetState extends State<CounterWidget> implements Counter {
  int _counter;
  @override
  int get counter => _counter;
  @override
  void increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  void decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  void initState() {
    _counter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new _MyInherited(
      data: this,
      child: widget.child,
    );
  }
}

class _MyInherited extends InheritedWidget {
  const _MyInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final CounterWidgetState data;

  @override
  bool updateShouldNotify(_MyInherited oldWidget) {
    return true;
  }
}
