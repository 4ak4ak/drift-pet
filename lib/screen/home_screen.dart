import 'package:flutter/material.dart';
import 'package:flutter_drift/db/app_db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MyDatabase _db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db = MyDatabase();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Фитнес клубы в Алматы"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<EmployeeData>>(
        future: _db.getEmployees(),
        builder: (context, snapshot) {
          final List<EmployeeData>? employees = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          }
          if (employees != null) {
            return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return GestureDetector(
                    onDoubleTap: () {
                      Navigator.pushNamed(context, '/edit_club',
                          arguments: employee.id);
                    },
                    child: Card(
                      color: Colors.black87,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          // color: Colors.green,
                          style: BorderStyle.solid,

                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              employee.title.toString(),
                              style: const TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              employee.content.toString(),
                              style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              employee.price.toString() + " тг в месяц",
                              style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }

          return const Text("Нет данных");
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add_club');
          },
          icon: const Icon(
            Icons.add,
            color: Colors.green,
          ),
          backgroundColor: Colors.black,
          label: const Text('Добавить')),
    );
  }
}
