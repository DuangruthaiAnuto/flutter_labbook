import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'screens/cart_screen.dart';
import 'screens/order_screen.dart';
import 'screens/my_orders_screen.dart';
import 'screens/login.dart';
import 'providers/cart_provider.dart';
import 'providers/book_provider.dart';
import 'providers/order_provider.dart';

Future main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider<Books>(
          create: (context) => Books(),
        ),
        ChangeNotifierProvider<Order>(
          create: (context) => Order(),
        ),
      ],
      child: MaterialApp(
          title: 'Book Shop',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.green,
          ),
          home: Login(),
          routes: {
            MyOrdersScreen.routeName: (ctx) => MyOrdersScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
          }),
    );
  }
}
