import 'package:base_approach/bloc/counter_bloc.dart';
import 'package:base_approach/bloc/counter_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlocApp extends StatelessWidget {
  const BlocApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<CounterBloc>(
      builder: (ctx) => CounterBloc(
        initialState: CounterState.initState(),
      ),
      dispose: (ctx, bloc) => bloc.dispose(),
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
    final bloc = Provider.of<CounterBloc>(context, listen: false);
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
            CounterBlocBuilder(
              bloc: bloc,
              builder: (builderContext, state) {
                return Text(
                  '${state.counter}',
                  style: Theme.of(builderContext).textTheme.display1,
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
        onPressed: () => bloc.emitEvent(IncrementEvent()),
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
    final bloc = Provider.of<CounterBloc>(context, listen: false);
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
            CounterBlocBuilder(
              bloc: bloc,
              builder: (builderContext, state) {
                return Text(
                  '${state.counter}',
                  style: Theme.of(builderContext).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('[DEBUG] emit event decrement.');
          return bloc.emitEvent(DecrementEvent());
        },
        tooltip: 'Decrement',
        child: Icon(Icons.remove),
      ),
    );
  }
}
