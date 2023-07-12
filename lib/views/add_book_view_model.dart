import 'package:firebase_firestore_deneme/services/database.dart';
import 'package:firebase_firestore_deneme/services/my_converter.dart';
import 'package:flutter/material.dart';

import '../model/book.dart';

class AddBookViewModel extends ChangeNotifier{

  final _database = Database();
  final _booksRef = 'books';

  Future<void> addBook({required String authorName,required String bookName,required DateTime publishDate}) async{

    Book book = Book(borrows: const [],authorName: authorName,bookName: bookName,id: DateTime.now().toIso8601String(),publishDate: MyConverter.dateTimeToTimestamp(publishDate));

    await _database.addAndUpdateDocument(map: book.toJson(),booksRef: _booksRef);

  }



}