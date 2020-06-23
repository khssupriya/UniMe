import 'package:flutter/material.dart';
import 'package:unime3/pages/home.dart';
import 'package:unime3/pages/each.dart';
import 'package:unime3/pages/post.dart';
//import 'package:unime3/pages/collegeinput.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        //'/':(context) => CollegeInput(),
        '/':(context) => MyHomePage(),
        '/each':(context) => Each(),
        '/post':(context) => Post(),
      },
    );
  }
}