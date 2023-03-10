import 'package:flutter/material.dart';
import '../screens/intro_screen.dart';
import '../screens/todo_list_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = ['Home', 'Weather', 'New To do List ...'];
    List<Widget> menuItems = [];
    menuItems.add(DrawerHeader(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text(
        'TODO',
        style: TextStyle(color: Colors.white, fontSize: 28),
      ),
    ));
    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(
          element,
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          switch(element) {
            case 'Home': { screen = IntroScreen(); }
            break;
            case 'New To do List ...': { screen = TodoListScreen(); }
            break;   
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen)
          );
        },
      ));
    });
    return menuItems;
  }
}
