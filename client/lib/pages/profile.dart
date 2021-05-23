import 'package:client/pages/DetailFoodPage.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: getBody(),

    //   body: Padding(
    //     padding: const EdgeInsets.fromLTRB(40, 100, 40, 50),
    //   child:Column(
    //     children: [
    //       SizedBox(
    //         height :115,
    //         width:115,
    //         child: CircleAvatar(
    //               backgroundImage: AssetImage("assets/profilenadate.png"),
    //             ),
              
            
    //       )
    //     ],
    //   ),
    // ),
    );
  }
}

Widget getbody() {
  return Column(
    children: [
        Container(
          child : 
          Image.asset("assets/profilenadate.jpeg")
        )
    ]
  );
}