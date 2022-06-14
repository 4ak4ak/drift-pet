import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import '../db/app_db.dart';
import '../widget/custom_text_form_field.dart';

class EditClubScreen extends StatefulWidget {
  final int id;
  const EditClubScreen({required this.id, Key? key}) : super(key: key);
  @override
  _EditClubScreenState createState() => _EditClubScreenState();
}

class _EditClubScreenState extends State<EditClubScreen> {
  // ignore: prefer_final_fields
  TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  late MyDatabase _db;
  late EmployeeData _employeeData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db = MyDatabase();
    getEmployee();
  }

  @override
  void dispose() {
    _db.close();
    _titleController.dispose();
    _contentController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Редактировать"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                final entity = EmployeeCompanion(
                  id: drift.Value(widget.id),
                  title: drift.Value(_titleController.text),
                  content: drift.Value(_contentController.text),
                  price: drift.Value(int.parse(_priceController.text)),
                );
                _db.updateEmployee(entity).then(
                      (value) =>
                          ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                            content: const Text('Fitness club inserted'),
                            actions: [
                              TextButton(
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner(),
                                child: const Text('Close'),
                              ),
                            ]),
                      ),
                    );
              },
              icon: Icon(Icons.save),
            ),
            IconButton(
              onPressed: () {
                deleteEmployee();
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextFormField(
                  controller: _titleController, txtLable: 'Title'),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextFormField(
                  controller: _contentController, txtLable: 'Content'),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextFormField(
                  controller: _priceController, txtLable: 'Price'),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ));
  }

  Future<void> getEmployee() async {
    _employeeData = await _db.getEmployee(widget.id);
    _titleController.text = _employeeData.title;
    _contentController.text = _employeeData.content;
    _priceController.text = _employeeData.price.toString();
  }

  void deleteEmployee() {
    _db.deleteEmployee(widget.id).then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
                content: const Text('Fitness club deleted'),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                    child: const Text('Close'),
                  ),
                ]),
          ),
        );
  }
}
