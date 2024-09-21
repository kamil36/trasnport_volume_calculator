import 'package:flutter/material.dart';
import 'package:truck_box_calculator/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truck Box Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TruckBoxCalculator(),
    );
  }
}
