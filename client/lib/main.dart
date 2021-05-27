
import 'package:client/pages/homepage.dart';
import 'package:client/pages/profile.dart';
import 'package:client/pages/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseAuth.instance.currentUser == null ? Login() : Profile() 
  ));
}
