import 'package:client/pages/homepage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Homepage(),
      Center(
        child: Text(
          "Home Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      Center(
        child: Text(
          "Home Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      Center(
        child: Text(
          "Home Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      Center(
        child: Text(
          "Home Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      )
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        backgroundColor: Color(0xFFF04D56),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: TextField(),
        ),
      );
    } else if (pageIndex == 1) {
      return AppBar(
        backgroundColor: Color(0xFFF04D56),
        title: Text("aaa"),
      );
    } else if (pageIndex == 2) {
      return AppBar(
        backgroundColor: Color(0xFFF04D56),
        title: Text("aaa"),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        backgroundColor: Color(0xFFF04D56),
        title: Text("aaa"),
      );
    } else if (pageIndex == 4) {
      return AppBar(
        backgroundColor: Color(0xFFF04D56),
        title: Text("aaa"),
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0 ? "house+.png" : "house.png",
      pageIndex == 1 ? "earth+.png" : "earth.png",
      pageIndex == 2 ? "add+.png" : "add.png",
      pageIndex == 3 ? "ranking+.png" : "ranking.png",
      pageIndex == 4 ? "user+.png" : "user.png",
    ];
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomItems.length, (index) {
              return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Image.asset(
                  bottomItems[index],
                  height: 40,
                  width: 40,
                ),
              );
            })),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
