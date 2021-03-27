import 'package:flutter/material.dart';

import '../../screens/book_list.dart';
import '../../screens/my_orders_screen.dart';
import '../../screens/about.dart';

class TabMenu extends StatelessWidget {
  final _currentTabIndex;

  final List<Widget> tabs = [
    Center(
      child: BookList(),
    ),
    Center(
      child: MyOrdersScreen(),
    ),
    Center(
      child: About(),
    ),
  ];

  TabMenu(this._currentTabIndex);

  @override
  Widget build(BuildContext context) {
    return tabs[_currentTabIndex];
  }
}
