import 'package:flutter/material.dart';

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Ranking'));
  }
}
