import 'package:base_approach/inherited_widget_state/counter.dart';
import 'package:flutter/material.dart';

class InheritedApp extends StatelessWidget {
  const InheritedApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IncrementPageInherited(),
      ),
    );
  }
}

class IncrementPageInherited extends StatefulWidget {
  IncrementPageInherited({Key key}) : super(key: key);

  @override
  _IncrementPageInheritedState createState() => _IncrementPageInheritedState();
}

class _IncrementPageInheritedState extends State<IncrementPageInherited> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Increment page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your current number',
            ),
            Builder(
              builder: (builderContext) => Text(
                '${CounterWidget.of(builderContext).counter}',
                style: Theme.of(builderContext).textTheme.display1,
              ),
            ),
            RaisedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DecrementPageInherited(),
                  ),
                );
              },
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: CounterWidget.of(context, rebuild: false).increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class DecrementPageInherited extends StatefulWidget {
  DecrementPageInherited({Key key}) : super(key: key);

  @override
  _DecrementPageInheritedState createState() => _DecrementPageInheritedState();
}

class _DecrementPageInheritedState extends State<DecrementPageInherited> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decrement page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your current number',
            ),
            Builder(
              builder: (builderContext) => Text(
                '${CounterWidget.of(builderContext).counter}',
                style: Theme.of(builderContext).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: CounterWidget.of(context, rebuild: false).decrement,
        tooltip: 'Decrement',
        child: Icon(Icons.remove),
      ),
    );
  }
}
