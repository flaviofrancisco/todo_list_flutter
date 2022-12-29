import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/shared/args/todo_list_args.dart';
import 'package:todo_list/shared/data/database.dart';
import 'package:todo_list/shared/todo_tile.dart';

import '../shared/dialog_box.dart';
import '../shared/menu_bottom.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

const String _NEW = 'blank';

class _TodoListScreenState extends State<TodoListScreen> {
  String _title = _NEW;
  final _controller = TextEditingController();
  bool _isVisible = true;
  final Box<dynamic> _box = Hive.box(DbName);
  final ToDoListDb _todoListDb = ToDoListDb();

  @override
  void initState() {
    if (_title != _NEW) {
      _todoListDb.fetchData(_title);
    }
    super.initState();
    setToDoListName(_title);
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      _todoListDb.ToDoList[index][1] = !_todoListDb.ToDoList[index][1];
    });
    _todoListDb.updateData(_title);
  }

  void onSaveNewTask() {
    setState(() {
      _todoListDb.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    _todoListDb.updateData(_title);
  }

  void setToDoListName(String name) {
    setState(() {
      _title = name;
    });
  }

  void createNewTask() {
    _controller.clear();
    showDialog(
        context: context,
        builder: (context) {
          return TaskDialogBox(
            controller: _controller,
            onSave: onSaveNewTask,
            onCancel: (() => Navigator.of(context).pop()),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      _todoListDb.ToDoList.removeAt(index);
    });
    _todoListDb.updateData(_title);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var todoListArgs =
        ModalRoute.of(context)!.settings.arguments as ToDoListArgs;

    if (todoListArgs.title != '') {
      setState(() {
        _title = todoListArgs.title;
        _isVisible = false;
      });
      _todoListDb.fetchData(todoListArgs.title);
    }

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MenuBottom(),
      body: Column(
        children: [
          Visibility(
            visible: _isVisible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                onSubmitted: (value) {
                  if (value != '') {
                    setState(() {
                      _isVisible = false;
                    });
                    _todoListDb.fetchData(value);
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _todoListDb.ToDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    taskName: _todoListDb.ToDoList[index][0],
                    isTaskCompleted: _todoListDb.ToDoList[index][1],
                    onChanged: (value) => checkBoxChanged(value, index),
                    onDelete: (context) => deleteTask(index),
                  );
                }),
          ),
        ],
      ),
      //drawer: MenuDrawer(),
    );
  }
}
