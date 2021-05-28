import 'package:client/pages/home.dart';
import 'package:flutter/material.dart';

class DetailFoodAfterCreateFood extends StatefulWidget {
  final Map<String, dynamic> myFoodSee;
  final List<dynamic> ingredient;
  final List<dynamic> howcook;
  final String username;
  final String imageProfile;
  final String imageFood;
  final String nameFood;

  DetailFoodAfterCreateFood(
      {Key key,
      this.myFoodSee,
      this.username,
      this.imageProfile,
      this.ingredient,
      this.howcook,
      this.imageFood,
      this.nameFood})
      : super(key: key);
  @override
  _DetailFoodAfterCreateFoodState createState() =>
      _DetailFoodAfterCreateFoodState(myFoodSee, username, imageProfile,
          ingredient, howcook, imageFood, nameFood);
}

class _DetailFoodAfterCreateFoodState extends State<DetailFoodAfterCreateFood> {
  _DetailFoodAfterCreateFoodState(
      this.myFoodSee,
      this.username,
      this.imageProfile,
      this.ingredient,
      this.howcook,
      this.imageFood,
      this.nameFood);

  Map<String, dynamic> myFoodSee;
  List<dynamic> ingredient;
  List<dynamic> howcook;
  List<String> howtoCook;
  String username;
  String imageProfile;
  String imageFood;
  String nameFood;

  setData() {
    // print(myFoodSee['ingredient']);

    // for (var i = 0; i < 2; i++) {
    //   print(['ingredient'][i]);
    // }
    // ingredient.addAll(myFoodSee['ingredient']);
    print(ingredient);
    setState(() {});
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  ingreadientWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ingredient.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 19, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${index + 1}. ${ingredient[index]}"),
                ],
              ),
            ));
  }

  howcookWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: howcook.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 19, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${index + 1}. ${howcook[index]}"),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF04D56),
          title: Text("Detail"),
        ),
        body: ListView(
          children: [
            Container(
              height: 250,
              child: Image.network(
                imageFood,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    width: 380,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 270,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  nameFood,
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
                                "${myFoodSee['timeCook']} นาที",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 480,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                imageProfile,
                                height: 40,
                                width: 40,
                              ),
                              Text(
                                username,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50)),
                                    child: Container(
                                      width: 130,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF04D56),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 4),
                                        child: Flexible(
                                          child: Text(
                                            "อาหารประเภท${myFoodSee['categoryFood']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 380,
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
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          "ส่วนผสม",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFFFFE6E1)),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            ingreadientWidget(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 380,
                        decoration: BoxDecoration(
                            color: Color(0xFFF1AC9E),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFFFE6E1),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Text(
                                            "ขั้นตอน",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFF04D56)),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            howcookWidget()
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
