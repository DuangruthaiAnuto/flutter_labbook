import 'package:flutter/material.dart';
import '../components/main_screen/bottom_menu.dart';
import '../components/main_screen/tab_menu.dart';

class MainScreen extends StatefulWidget {
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentMenuIndex = 0;

  void setMenu(int newIndex) {
    setState(() {
      _currentMenuIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabMenu(_currentMenuIndex),
      bottomNavigationBar: BottomMenu(setMenu, _currentMenuIndex),
    );
  }
}
