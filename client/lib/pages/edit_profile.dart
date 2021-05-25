import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Edit_Profile extends StatefulWidget {
  @override
  _Edit_ProfileState createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFF04D56),
          title: Text("แก้ไขโปรไฟล์"),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/profilenadate.jpeg"),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                      ),
                      TextFormField(
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
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFF04D56)),
                              ),
                              child: Text("บันทึก",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
