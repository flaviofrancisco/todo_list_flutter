import 'package:flutter/material.dart';

import 'args/todo_list_args.dart';
import 'dialog_box.dart';

class MenuBottom extends StatelessWidget {
  MenuBottom({
    Key? key,
  }) : super(key: key);

  final _controller = TextEditingController();

  void onDeleteTodoList() {}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/new', arguments: ToDoListArgs(''));
            break;
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add), label: 'New ...')
      ],
    );
  }
}
