import 'package:flutter/material.dart';
import 'package:flutter_drift/route/route_generator.dart';
import 'package:flutter_drift/screen/home_screen.dart';


void main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home:  HomeScreen(),
    );
  }
}
