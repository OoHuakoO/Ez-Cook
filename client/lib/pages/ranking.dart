import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'package:client/model/food.dart';

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];
  var foodData;
  List<Map<String, dynamic>> food = [];
  getRanking() async {
    print("KK");
    try {
      var res = await http
          .get(Uri.parse("https://ezcooks.herokuapp.com/food/rankFood"));
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body)['data'];
        // print(jsonData);
        // foodData = jsonData.map((e) => new Food.fromJson(e));
        foodData = jsonData.map((e) => new Food.fromJson(e));
        // foodData.fromIterable(food, name: (e) => e.nameFood, timeCook: (e) => e.timeCook);
        // print(food);
        // typeOf(foodData);
        for (final listFood in foodData) {
          food.add({
            "nameFood": listFood.nameFood,
            "timeCook": listFood.timeCook,
            "categoryFood": listFood.categoryFood,
            "ingredient": listFood.ingredient,
            "linkYoutube": listFood.linkYoutube,
            "howCook": listFood.howCook,
            "imageFood": listFood.imageFood,
            "like": listFood.like.toString()
          });
        }
        // print(food);
        // }
        // print(foodData);
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getRanking();
    controller.addListener(() {
      double value = controller.offset / 119;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
    super.initState();
  }

  getPostsData(index, element) {
    // List<Map<String, dynamic>> responseList = food;
    // print(responseList);
    // List<Widget> listItems = [];
    print(element['like']);
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
          height: 80,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: Color(0xFFFFE6E1),
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    bottomLeft: Radius.circular(80)),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFF04D56),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 30, bottom: 5),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Image.network(element['imageFood']),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 2),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        Text(
                          "Sompong",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(element['nameFood']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 2),
                    child: Text(element['like']),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      child: Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFF04D56),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            "อาหารประเภท ${element['categoryFood']}",
                            style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "เมนูยอดนิยม",
                      style: TextStyle(fontSize: 18, color: Color(0xFFF04D56)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: food.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getPostsData(index, food[index]);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
