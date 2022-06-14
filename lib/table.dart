import 'package:drift/drift.dart';

class FitClub extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get content => text().named('description')();
  IntColumn get price => integer().named('price')();
}


