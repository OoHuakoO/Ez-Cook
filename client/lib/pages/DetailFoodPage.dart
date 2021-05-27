import 'package:client/pages/home.dart';
import 'package:flutter/material.dart';

class DetailFood extends StatefulWidget {
  final Map<String, dynamic> myFoodSee, myUserSee;
  DetailFood({Key key, this.myFoodSee, this.myUserSee}) : super(key: key);
  @override
  _DetailFoodState createState() => _DetailFoodState(myFoodSee, myUserSee);
}

class _DetailFoodState extends State<DetailFood> {
  _DetailFoodState(this.myFoodSee, this.myUserSee);

  Map<String, dynamic> myFoodSee, myUserSee;

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
                    children: [
                      Container(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              myFoodSee['nameFood'],
                              style: TextStyle(fontSize: 23),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.timer,
                            size: 30,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${myFoodSee['timeCook']} ชม.",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
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
                        "${myUserSee['username']}",
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFFE6E1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            Container(
                                width: 90,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF04D56),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    "ส่วนผสม",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFFFFE6E1)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Container(
                                child: Text("${myFoodSee['howCook']}")),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF1AC9E),
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            Container(
                                width: 90,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFE6E1),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    "ขั้นตอน",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFFF04D56)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Container(
                                child: Text("${myFoodSee['ingredient']}")),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
