import 'package:client/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var manage_accounts_rounded;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF04D56),
        title: Text("ตั้งค่า"),
      ),
      body: Column(
        children: [
          ListTile(
            // leading: Icon(
            //   Icons.manage_accounts_outlined,
            // ),
            title: Text("แก้ไขโปรไฟล์",
                style: TextStyle(fontSize: 20, color: Color(0xFF4A4848))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Editprofile()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Color(0xFFF04D56),
            ),
            title: Text("ออกจากระบบ",
                style: TextStyle(fontSize: 20, color: Color(0xFFF04D56))),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
