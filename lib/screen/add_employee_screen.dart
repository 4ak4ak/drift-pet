import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import '../db/app_db.dart';
import '../widget/custom_text_form_field.dart';

class AddClubScreen extends StatefulWidget {
  @override
  _AddClubScreenState createState() => _AddClubScreenState();
}

class _AddClubScreenState extends State<AddClubScreen> {
  // ignore: prefer_final_fields
  TextEditingController _titleController =  TextEditingController();
  TextEditingController _contentConroller =  TextEditingController();
  TextEditingController _priceController =  TextEditingController();
  late MyDatabase _db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db = MyDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const  Text("Add fitness club"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: (){
            final entity  = EmployeeCompanion(
              title: drift.Value(_titleController.text),
              content: drift.Value(_contentConroller.text),
              price: drift.Value (int.parse(_priceController.text)),
            );
            _db.insertEmployee(entity).then((value) => ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                content: Text('New fitness club inserted'),
                actions: [
                  TextButton(onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  child:  const Text('Close'),
                  ),
                ]

            ),
            ),);
          },
          icon: Icon(Icons.save),)
      ],

    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextFormField(controller: _titleController,txtLable: 'Title'),
          const  SizedBox(height: 8.0,),
          CustomTextFormField(controller: _contentConroller,txtLable: 'Content'),
          const  SizedBox(height: 8.0,),
          CustomTextFormField(controller: _priceController,txtLable: 'Price'),
          const  SizedBox(height: 8.0,),
        ],
      ),
    )
    );
  }

}


