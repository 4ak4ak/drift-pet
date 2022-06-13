import 'package:flutter/material.dart';

import '../screen/add_employee_screen.dart';
import '../screen/home_screen.dart';


class RouteGenerator{
  static  Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case'/':
        return MaterialPageRoute(builder:(_) =>   HomeScreen());
      case '/add_club':
        return MaterialPageRoute(builder: (_) => AddClubScreen());
      default:
        return _errorRoute();

    }
  }
  static Route<dynamic>_errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar:  AppBar(
          title:  const Text("No route"),
          centerTitle: true,
        ),
        body:  const Center(
          child: Text("Sorry no route was found ", style: TextStyle(color: Colors.red, fontSize:  18.0),),
        ),
      );
    });
  }
}