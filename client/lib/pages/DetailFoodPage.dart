import 'package:client/pages/home.dart';
import 'package:flutter/material.dart';

class DetailFood extends StatefulWidget {
  final Map<String, dynamic> myFoodSee;
  DetailFood({Key key, this.myFoodSee}) : super(key: key);
  @override
  _DetailFoodState createState() => _DetailFoodState(myFoodSee);
}

class _DetailFoodState extends State<DetailFood> {
  _DetailFoodState(this.myFoodSee);

  Map<String, dynamic> myFoodSee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Image.asset(
              "assets/${myFoodSee["image"]}",
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 10),
              child: Positioned(
                top: 0.3,
                left: 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFF04D56)),
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: Icon(
                              Icons.bookmark_outline,
                              size: 35,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFF04D56)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.share,
                              size: 33,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sompong",
                    style: TextStyle(fontSize: 23),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 200, top: 10),
                    child: Icon(
                      Icons.timer,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 7),
                    child: Text(
                      "2 ชม.",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(Icons.person),
                  Text(
                    "Sompong",
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child:
                      Container(child: Text("aaaaaaaaaaaaaaaaaaaaaaaaadddddd")),
                )
              ],
            )
          ],
        )
      ],
    ));
  }
}
