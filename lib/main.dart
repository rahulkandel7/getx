import 'package:demo_getx/views/addCar.dart';
import 'package:flutter/material.dart';

import 'views/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        AddCar.routeName: (ctx) => AddCar(),
      },
    );
  }
}
