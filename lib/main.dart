import 'package:flutter/material.dart';
import 'package:flutter_graphql/src/screens/contry_screen.dart';




void main() {
 // Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

