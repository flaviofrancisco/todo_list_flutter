import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/screens/intro_screen.dart';
import 'package:todo_list/screens/todo_list_screen.dart';
import 'package:todo_list/shared/data/database.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox(DbName);
  runApp(GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routes: {
        '/': (context) => IntroScreen(),
        '/new': (context) => TodoListScreen(),
      },
      initialRoute: '/',
    );
  }
}
