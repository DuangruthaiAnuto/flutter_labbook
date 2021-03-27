import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import '../../components/cart_screen/cart_item.dart';

import '../../providers/cart_provider.dart' show Cart;
import '../../models/cart.dart';

class SlideableItem extends StatelessWidget {
  const SlideableItem(this.item);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: CartItemWidget(
        item.bookId,
        item.price,
        item.qty,
        item.title,
        item.thumbnailUrl,
      ),
      /* actions: [
        IconSlideAction(
          caption: 'Increase',
          color: Colors.green,
          icon: Icons.add_circle,
          onTap: () {
            cart.increaseItem(item.bookId);
          },
        ),
        IconSlideAction(
          caption: 'Decrease',
          color: Colors.blue,
          icon: Icons.remove_circle,
          onTap: () {
            cart.decreaseItem(item.bookId);
          },
        ),
      ], */
      secondaryActions: [
        IconSlideAction(
          caption: 'Remove',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            cart.removeItem(item.bookId);
          },
        ),
      ],
    );
  }
}
