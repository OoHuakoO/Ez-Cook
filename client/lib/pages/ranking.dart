import 'package:flutter/material.dart';

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  int pageIndex = 0;

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("HOME");

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Ranking'));
  }
}
