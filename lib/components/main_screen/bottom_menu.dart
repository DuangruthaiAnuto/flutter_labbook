import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/cart_provider.dart' show Cart;
import '../../components/common/common.dart';
import '../../screens/login.dart';

class BottomMenu extends StatelessWidget {
  final _currentBottomMenuIndex;
  final Function setMenu;

  BottomMenu(this.setMenu, this._currentBottomMenuIndex);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return BottomNavyBar(
      backgroundColor: Colors.black,
      selectedIndex: _currentBottomMenuIndex,
      iconSize: 30,
      items: [
        BottomNavyBarItem(
          title: Text("Books"),
          icon: Icon(
            Icons.book,
            color: Colors.orangeAccent,
          ),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          title: Text("My Orders"),
          icon: Icon(
            Icons.list_outlined,
            color: Colors.blueAccent,
          ),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          title: Text("About"),
          icon: Icon(
            Icons.contact_support,
            color: Colors.yellow,
          ),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          title: Text("Sign Out"),
          icon: Icon(
            Icons.logout,
            color: Colors.greenAccent,
          ),
          activeColor: Colors.white,
        )
      ],
      onItemSelected: (index) {
        if (index != 3) {
          setMenu(index);
        } else {
          signOut(context, cart);
        }
      },
    );
  }

  void signOut(BuildContext context, cart) async {
    //-----Show Confirm Dialog
    await showConfirmDialog(context, "Sign out?", "Do you want to sign out?",
        () async {
      cart.clearCart();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', null);
      prefs.setString('username', null);
      prefs.setString('token', null);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
        (route) => false,
      );

      //Navigator.of(context).pop();
    }, () {
      Navigator.of(context).pop();
    });
    //-----End - Show Confirm Dialog
  }
}
