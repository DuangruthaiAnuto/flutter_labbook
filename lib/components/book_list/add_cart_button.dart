import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/common/common.dart';
import '../../providers/cart_provider.dart';

class AddCartButton extends StatelessWidget {
  final int bookId;
  final String title;
  final int price;
  final String thumbnailUrl;
  final int qty;
  final bool isUpdate;

  AddCartButton(this.bookId, this.title, this.price, this.thumbnailUrl,
      this.qty, this.isUpdate);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return FlatButton(
        height: 45,
        color: Colors.blueGrey,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () async {
          cart.addItem(bookId, price, title, thumbnailUrl, qty);

          Navigator.of(context).pop();
          await showFlashDialog(
              context,
              "${(isUpdate == false) ? 'Added to cart!' : 'Updated cart!'}",
              "'$title' was ${(isUpdate == false) ? 'added to cart!' : 'updated!'}");
        },
        child: Text(
          (isUpdate == false) ? "Add to Cart" : "Update Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ));
  }
}
