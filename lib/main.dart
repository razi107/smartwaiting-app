import 'package:flutter/material.dart';
import 'package:myapp2/pages/home_page.dart';
import 'package:myapp2/pages/login.dart';
import 'package:myapp2/pages/receptioniste1.dart';
import 'package:myapp2/pages/sevice.dart';
import 'package:myapp2/pages/signup.dart';
import 'package:myapp2/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",

      routes: {
        '/': (context) => const Welcome(),
        '/login': (context) => const Login(),
        '/home_page': (context) => const Home_page(),
        '/receptioniste1': (context) => const Receptioniste1(),
        '/service': (context) => const Service(),
    
        "/signup" : (context) => const Signup(),


      }, 
    
    );
  }
}