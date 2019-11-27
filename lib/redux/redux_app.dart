import 'package:base_approach/redux/actions.dart' as actions;
import 'package:base_approach/redux/app_reducer.dart';
import 'package:base_approach/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

class ReduxApp extends StatelessWidget {
  ReduxApp({Key key}) : super(key: key);

  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: [LoggingMiddleware.printer()],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IncrementPageRedux(),
      ),
    );
  }
}

class IncrementPageRedux extends StatefulWidget {
  IncrementPageRedux({Key key}) : super(key: key);

  @override
  _IncrementPageReduxState createState() => _IncrementPageReduxState();
}

class _IncrementPageReduxState extends State<IncrementPageRedux> {
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
            StoreConnector(
              converter: (Store<AppState> store) => store.state.count,
              builder: (context, int count) => Text(
                '$count',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DecrementPageRedux(),
                  ),
                );
              },
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        rebuildOnChange: false,
        converter: (Store<AppState> store) {
          return () => store.dispatch(actions.Increment());
        },
        builder: (BuildContext context, VoidCallback increase) {
          return new FloatingActionButton(
            onPressed: increase,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          );
        },
      ),
    );
  }
}

class DecrementPageRedux extends StatefulWidget {
  DecrementPageRedux({Key key}) : super(key: key);

  @override
  _DecrementPageReduxState createState() => _DecrementPageReduxState();
}

class _DecrementPageReduxState extends State<DecrementPageRedux> {
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
            StoreConnector(
              converter: (Store<AppState> store) {
                return store.state.count;
              },
              builder: (context, int count) {
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        rebuildOnChange: false,
        converter: (Store<AppState> store) {
          return () => store.dispatch(actions.Decrement());
        },
        builder: (BuildContext context, VoidCallback decrease) {
          return new FloatingActionButton(
            onPressed: decrease,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          );
        },
      ),
    );
  }
}
