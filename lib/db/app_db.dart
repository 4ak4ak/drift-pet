

import 'dart:io';
import 'dart:ffi';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../table.dart';
part 'app_db.g.dart';

LazyDatabase _openConnection(){
  return LazyDatabase(() async{
    final  dbFolder  = await  getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'fit.sqlite' ));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Employee])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  //Get  the list of employee
  Future<List<EmployeeData>> getEmployees()async{
    return await  select(employee).get();

  }

  Future<EmployeeData>getEmployee(int  id)async{
    return await (select(employee)..where((tbl) => tbl.id.equals(id))).getSingle();

  }
  Future<bool>updateEmployee(EmployeeCompanion entity)async{
    return await update(employee).replace(entity);
  }
  Future<int>insertEmployee(EmployeeCompanion entity)async{
    return await into(employee).insert(entity);
  }
  Future<int>deleteEmployee(int id ) async{
    return await (delete(employee)..where((tbl) => tbl.id.equals(id))).go();
  }
}



