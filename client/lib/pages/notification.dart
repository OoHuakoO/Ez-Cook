import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Noti extends StatefulWidget {
  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    List<Notifications> notification = [
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
      Notifications('assets/profilenadate.jpeg',
          'Nadet ได้คอมเมนต์มาที่สูตรอาหารของคุณ', '2 ชั่วโมงที่แล้ว'),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color(0xFFF04D56), title: Text("การแจ้งเตือน")),
      body: SingleChildScrollView(
          child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(3, 5, 2, 0),
        shrinkWrap: true,
        itemCount: notification.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Notifications noti = notification[index];
          return ListTile(
            leading: Image.asset(
              noti.image,
            ),
            title: Text(
              noti.message,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              noti.time,
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          );
        },
      )),
    );
  }
}

class $ {}
