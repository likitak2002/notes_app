import 'package:database_wscube/add_note_page.dart';
import 'package:database_wscube/db_helper.dart';
import 'package:database_wscube/provider.dart';
import 'package:database_wscube/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> allNotes = [];
  // // String errMsg = '';
  // DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialNotes();
    // dbRef = DBHelper.getInstance;
    // getNotes();
  }

  // void getNotes() async {
  //   allNotes = await dbRef!.getAllNotes();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 11),
                      Text('Settings'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: Consumer<DBProvider>(
        builder: (ctx, provider, _) {
          List<Map<String, dynamic>> allNotes = provider.getNotes();
          return ListView.builder(
            itemCount: allNotes.length,
            itemBuilder: (_, index) {
              return ListTile(
                leading: Text('${index + 1}'),
                title: Text(allNotes[index]['title']),
                subtitle: Text(allNotes[index]['desc'] ?? 'No Description'),
                trailing: SizedBox(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AddNotePage(
                                  isUpdate: true,
                                  title: allNotes[index][DBHelper.columnTitle],
                                  desc: allNotes[index][DBHelper.columnDesc],
                                  sno: allNotes[index][DBHelper.columnName],
                                );
                              },
                            ),
                          );
                          // Handle edit action
                        },
                      ),
                      InkWell(
                        child: Icon(Icons.delete, color: Colors.red),
                        onTap: () async {
                          context.read<DBProvider>().deleteNote(
                            allNotes[index][DBHelper.columnName],
                          );
                          // bool check = await dbRef!.deleteNote(allNotes[index][DBHelper.columnName]);
                          // if (check) {
                          //      getNotes();}}
                          //   );
                          //   context.read<DBProvider>().getInitialNotes();
                          // }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     titleController.clear();
          //     descController.clear();
          //     return getBottomSheetWidget();
          //   },
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
  //   return Container(
  //     width: double.infinity,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         children: [
  //           Text(
  //             isUpdate ? 'Update Data' : 'Add Note',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(height: 16),
  //           TextField(
  //             controller: titleController,
  //             decoration: InputDecoration(
  //               hintText: "add title here",
  //               label: Text('Title *'),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 16),
  //           TextField(
  //             maxLines: 5,
  //             controller: descController,
  //             decoration: InputDecoration(
  //               hintText: 'add description here',
  //               label: Text('Description *'),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 16),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: OutlinedButton(
  //                   style: OutlinedButton.styleFrom(
  //                     shape: RoundedRectangleBorder(
  //                       side: BorderSide(width: 2.0),
  //                       borderRadius: BorderRadiusGeometry.circular(8.0),
  //                     ),
  //                   ),
  //                   onPressed: () async {
  //                     var title = titleController.text;
  //                     var desc = descController.text;
  //                     if (title.isNotEmpty && desc.isNotEmpty) {
  //                       bool check = isUpdate
  //                           ? await dbRef!.updateData(
  //                               sno: sno,
  //                               title: title,
  //                               desc: desc,
  //                             )
  //                           : await dbRef!.addNote(mtitle: title, mdesc: desc);
  //                       if (check) {
  //                         getNotes();
  //                       }
  //                       Navigator.pop(context);
  //                     } else {
  //                       // errMsg = 'Please fill all fields';
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(content: Text('Please fill all fields')),
  //                       );
  //                     }
  //                   },

  //                   child: Text(isUpdate ? 'Update Data' : 'Add Data'),
  //                 ),
  //               ),
  //               SizedBox(width: 12),
  //               Expanded(
  //                 child: OutlinedButton(
  //                   style: OutlinedButton.styleFrom(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text('cancel'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           // Text(errMsg),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
