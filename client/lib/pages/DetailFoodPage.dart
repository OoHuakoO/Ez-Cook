import 'package:flutter/material.dart';

class DetailFood extends StatefulWidget {
  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
}

Widget getBody() {
  return Column(
    children: [
      Container(
        child: Image.asset(
          "assets/images.jpg",
          width: double.infinity,
        ),
      )
    ],
  );
}
