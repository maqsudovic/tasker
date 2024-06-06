import 'package:bottom/views/screens/homepage.dart';
import 'package:bottom/views/screens/notescreen.dart';
import 'package:bottom/views/screens/profilepage.dart';
import 'package:bottom/views/screens/statisticpage.dart';
import 'package:bottom/views/screens/todoscreen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Homepage(),
        '/profile': (context) => Profilepage(),
        '/statistic': (context) => Statisticpage(),
        '/todoscreen': (context) => TodoScreenPage(),
        '/notescreen': (context) => NotescreenPage(),
      },
    );
  }
}
