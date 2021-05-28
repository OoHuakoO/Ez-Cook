import 'package:client/pages/edit_cook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  final profileList = FirebaseFirestore.instance
      .collection("User")
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid);
  final getFood = FirebaseFirestore.instance
      .collection("Food")
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
            stream: profileList.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("okdude1");
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                          backgroundImage: snapshot.data.docs[0]
                                      ["imageProfile"] !=
                                  ""
                              ? NetworkImage(
                                  "${snapshot.data.docs[0]["imageProfile"]}")
                              : null),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    "${snapshot.data.docs[0]["username"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 0, top: 20, bottom: 25),
                        child: Text(
                          "สูตรอาหารของฉัน",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFF04D56)),
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                    stream: getFood.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        print("okdude");
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            // number of items per row
                            crossAxisCount: 2,
                            // vertical spacing between the items
                            mainAxisSpacing: 3,
                            // horizontal spacing between the items
                            crossAxisSpacing: 1,
                          ),

                          // number of items in your list
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            // var showData = item[index];
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    150) /
                                                1.63,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFE6E1),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25),
                                                    topRight:
                                                        Radius.circular(25)),
                                                child: Image.network(
                                                    "${snapshot.data.docs[index].data()["imageFood"]}",
                                                    height: 100,
                                                    width: 170,
                                                    fit: BoxFit.fitWidth),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 7),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 30,
                                                              top: 10,
                                                              bottom: 20),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${snapshot.data.docs[index].data()["nameFood"]}",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => EditCook(
                                                                      nameFood: snapshot.data.docs[index].data()[
                                                                          "nameFood"],
                                                                      timeCook: snapshot.data.docs[index].data()[
                                                                          "timeCook"],
                                                                      categoryFood:
                                                                          snapshot.data.docs[index].data()[
                                                                              "categoryFood"],
                                                                      ingredient:
                                                                          snapshot.data.docs[index].data()[
                                                                              "ingredient"],
                                                                      howcook: snapshot.data.docs[index].data()[
                                                                          "howCook"],
                                                                      imageFood: snapshot
                                                                          .data
                                                                          .docs[index]
                                                                          .data()["imageFood"],
                                                                      linkYoutube: snapshot.data.docs[index].data()["linkYoutube"],
                                                                      foodid: snapshot.data.docs[index].id)));
                                                        },
                                                        icon: Icon(Icons.edit))
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 70, top: 0),
                                              child: Container(
                                                width: 70,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Icon(
                                                        Icons.favorite,
                                                        size: 18,
                                                        color:
                                                            Color(0xFFF04D56),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      child: Text(
                                                        "${snapshot.data.docs[index].data()["like"]}",
                                                        // "5",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Color(
                                                                0xFFF04D56)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8)
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
                      );
                    })
              ]);
            }));
  }
}
