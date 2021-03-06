import 'package:flutter/material.dart';
import 'package:flutter_drift/route/route_generator.dart';
import 'package:flutter_drift/screen/home_screen.dart';


void main (){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home:  const HomeScreen(),
    );
  }
}
