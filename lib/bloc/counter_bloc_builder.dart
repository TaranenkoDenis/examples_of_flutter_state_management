import 'package:base_approach/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

typedef Widget AsyncBlocBuilder(BuildContext context, CounterState state);

class CounterBlocBuilder extends StatelessWidget {
  const CounterBlocBuilder({
    Key key,
    @required this.builder,
    @required this.bloc,
  })  : assert(builder != null),
        assert(bloc != null),
        super(key: key);

  final CounterBloc bloc;
  final AsyncBlocBuilder builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CounterState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<CounterState> snapshot) {
        return builder(context, snapshot.data);
      },
    );
  }
}
