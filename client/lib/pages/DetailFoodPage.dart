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
        appBar: AppBar(
          backgroundColor: Color(0xFFF04D56),
          title: Text("Detail"),
        ),
        body: ListView(
          children: [
            Image.network(
              myFoodSee["imageFood"],
              height: 200,
              width: double.infinity,
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
                      child: Container(
                          child: Text("aaaaaaaaaaaaaaaaaaaaaaaaadddddd")),
                    )
                  ],
                )
              ],
            )
          ],
        )
        // Column(
        //   children: [
        //     Image.network(
        //       myFoodSee["imageFood"],
        //       height: 200,
        //       width: double.infinity,
        //     ),
        //     Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 "Sompong",
        //                 style: TextStyle(fontSize: 23),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.only(left: 200, top: 10),
        //                 child: Icon(
        //                   Icons.timer,
        //                   size: 30,
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.only(left: 5, top: 7),
        //                 child: Text(
        //                   "2 ชม.",
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 10),
        //           child: Row(
        //             children: [
        //               Icon(Icons.person),
        //               Text(
        //                 "Sompong",
        //               ),
        //             ],
        //           ),
        //         ),
        //         Row(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.only(left: 10, top: 10),
        //               child: Container(
        //                   child: Text("aaaaaaaaaaaaaaaaaaaaaaaaadddddd")),
        //             )
        //           ],
        //         )
        //       ],
        //     )
        //   ],
        // )
        );
  }
}