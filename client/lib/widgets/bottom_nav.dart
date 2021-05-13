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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "world"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "add cook"),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_rounded), label: "ranking"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "user")
        ],
      ),
    );
  }
}
