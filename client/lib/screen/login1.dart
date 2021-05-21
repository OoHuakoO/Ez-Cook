import 'package:client/screen/login.dart';
import 'package:client/screen/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label:
                      Text("สร้างบัญชีผู้ใช้", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RegisterScreen();
                    }));
                  },
                ),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.login),
                  label: Text("เข้าสู่ระบบ", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
