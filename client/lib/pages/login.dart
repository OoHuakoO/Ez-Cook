import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
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
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                  child: Text(
                    "Ez Cook",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF04D56)),
                  ),
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
                          borderSide: BorderSide(width: 1, color: Color(0xFFF04D56)),
                          borderRadius: BorderRadius.circular(10))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: SizedBox(
                    height: 45,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFF04D56)),
                      ),
                      child:
                          Text("ลงชื่อเข้าใช้", style: TextStyle(fontSize: 20)),
                      onPressed: () {},
                    ),
                  ),
                ),
                TextButton(
                  child: Text("ลืมรหัสผ่าน ?",
                      style: TextStyle(fontSize: 18, color: Color(0xFF9D9D9D))),
                  onPressed: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('หากคุณยังไม่มีบัญชีผู้ใช้งาน',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF9D9D9D))),
                    TextButton(
                      child: Text("สมัครสมาชิก",
                          style: TextStyle(
                              fontSize: 20, color: Color(0xFFF04D56))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
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
