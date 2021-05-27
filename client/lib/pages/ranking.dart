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

  List<Map<String, dynamic>> foodData = [];

  var food;
  getRanking() async {
    print("KK");
    try {
      var res = await http
          .get(Uri.parse("https://ezcooks.herokuapp.com/food/rankFood"));
      if (res.statusCode == 200) {
        print("success");
        var jsonFood = jsonDecode(res.body)['data'];

        food = jsonFood.map((item) => new Food.fromJson(item));

        for (final listFood in food) {
          foodData.add({"nameFood": listFood.nameFood});
        }

        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getRanking();
    // getPostsData();
    super.initState();
    // controller.addListener(() {
    //   double value = controller.offset / 119;
    //   setState(() {
    //     topContainer = value;
    //     closeTopContainer = controller.offset > 50;
    //   });
    // });
  }

  void getPostsData() {
    // List<dynamic> responseList = countFood;
    // List<Widget> listItems = [];
    // responseList.forEach((post) {
    //   listItems.add(Padding(
    //     padding: const EdgeInsets.only(top: 10, bottom: 10),
    //     child: Container(
    //         height: 80,
    //         width: 30,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(70),
    //           color: Color(0xFFFFE6E1),
    //         ),
    //         child: Row(
    //           children: <Widget>[
    //             ClipRRect(
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(80),
    //                   bottomLeft: Radius.circular(80)),
    //               child: Container(
    //                 height: 100,
    //                 decoration: BoxDecoration(
    //                   color: Color(0xFFF04D56),
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(
    //                       left: 5, right: 5, top: 30, bottom: 5),
    //                   child: Text(
    //                     "00",
    //                     style: const TextStyle(
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Image.asset(
    //               "assets/${post["image"]}",
    //               height: 100,
    //             ),
    //             Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 5, top: 2),
    //                   child: Row(
    //                     children: [
    //                       Icon(Icons.person),
    //                       Text(
    //                         "Sompong",
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 2),
    //                   child: Text(post["name"]),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 20, top: 2),
    //                   child: Text("ยอดถูกใจทั้งหมด 20 ครั้ง"),
    //                 )
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 5),
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.only(
    //                         topLeft: Radius.circular(50),
    //                         topRight: Radius.circular(50),
    //                         bottomLeft: Radius.circular(50),
    //                         bottomRight: Radius.circular(50)),
    //                     child: Container(
    //                       width: 70,
    //                       height: 30,
    //                       decoration: BoxDecoration(
    //                         color: Color(0xFFF04D56),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(left: 5, top: 5),
    //                         child: Text(
    //                           "อาหารประเภท",
    //                           style: const TextStyle(
    //                               fontSize: 9,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         )),
    //   ));
    // });
    // setState(() {
    //   itemsData = listItems;
    // });
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
                      itemCount: foodData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(foodData[index]['nameFood']);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
