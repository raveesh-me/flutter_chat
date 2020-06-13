import 'package:flutter/material.dart';

class HomeScreenBottomNavBar extends StatelessWidget {
  final ValueChanged<int> onBottomNavigationTap;
  final int currentIndex;

  const HomeScreenBottomNavBar(
      {Key key,
      @required this.onBottomNavigationTap,
      @required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          activeIcon: Icon(Icons.people),
          backgroundColor: Colors.red,
          title: Text("LIST"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          backgroundColor: Colors.amber,
          title: Text("ME"),
        ),
      ],
      onTap: onBottomNavigationTap,
      type: BottomNavigationBarType.shifting,
    );
  }
}
