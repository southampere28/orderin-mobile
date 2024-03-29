import 'package:flutter/material.dart';

class ListtilComponent extends StatelessWidget {
  const ListtilComponent(
      {super.key,
      required this.selected,
      required this.name,
      required this.icons,
      required this.destination});

  final bool selected;
  final String name;
  final Icon icons;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                  top: BorderSide(color: Colors.grey, width: 1))),
          child: ListTile(
            leading: icons,
            selected: selected,
            selectedColor: const Color.fromARGB(255, 204, 154, 3),
            title: Text(name),
            // selected: _selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              // _onItemTapped(0);
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => destination));
            },
          ),
        ),
      ),
    );
  }
}
