import 'dart:convert';
import './DetailFoodPage.dart';
import './detailFoodAfterCreateFood.dart';
import 'package:client/model/foods.dart';
import 'package:flutter/material.dart';
import '../function/getFood.dart';
import 'package:http/http.dart' as http;
import '../model/food.dart';

class SearchPage extends SearchDelegate<String> {
  List<Map<String, dynamic>> datas = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    // foods = [];

    // fetchFoods().then((value) => {
    //       if (query != "" || query != null)
    //         {
    //           value.forEach((element) {
    //             if (element.nameFood.startsWith(query)) {
    //               foods.add(element);
    //             }
    //           })
    //         }
    //       else
    //         {
    //           value.forEach((element) {
    //             foods.add(element);
    //           })
    //         }
    //     });

    getdata() async {
      final res = await http.get(
          Uri.parse("https://ezcooks.herokuapp.com/food?category=ทั้งหมด"));
      if (res.statusCode == 200) {
        datas = [];

        var list = (jsonDecode(res.body)).map((e) => Food.fromJson(e));

        if (query.isEmpty || query == "" || query == null) {
          for (final vv in list) {
            datas.add({
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
        } else {
          for (final v in list) {
            if (v.nameFood.startsWith(query)) {
              datas.add({
                "nameFood": v.nameFood,
                "timeCook": v.timeCook,
                "categoryFood": v.categoryFood,
                "ingredient": v.ingredient,
                "linkYoutube": v.linkYoutube,
                "howCook": v.howCook,
                "imageFood": v.imageFood,
                "like": v.like.toString(),
                "imageProfile": v.imageProfile,
                "username": v.username,
              });
            }
          }
          // datas = value
          //     .where((element) => element.nameFood.startsWith(query))
          //     .toList()
        }
      }

      // await fetchFoods().then((value) => {
      //       if (query.isEmpty || query == "" || query == null)
      //         {value.map((e) => datas.add(e)).toList()}
      //       else
      //         {
      //           datas = value
      //               .where((element) => element.nameFood.startsWith(query))
      //               .toList()
      //         }
      //     });
    }

    return FutureBuilder(
      future: getdata(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: datas.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      leading: Image.network(
                        datas[index]['imageFood'],
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailFood(
                                      myFoodSee: datas[index],
                                      username: datas[index]['username'],
                                      imageProfile: datas[index]
                                          ['imageProfile'],
                                      ingredient: datas[index]['ingredient'],
                                      howcook: datas[index]['howCook'],
                                      imageFood: datas[index]['imageFood'],
                                      nameFood: datas[index]['nameFood'],
                                    )));
                      },
                      title: Text("${datas[index]['nameFood']}"),
                      subtitle:
                          Text("เวลาในการทำ ${datas[index]['timeCook']} นาที")),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // if (datas.length > 0) {
    //   return ListView.builder(
    //     itemCount: datas.length,
    //     itemBuilder: (context, index) {
    //       return Card(
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: ListTile(
    //               leading: Image.network(datas[index].imageFood),
    //               title: Text("${datas[index].nameFood}"),
    //               subtitle: Text("เวลาในการทำ ${datas[index].timeCook} นาที")),
    //         ),
    //       );
    //     },
    //   );
    // } else {
    //   return CircularProgressIndicator();
    // }
  }
}
