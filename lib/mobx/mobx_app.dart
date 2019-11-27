import 'package:base_approach/mobx/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final counterMobx = CounterStore();

class MobxApp extends StatelessWidget {
  const MobxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IncrementPageProvider(),
    );
  }
}

class IncrementPageProvider extends StatefulWidget {
  IncrementPageProvider({Key key}) : super(key: key);

  @override
  _IncrementPageProviderState createState() => _IncrementPageProviderState();
}

class _IncrementPageProviderState extends State<IncrementPageProvider> {
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
            Observer(
              builder: (context) {
                return Text(
                  '${counterMobx.counter}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
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
        onPressed: counterMobx.increment,
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
            Observer(
              builder: (context) {
                return Text(
                  '${counterMobx.counter}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterMobx.decrement,
        tooltip: 'Decrement',
        child: Icon(Icons.remove),
      ),
    );
  }
}
