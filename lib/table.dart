import 'package:drift/drift.dart';
import 'dart:ffi';
class Employee extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get content => text().named('description')();
  IntColumn get price => integer().named('price')();
}


