import 'package:base_approach/provider_scoped_model/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterModel>(
      builder: (_) => CounterModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IncrementPageProvider(),
      ),
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
            Consumer<CounterModel>(
              builder: (builderContext, model, child) => Text(
                '${model.counter}',
                style: Theme.of(builderContext).textTheme.display1,
              ),
            ),
            RaisedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DecrementPageProvider(),
                  ),
                );
              },
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<CounterModel>(context, listen: false).counter++,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class DecrementPageProvider extends StatefulWidget {
  DecrementPageProvider({Key key}) : super(key: key);

  @override
  _DecrementPageProviderState createState() => _DecrementPageProviderState();
}

class _DecrementPageProviderState extends State<DecrementPageProvider> {
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
            Consumer<CounterModel>(
              builder: (builderContext, model, child) => Text(
                '${model.counter}',
                style: Theme.of(builderContext).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<CounterModel>(context, listen: false).counter--,
        tooltip: 'Decrement',
        child: Icon(Icons.remove),
      ),
    );
  }
}
