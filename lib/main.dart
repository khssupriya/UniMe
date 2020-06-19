import 'package:flutter/material.dart';
import 'package:unime3/pages/home.dart';
import 'package:unime3/pages/each.dart';
import 'package:unime3/pages/post.dart';

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
        '/':(context) => MyHomePage(title: 'Uni.me'),
        '/each':(context) => Each(title: 'Uni.me'),
        '/post':(context) => Post(title: 'Uni.me'),
      },
    );
  }
}