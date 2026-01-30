// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

// import 'package:database_wscube/db_helper.dart';
import 'package:database_wscube/provider.dart';
import 'package:database_wscube/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddNotePage extends StatelessWidget {
  // controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String title;
  String desc;
  int sno;
  bool isUpdate;
  // DBHelper? dbRef = DBHelper.getInstance;

  AddNotePage({
    super.key,
    this.sno = 0,
    this.title = "",
    this.desc = "",
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = title;
      descController.text = desc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Update Note ' : 'Add Note'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (_, provider, _) {
              return Switch.adaptive(
                value: provider.getValue(),
                onChanged: (newValue) {
                  provider.updateTheme(value: newValue);
                },
              );
            },
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(
              //   isUpdate ? 'Update Data' : 'Add Note',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "add title here",
                  label: Text('Title *'),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 5,
                controller: descController,
                decoration: InputDecoration(
                  hintText: 'add description here',
                  label: Text('Description *'),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.0),
                          borderRadius: BorderRadiusGeometry.circular(8.0),
                        ),
                      ),
                      onPressed: () async {
                        var title = titleController.text;
                        var desc = descController.text;
                        if (title.isNotEmpty && desc.isNotEmpty) {
                          if (isUpdate) {
                            context.read<DBProvider>().updateNote(
                              sno,
                              title,
                              desc,
                            );
                          } else {
                            context.read<DBProvider>().addNote(title, desc);
                          }
                          Navigator.pop(context);
                          // bool check = isUpdate
                          //     ? await dbRef!.updateData(
                          //         sno: sno,
                          //         title: title,
                          //         desc: desc,
                          //       )
                          //     : await dbRef!.addNote(
                          //         mtitle: title,
                          //         mdesc: desc,
                          //       );
                          // if (check) {
                          //   Navigator.pop(context);
                          // }
                        } else {
                          // errMsg = 'Please fill all fields';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill all fields')),
                          );
                        }
                      },

                      child: Text(isUpdate ? 'Update Data' : 'Add Data'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel'),
                    ),
                  ),
                ],
              ),
              // Text(errMsg),
            ],
          ),
        ),
      ),
    );
  }
}
