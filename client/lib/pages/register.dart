import 'package:client/pages/home.dart';
import 'package:client/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
// ignore: unused_import



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  String username, email, password, imageProfile = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("ERROR"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
              return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 100, 40, 50),
        child: Container(
          child: Form(
            key: formKey,
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
                  onSaved: (value){
                    username = value;
                  },
                  validator: RequiredValidator(errorText: "กรุณาใส่ชื่อผู้ใช้งาน"),
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
                     onSaved: (value){
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
                    
                    
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    onSaved: (value){
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
                        onPressed: () async{
                            if(formKey.currentState.validate()){
                              formKey.currentState.save();
                              try{
                                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
                                await FirebaseFirestore.instance.collection("User").add({
                                "username" : username, "email" : email , "password" : password , "imageProfile" : imageProfile
                              });
                                  Fluttertoast.showToast(
                                  msg: "สร้างบัญชีสำเร็จ",
                                  gravity: ToastGravity.TOP
                                  );
                                formKey.currentState.reset();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                  return Homepage();
                                }));
                                });
                           
                              }on FirebaseAuthException catch(e){
                                print(e.code);
                                String message;
                                if(e.code == "email-already-in-use"){
                                  message = "อีเมลล์นี้ถูกใช้ไปแล้ว";
                                }else if(e.code == "weak-password"){
                                  message = "รหัสผ่านต้องมีความยาวตั้งแต่ 6 ตัวเป็นต้นไป";
                                }else {
                                  message = e.message;
                                }
                                Fluttertoast.showToast(
                                  msg: message,
                                  gravity: ToastGravity.TOP
                                  );
                              }
                          
                            }
                        }),
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
        });
  
  }
}
