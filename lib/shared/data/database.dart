import 'package:hive_flutter/hive_flutter.dart';

const String DbName = 'TODOBOX';

class ToDoListDb {
  List _toDoList = [];
  List get ToDoList => _toDoList;
  set ToDoList(List toDoList) {
    _toDoList = ToDoList;
  }

  final _box = Hive.box(DbName);

  void initDb() {
    _toDoList = [
      ['Create a new task', false]
    ];
  }

  void fetchData(String todoListName) {
    if (_box.get(todoListName) == null) {
      _box.put(todoListName, _toDoList);
    }
    _toDoList = _box.get(todoListName);
  }

  void updateData(String todoListName) {
    _box.put(todoListName, _toDoList);
  }

  void deleteData(String todoListName) {
    _box.delete(todoListName);
  }
}
