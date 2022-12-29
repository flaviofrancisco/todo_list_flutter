import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/shared/data/database.dart';
import 'package:todo_list/shared/todo_list_tile.dart';
import '../shared/args/todo_list_args.dart';
import '../shared/menu_bottom.dart';
import '../shared/todo_tile.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final Box<dynamic>? _box = Hive.box(DbName);
  ToDoListDb _todoListDb = ToDoListDb();
  List<String> dbKeys = [];

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Color.fromARGB(221, 0, 0, 0),
    backgroundColor: Colors.yellow.shade700,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.all(24),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
  );

  void navigateToList(int index) {
    Navigator.pushNamed(context, '/new',
        arguments: ToDoListArgs(dbKeys[index]));
  }

  @override
  void initState() {
    if (_box == null) {
      _todoListDb.initDb();
    }
    if (_box?.keys != null) {
      _box?.keys.forEach((element) {
        dbKeys.add(element);
      });
    }
    super.initState();
  }

  void deleteToDoList(int index) {
    _todoListDb.deleteData(dbKeys[index]);
    setState(() {
      dbKeys.clear();
      if (_box?.keys != null) {
        _box?.keys.forEach((element) {
          dbKeys.add(element);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO')),
      //drawer: MenuDrawer(),
      bottomNavigationBar: MenuBottom(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/main-background.jpg'),
          fit: BoxFit.cover,
        )),
        child: ListView.builder(
            itemCount: dbKeys.length,
            itemBuilder: (context, index) {
              return ToDoListTile(
                name: dbKeys[index],
                onDelete: (context) => deleteToDoList(index),
              );
            }),
      ),
    );
  }
}
