import 'package:flutter/material.dart';

import 'edit_profile.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF04D56),
        title: Text("ตั้งค่า"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.manage_accounts_rounded,
            ),
            title: Text("แก้ไขโปรไฟล์",
                style: TextStyle(fontSize: 20, color: Color(0xFF4A4848))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Edit_Profile()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Color(0xFFF04D56),
            ),
            title: Text("ออกจากระบบ",
                style: TextStyle(fontSize: 20, color: Color(0xFFF04D56))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Edit_Profile()),
              );
            },
          ),
        ],
      ),
    );
  }
}
