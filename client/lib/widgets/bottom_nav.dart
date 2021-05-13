import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text("world")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), title: Text("Add")),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_rounded), title: Text("rank")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("user"))
        ],
      ),
    );
  }
}
