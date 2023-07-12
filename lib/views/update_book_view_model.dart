import 'package:firebase_firestore_deneme/services/my_converter.dart';
import 'package:flutter/material.dart';

import '../model/book.dart';
import '../services/database.dart';

class UpdateBookViewModel extends ChangeNotifier {


  final _database = Database();
  final _booksRef = 'books';

  Future<void> updateBook({required Book book,required String bookName,required String authorName,required DateTime publishDate}) async{

    Book newBook = Book(borrows: book.borrows,authorName: authorName,bookName: bookName,id: book.id,publishDate: MyConverter.dateTimeToTimestamp(publishDate));

    await _database.addAndUpdateDocument(map: newBook.toJson(),booksRef: _booksRef);

  }

}