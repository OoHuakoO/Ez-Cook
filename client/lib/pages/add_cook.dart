import 'package:flutter/material.dart';

class AddCook extends StatefulWidget {
  @override
  _AddCookState createState() => _AddCookState();
}

class _AddCookState extends State<AddCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('เพิ่มสูตรอาหาร'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ชื่อเมนูอาหาร',
                ),
              ),
            ],
          ),
        ));
  }
}
