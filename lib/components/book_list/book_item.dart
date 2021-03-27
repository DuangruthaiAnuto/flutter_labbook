import 'package:flutter/material.dart';
import '../../screens/book_detail.dart';
import './add_bookitem_buttomsheet.dart';
import '../../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class BookItem extends StatelessWidget {
  final int bookId;
  final String title;
  final String thumbnailUrl;
  final int price;

  BookItem(this.bookId, this.title, this.thumbnailUrl, this.price);

  Widget buildButtomSheet(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    int _qty;
    bool _isUpdate;
    if (cart.items.containsKey(bookId)) {
      _qty = cart.items[bookId].qty;
      _isUpdate = true;
    } else {
      _qty = 1;
      _isUpdate = false;
    }
    return AddBookItemButtomSheet(
        bookId, title, price, thumbnailUrl, _qty, _isUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookDetail(bookId, title, thumbnailUrl, price)),
            );
          },
          child: Image.network(
            thumbnailUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87.withOpacity(0.7),
          /* leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ), */
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.orangeAccent,
              size: 25,
            ),
            onPressed: () {
              showModalBottomSheet(context: context, builder: buildButtomSheet);
              //cart.addItem(bookId, price, title, thumbnailUrl);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
