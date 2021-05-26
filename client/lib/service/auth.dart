

// import 'package:client/pages/homepage.dart';
// import 'package:client/pages/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthService {

//     handleAuth(){
//       return StreamBuilder(
//         stream : FirebaseAuth.instance.onAuthStateChanged,
//         builder: (BuildContext context , snapshot) {
//           if(snapshot.hasData){
//             print("gg");
//             return Homepage();
//           }
//         else 
//         return Login();
//         },
//       );
//     }

//     signIn(String email , String password){
//       FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
//       .then((value) {
//         print("Sign In Success");
//       })
//       .catchError((e) {
//         print(e);
//       });
//     }

//     register(String username , String imageProfile , String email , String password){
//       FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
//       .then((value) {
//         print("Register Success");
//       })
//       .catchError((e) {
//         print(e);
//       });
//     }

//     signOut(){
//       FirebaseAuth.instance.signOut();
//     }
  
// }