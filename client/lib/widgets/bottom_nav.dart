import 'package:flutter/material.dart';
import '../pages/add_cook.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentindex = 0;
  final List<Widget> _children = [
    AddCook(),
    AddCook(),
    AddCook(),
    AddCook(),
    AddCook(),
  ];

  void onTappedBar(int index) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => _children[index]));
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: onTappedBar,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "world"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: "add cook"),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_rounded), label: "ranking"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "user")
        ],
      ),
    );
  }
}
