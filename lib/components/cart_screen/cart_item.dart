import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CartItemWidget extends StatelessWidget {
  //final String id;
  final int bookId;
  final int price;
  final int qty;
  final String title;
  final String thumbnailUrl;

  CartItemWidget(
    //this.id,
    this.bookId,
    this.price,
    this.qty,
    this.title,
    this.thumbnailUrl,
  );

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: FittedBox(
            child: Image(
              image: NetworkImage(thumbnailUrl),
              //height: 90,
            ),
          ),
          title: Text(title),
          subtitle: Column(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                child: Text(
                  'Price: \$${(price)}',
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cart.decreaseItem(bookId);
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: FittedBox(
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      '$qty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    GestureDetector(
                      onTap: () {
                        cart.increaseItem(bookId);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 16,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: FittedBox(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$${NumberFormat("#,###").format(price * qty)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
