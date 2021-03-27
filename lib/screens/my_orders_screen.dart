import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart' show Cart;
import '../providers/order_provider.dart';

import '../components/book_list/badge.dart';

class MyOrdersScreen extends StatelessWidget {
  static const routeName = '/myorders';

  @override
  Widget build(BuildContext context) {
    Order orderList = Provider.of<Order>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orderList.orders.length,
              itemBuilder: (ctx, i) {
                return Card(child: Text("Order History")); //Code here
              },
            ),
          ),
        ],
      ),
    );
  }
}
