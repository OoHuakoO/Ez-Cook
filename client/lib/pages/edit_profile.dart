
import 'package:client/firebase/firebase_api.dart';
import 'package:client/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final formKey = GlobalKey<FormState>();
  String username, imageProfile = "";



  final profileLists = FirebaseFirestore.instance
      .collection("User")
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFF04D56),
          title: Text("แก้ไขโปรไฟล์"),
        ),
        body: StreamBuilder(
            stream: profileLists.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("aaa");
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("bbb");
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          backgroundImage: snapshot.data.docs[0]["imageProfile"] != "" ? NetworkImage(
                            "${snapshot.data.docs[0]["imageProfile"]}"
                            ) : AssetImage(
                            "assets/profile.jpg"
                            ),
                          // backgroundImage: AssetImage("assets/profilenadate.jpeg"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: SizedBox(
                      height: 30,
                      width: 160,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFF04D56)),
                          ),
                          child: Text("แก้ไขรูปภาพโปรไฟล์",
                              style: TextStyle(fontSize: 14)),
                          onPressed: () {}),
                    ),
                  ),
                  // Container(
                  //     height: 100,
                  //     width: MediaQuery.of(context).size.width,
                  //     margin: EdgeInsets.symmetric(
                  //       horizontal:20,
                  //       vertical:20,
                  //     ),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Text(Column("เลือกรูปภาพ"),style: TextStyle(fontSize: 20,)),
                  //         SizedBox(
                  //           height:20,
                  //         )
                  //       ]
                  //     ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                            ),
                            TextFormField(
                              initialValue:
                                  "${snapshot.data.docs[0]["username"]}",
                              onSaved: (value) {
                                username = value;
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFAFAFA),
                                  hintText: 'ชื่อผู้ใช้งาน',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFFCECECE)),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFFF04D56)),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            SizedBox(
                              height: 15,
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
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFFCECECE)),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFFF04D56)),
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
                                          MaterialStateProperty.all(
                                              Color(0xFFF04D56)),
                                    ),
                                    child: Text("บันทึก",
                                        style: TextStyle(fontSize: 20)),
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection("User")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser.uid)
                                              .update({
                                            "username": username,
                                            "imageProfile": imageProfile
                                          });
                                          Fluttertoast.showToast(
                                              msg: "แก้ไขโปรไฟล์สำเร็จ",
                                              gravity: ToastGravity.TOP);
                                          formKey.currentState.reset();
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Home();
                                          }));
                                        } on FirebaseAuthException catch (e) {
                                          print(e);
                                        }
                                      }
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
