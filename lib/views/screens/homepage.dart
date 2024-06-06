import 'package:bottom/views/screens/homescreen.dart';
import 'package:bottom/views/screens/profilepage.dart';
import 'package:bottom/views/screens/statisticpage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _choiceIndex = 0;
  void _changeIndex(int index) {
    setState(() {
      _choiceIndex = index;
    });
  }

  List<Widget> screens = [Homescreen(), Statisticpage(), Profilepage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _choiceIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _changeIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart_rounded), label: 'Statistic'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_4_outlined), label: 'Profile'),
        ],
      ),
      body: screens[_choiceIndex],
    );
  }
}
