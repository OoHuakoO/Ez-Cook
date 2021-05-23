import 'package:client/pages/DetailFoodPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  int selectedIndex = 0;
  Widget getBody() {
    var size = MediaQuery.of(context).size;

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
            itemCount: item.length,
            itemBuilder: (BuildContext context, int index) {
              var showData = item[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        Text(
                          "Sompong",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "ติดตาม",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
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
                                      builder: (context) => DetailFood(),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                  child: Image.asset(
                                    "assets/ascasc.png",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30, top: 10, bottom: 20),
                                child: Text(
                                  "ไข่ยัดไส้ + ไส้หมูสับผัด",
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
                                          "5",
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
