import 'package:client/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/register.dart';
import 'package:client/pages/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset('assets/LogoEzcook.png'),
                TextFormField(
                  onSaved: (value) {
                    email = value;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "กรุณาใส่อีเมล"),
                    EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                  ]),
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
                  onChanged: (value) {
                    this.email = value;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (value) {
                    password = value;
                  },
                  validator: RequiredValidator(errorText: "กรุณาใส่รหัสผ่าน"),
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
                  onChanged: (value) {
                    this.password = value;
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFF04D56)),
                      ),
                      child:
                          Text("ลงชื่อเข้าใช้", style: TextStyle(fontSize: 20)),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: "ลงชื่อเข้าใช้สำเร็จ",
                                  gravity: ToastGravity.TOP);
                              formKey.currentState.reset();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Home();
                              }));
                            });
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            String message;
                            if (e.code == "user-not-found") {
                              message = "อีเมลหรือรหัสผ่านไม่ถูกต้อง";
                            } else {
                              message = "อีเมลหรือรหัสผ่านไม่ถูกต้อง";
                            }
                            Fluttertoast.showToast(
                                msg: message, gravity: ToastGravity.TOP);
                          }
                        }
                      },
                    ),
                  ),
                ),
                TextButton(
                  child: Text("ลืมรหัสผ่าน ?",
                      style: TextStyle(fontSize: 16, color: Color(0xFF9D9D9D))),
                  onPressed: () {},
                ),
                Container(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('หากคุณยังไม่มีบัญชีผู้ใช้งาน',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF9D9D9D))),
                      TextButton(
                        child: Text("สมัครสมาชิก",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFFF04D56))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                      ),
                      // Text(FirebaseFirestore.instance.currentUser.email)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
