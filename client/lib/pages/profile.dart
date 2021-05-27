
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


  final profileList = FirebaseFirestore.instance.collection("User").where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid);
  final getFood = FirebaseFirestore.instance.collection("Food").where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid);



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: profileList.snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              print("ssss");
              return Center(child: CircularProgressIndicator(),);
            }
            print(snapshot.data);
            return Column(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
          child: SizedBox(
            height: 150,
            width: 150,
            child: CircleAvatar(
              backgroundImage: AssetImage("${snapshot.data.docs[0]["imageProfile"]}"),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          // "",
          "${snapshot.data.docs[0]["username"]}",
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

      StreamBuilder(
        stream: getFood.snapshots(),
        builder: (context,snapshot) {
          return Expanded(
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
                                  "${snapshot.data.docs[index].data()["imageProfile"]}",
                                  
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30, top: 10, bottom: 20),
                              child: Text(
                                "${snapshot.data.docs[index].data()["nameFood"]}",
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
                                         "${snapshot.data.docs[index].data()["like"]}",
                                        // "5",
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
      );
        })
     
    ]);
          })
    );
  }
}














// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   // List item = [
//   //   "assets/ascasc.png",
//   //   "assets/ascasc.png",
//   //   "assets/ascasc.png",
//   //   "assets/ascasc.png",
//   //   "assets/ascasc.png",
//   //   "assets/ascasc.png",
//   //   "assets/ascasc.png",
//   //   "assets/ascasc.png",
//   // ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserData();
//   }
//   final profileList = FirebaseFirestore.instance.collection("User").where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid);
//   final getFood = FirebaseFirestore.instance.collection("Food").where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid);

//    List items = [];
//      List itemFood = [];
//   Future getUserData () async {
//     try{
//       await profileList.get().then((snapshot) {
//         snapshot.docs.forEach((res) {
//           items.add(res.data());
//          });
//       });
//        await getFood.get().then((snapshot) {
//         snapshot.docs.forEach((res) {
//           itemFood.add(res.data());
//           print(itemFood);
//          });
//       });
//     }catch(err){
//           print(err);
//     }
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(children: [
//       Center(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
//           child: SizedBox(
//             height: 150,
//             width: 150,
//             child: CircleAvatar(
//               backgroundImage: AssetImage("${items[0]["imageProfile"]}"),
//             ),
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
//         child: Text(
//           "${items[0]["username"]}",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       Row(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   left: 30, right: 0, top: 20, bottom: 30),
//               child: Text(
//                 "สูตรอาหารของฉัน",
//                 style: TextStyle(fontSize: 18, color: Color(0xFFF04D56)),
//               ),
//             ),
//           ),
//         ],
//       ),
//       Expanded(
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             // number of items per row
//             crossAxisCount: 2,
//             // vertical spacing between the items
//             mainAxisSpacing: 30,
//             // horizontal spacing between the items
//             crossAxisSpacing: 1,
//           ),
//           // number of items in your list
//           itemCount: itemFood.length,
//           itemBuilder: (BuildContext context, int index) {
//             // var showData = item[index];
//             return Column(
//               children: [
//                 Column(
//                   children: [ 
//                     Padding(
//                       padding: const EdgeInsets.only(top: 0),
//                       child: Container(
//                         width: (MediaQuery.of(context).size.width - 150) / 1.63,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFFFE6E1),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: Column(
//                           children: [
//                             InkWell(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(25),
//                                     topRight: Radius.circular(25)),
//                                 child: Image.asset(
//                                   "${itemFood[index]["imageFood"]}",
                                  
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   right: 30, top: 10, bottom: 20),
//                               child: Text(
//                                 "${itemFood[index]["nameFood"]}",
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 70, top: 0),
//                               child: Container(
//                                 width: 70,
//                                 height: 20,
//                                 decoration: BoxDecoration(
//                                     color: Color(0xFFF04D56),
//                                     borderRadius: BorderRadius.circular(25)),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       child: Icon(
//                                         Icons.hearing,
//                                         size: 18,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       child: Text(
//                                          "${itemFood[index]["like"]}",
//                                         // "5",
//                                         style: TextStyle(
//                                             fontSize: 18, color: Colors.white),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     ]));
//   }
// }





