import 'package:flutter/material.dart';
import 'package:todo_list/shared/dialog_button.dart';

class TaskDialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  TaskDialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter a new task ...'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DialogButton(buttonLabel: 'Save', onPressed: onSave),
                  const SizedBox(
                    width: 8,
                  ),
                  DialogButton(buttonLabel: 'Cancel', onPressed: onCancel),
                ],
              )
            ],
          )),
    );
  }
}
