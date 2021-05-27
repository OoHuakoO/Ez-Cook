import 'dart:convert';
import 'package:client/model/food.dart';
import 'package:client/model/user.dart';
import 'package:client/pages/DetailFoodPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'constants.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List item = [
    "assets/ascasc.png",
    "assets/ascasc.png",
    "assets/ascasc.png",
    "assets/ascasc.png",
    "assets/ascasc.png",
    "assets/ascasc.png",
    "assets/ascasc.png",
    "assets/ascasc.png",
  ];
  var listFood;
  List<Map<String, dynamic>> food = [];
  List<Map<String, dynamic>> users = [];
  getFood() async {
    final res =
        await get(Uri.parse("https://ezcooks.herokuapp.com/food/allFood"));
    if (res.statusCode == 200) {
      var list = (jsonDecode(res.body)['food']).map((e) => Food.fromJson(e));

      for (final vv in list) {
        food.add({
          "nameFood": vv.nameFood,
          "timeCook": vv.timeCook,
          "categoryFood": vv.categoryFood,
          "ingredient": vv.ingredient,
          "linkYoutube": vv.linkYoutube,
          "howCook": vv.howCook,
          "imageFood": vv.imageFood,
          "like": vv.like.toString(),
        });
      }
      print(food);

      setState(() {});
    }
  }

  getUsers() async {
    final res =
        await get(Uri.parse("https://ezcooks.herokuapp.com/food/allFood"));
    if (res.statusCode == 200) {
      var list = (jsonDecode(res.body)['user']).map((e) => User.fromJson(e));

      for (final vv in list) {
        users.add({
          "imageProfile": vv.imageProfile,
          "username": vv.username,
        });
      }
      print("-----------------------------");
      print(users);

      setState(() {});
    }
  }

  @override
  void initState() {
    getFood();
    getUsers();
    super.initState();
    print("object");
  }

  int selectedIndex = 0;
  Widget getBody() {
    // var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(FoodK.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.5, right: 10, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: selectedIndex == index
                            ? Color(0xFFF04D56)
                            : Colors.transparent,
                        border: Border.all(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 25, top: 10, bottom: 12),
                      child: Text(
                        FoodK[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Color(0xFFF04D56),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // number of items per row
              crossAxisCount: 2,
              // vertical spacing between the items
              mainAxisSpacing: 30,
              // horizontal spacing between the items
              crossAxisSpacing: 1,
            ),
            // number of items in your list
            itemCount: food.length,
            itemBuilder: (BuildContext context, int index) {
              var myFoodAll = food[index];
              var myUser = users[index];
              // var showData = item[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            myUser['imageProfile'],
                            height: 22,
                            width: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${myUser['username']}",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          width:
                              (MediaQuery.of(context).size.width - 150) / 1.63,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailFood(
                                          myFoodSee: food[index],
                                          myUserSee: users[index]),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                  child: Image.network(
                                    myFoodAll["imageFood"],
                                    height: 110,
                                    width: 150,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30, top: 10, bottom: 20),
                                child: Text(
                                  myFoodAll["nameFood"],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 70, top: 0),
                                child: Container(
                                  width: 70,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF04D56),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.hearing,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          myFoodAll['like'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }
}
