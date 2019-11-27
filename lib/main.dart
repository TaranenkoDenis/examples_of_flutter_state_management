import 'package:base_approach/base/base_app.dart';
import 'package:base_approach/bloc/bloc_app.dart';
import 'package:base_approach/inherited_widget_state/inherited_app.dart';
import 'package:base_approach/mobx/mobx_app.dart';
import 'package:base_approach/provider_scoped_model/provider_application.dart';
import 'package:base_approach/redux/redux_app.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BaseApp();
    // return InheritedApp();
    // return ProviderApp();
    return BlocApp();
    // return MobxApp();
    // return ReduxApp();
  }
}
