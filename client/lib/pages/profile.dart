import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
          child: SizedBox(
            height: 150,
            width: 150,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/profilenadate.jpeg"),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          "Sompong",
          style: TextStyle(fontSize: 20),
        ),
      ),
      Row(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 0, top: 20, bottom: 30),
              child: Text(
                "สูตรอาหารของฉัน",
                style: TextStyle(fontSize: 18, color: Color(0xFFF04D56)),
              ),
            ),
          ),
        ],
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
            // var showData = item[index];
            return Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 150) / 1.63,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            InkWell(
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
                              padding: const EdgeInsets.only(right: 70, top: 0),
                              child: Container(
                                width: 70,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF04D56),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.hearing,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "5",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
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
    ]));
  }
}
