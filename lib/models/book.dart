import 'package:flutter/foundation.dart';

class Book {
  final int bookId;
  final String title;
  //final String isbn;
  // final int pageCount;
  //final DateTime publishedDate;
  final String thumbnailUrl;
  //final String shortDescription;
  //final String author;
  //final String category;
  final int price;

  Book({
    @required this.bookId,
    @required this.title,
    //@required this.isbn,
    //@required this.pageCount,
    //@required this.publishedDate,
    @required this.thumbnailUrl,
    //@required this.shortDescription,
    //@required this.author,
    //@required this.category,
    @required this.price,
  });

  factory Book.fromJson(dynamic json) {
    return Book(
        bookId: json['bookid'] as int,
        title: json['title'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        price: json['price'] as int);
  }

  @override
  String toString() {
    return '{ ${this.bookId}, ${this.title}, ${this.thumbnailUrl} , ${this.price} }';
  }
}
