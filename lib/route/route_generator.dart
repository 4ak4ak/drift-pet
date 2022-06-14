import 'package:flutter/material.dart';
import 'package:flutter_drift/screen/edit_employee_screen.dart';
import '../screen/add_employee_screen.dart';
import '../screen/home_screen.dart';

class RouteGenerator{

  static  Route<dynamic>? generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case'/':
        return MaterialPageRoute(builder:(_) =>   HomeScreen());
      case '/add_club':
        return MaterialPageRoute(builder: (_) => AddClubScreen());
      case '/edit_club':
        if(args is int){
          return MaterialPageRoute(builder: (_) => EditClubScreen(id: args));
        }
        break;

      default:
        return _errorRoute();

    }
    return null;
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