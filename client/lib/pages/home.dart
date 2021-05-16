import 'package:client/pages/homepage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("HOME");

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

  // ignore: missing_return
  Widget getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        backgroundColor: Color(0xFFF04D56),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 5,
              top: 5,
              bottom: 10,
            ),
            child: IconButton(
                iconSize: 30,
                icon: cusIcon,
                onPressed: () {
                  setState(() {
                    if (this.cusIcon.icon == Icons.search) {
                      this.cusIcon = Icon(Icons.cancel);
                      this.cusSearchBar = Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          cursorColor: Colors.white,
                          cursorHeight: 15,
                        ),
                      );
                    } else {
                      this.cusIcon = Icon(Icons.search);
                      this.cusSearchBar = Text("HOME");
                    }
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 5,
              top: 5,
              bottom: 10,
            ),
            child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.notifications),
                onPressed: () {}),
          )
        ],
        title: cusSearchBar,
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
      pageIndex == 0 ? "assets/house+.png" : "assets/house.png",
      pageIndex == 1 ? "assets/earth+.png" : "assets/earth.png",
      pageIndex == 2 ? "assets/add+.png" : "assets/add.png",
      pageIndex == 3 ? "assets/ranking+.png" : "assets/ranking.png",
      pageIndex == 4 ? "assets/user+.png" : "assets/user.png",
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
