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
  var listFood;
  String currentCategory = "ทั้งหมด";
  int selectedIndex = 0;

  List<Map<String, dynamic>> foodAll = [];
  List<Map<String, dynamic>> food = [];
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> howCookk = [];

  getFoodEx() async {
    final res =
        await get(Uri.parse("https://ezcooks.herokuapp.com/food/allFood"));
    if (res.statusCode == 200) {
      var list = (jsonDecode(res.body)['food']['howCook'])
          .map((e) => Food.fromJson(e));

      for (final vv in list) {
        howCookk.add({
          "howCook": vv.howCook,
        });
      }
      print("-------------******----------${howCookk}");
      setState(() {});
    }
  }

  getFood() async {
    final res = await get(Uri.parse(
        "https://ezcooks.herokuapp.com/food?category=" + currentCategory));
    if (res.statusCode == 200) {
      var list = (jsonDecode(res.body)).map((e) => Food.fromJson(e));

      food = [];

      for (final vv in list) {
        foodAll.add({
          "nameFood": vv.nameFood,
          "timeCook": vv.timeCook,
          "categoryFood": vv.categoryFood,
          "ingredient": vv.ingredient,
          "linkYoutube": vv.linkYoutube,
          "howCook": vv.howCook,
          "imageFood": vv.imageFood,
          "like": vv.like.toString(),
          "imageProfile": vv.imageProfile,
          "username": vv.username,
        });
      }
      food = List.castFrom(foodAll);
      setState(() {});
    }
  }

  onSelectCategory(index) {
    selectedIndex = index;
    currentCategory = FoodK[index];
    food = [];

    if (currentCategory != "ทั้งหมด") {
      for (var i = 0; i < foodAll.length; i++) {
        if (foodAll[i]['categoryFood'] == currentCategory) {
          food.add(foodAll[i]);
          setState(() {});
        }
      }
    } else {
      food = List.castFrom(foodAll);
      setState(() {});
    }
  }

  @override
  void initState() {
    getFood();
    super.initState();
  }

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
              if (index < 1) {
                return GestureDetector(
                  onTap: () => onSelectCategory(index),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 2.5, right: 10, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: selectedIndex == index
                              ? Color(0xFFF04D56)
                              : Colors.grey.shade200,
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 25, top: 10, bottom: 12),
                        child: Text(
                          "${FoodK[index]}",
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
              }

              return GestureDetector(
                onTap: () => onSelectCategory(index),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.5, right: 10, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: selectedIndex == index
                            ? Color(0xFFF04D56)
                            : Colors.grey.shade200,
                        border: Border.all(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 25, top: 10, bottom: 12),
                      child: Text(
                        "${FoodK[index]}",
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
              mainAxisSpacing: 3,
              // horizontal spacing between the items
              crossAxisSpacing: 0,
            ),
            // number of items in your list
            itemCount: food.length,
            itemBuilder: (BuildContext context, int index) {
              var myFoodAll = food[index];

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            myFoodAll['imageProfile'],
                            height: 22,
                            width: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Flexible(
                            child: Text(
                              "${myFoodAll['username']}",
                            ),
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
                              (MediaQuery.of(context).size.width - 120) / 1.7,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E1),
                            borderRadius: BorderRadius.circular(18),
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
                                            username: food[index]['username'],
                                            imageProfile: food[index]
                                                ['imageProfile'],
                                            ingredient: food[index]
                                                ['ingredient'],
                                            howcook: food[index]['howCook'],
                                            imageFood: food[index]['imageFood'],
                                            nameFood: food[index]['nameFood'])),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18)),
                                  child: Image.network(myFoodAll["imageFood"],
                                      height: 100,
                                      width: 170,
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30, top: 10, bottom: 7),
                                child: Flexible(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            myFoodAll["nameFood"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 7, right: 70, top: 0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 18,
                                          color: Color(0xFFF04D56),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          myFoodAll['like'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFFF04D56)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
