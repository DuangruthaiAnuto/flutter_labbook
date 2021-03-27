import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../components/book_list/add_bookitem_buttomsheet.dart';

class BookDetail extends StatelessWidget {
  final int bookId;
  final String title;
  final String thumbnailUrl;
  final int price;

  BookDetail(this.bookId, this.title, this.thumbnailUrl, this.price);
  static const routeName = '/book-detail';

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
    //final bookId = ModalRoute.of(context).settings.arguments as int;

    //final loadBook = Provider.of<Books>(context).findByBookId(bookId);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "\$$price",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red),
                  )
                ],
              ),
            ),
            Container(
              child: FlatButton(
                  height: 45,
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: buildButtomSheet);
                    //cart.addItem(bookId, price, title, thumbnailUrl);
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
