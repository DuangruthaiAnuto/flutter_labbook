import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worm_indicator/shape.dart';
import 'package:worm_indicator/worm_indicator.dart';
import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../components/book_list/book_item.dart';
import '../components/book_list/badge.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
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
      body: BookGrid(),
    );
  }
}

class BookGrid extends StatefulWidget {
  @override
  _BookGridState createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  Books books;
  List<Book> searchBooks;
  TextEditingController editingController = TextEditingController();

  @override
  void didChangeDependencies() {
    books = Provider.of<Books>(context);
    setState(() {
      searchBooks = books.items;
    });
    super.didChangeDependencies();
    //print('didChangeDependencies');
  }

  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.9);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int numberItem = 4;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 200) / 2;
    final double itemWidth = size.width / 2;
    final books = Provider.of<Books>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          height: 70,
          alignment: Alignment.centerLeft,
          child: TextField(
            onChanged: (value) {
              setState(() {
                if (value.isNotEmpty) {
                  //print(value);
                  searchBooks = books.findBookTitle(value);
                } else {
                  searchBooks = books.items;
                }

                //print(searchBooks);
              });
            },
            controller: editingController,
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Expanded(
          child: PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount:
                  (searchBooks.length / numberItem).ceil(), // item.length,
              itemBuilder: (context, p) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: numberItem, //books.length,
                  itemBuilder: (ctx, i) {
                    if (((p * numberItem) + i) < searchBooks.length) {
                      return BookItem(
                        searchBooks[(p * numberItem) + i].bookId,
                        searchBooks[(p * numberItem) + i].title,
                        searchBooks[(p * numberItem) + i].thumbnailUrl,
                        searchBooks[(p * numberItem) + i].price,
                      );
                    } else {
                      return null;
                    }
                  },
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                );
              }),
        ),
        WormIndicator(
          length: (searchBooks.length / numberItem).ceil(),
          controller: _controller,
          color: Colors.black, //.lightBlueAccent.withOpacity(0.5),
          indicatorColor: Colors.blueAccent,
          shape: Shape(
            size: 13,
            shape: DotShape.Circle,
            spacing: 5,
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
