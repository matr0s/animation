import 'package:flutter/material.dart';
import './screens/home.dart';

// ************************************
// * Simple MeterialAPP and separate Home() widget as a home property;
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
