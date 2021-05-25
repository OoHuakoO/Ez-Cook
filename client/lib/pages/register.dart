import 'package:flutter/material.dart';
import 'package:client/pages/login.dart';
// ignore: unused_import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 100, 40, 50),
        child: Container(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                  child: Text(
                    "สมัครสมาชิก",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF04D56)),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFAFAFA),
                      hintText: 'ชื่อผู้ใช้งาน',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFCECECE)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFF04D56)),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFAFAFA),
                      hintText: 'อีเมล',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFCECECE)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFF04D56)),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFAFAFA),
                      hintText: 'รหัสผ่าน',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFCECECE)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFF04D56)),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: SizedBox(
                    height: 45,
                    width: 300,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFF04D56)),
                        ),
                        child: Text("สร้างผู้ใช้งาน",
                            style: TextStyle(fontSize: 20)),
                        onPressed: () {}),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('หากคุณมีบัญชีผู้ใช้งานอยู่แล้ว',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF9D9D9D))),
                    TextButton(
                      child: Text("ลงชื่อเข้าใช้",
                          style: TextStyle(
                              fontSize: 20, color: Color(0xFFF04D56))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
