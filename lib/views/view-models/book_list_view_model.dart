import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/book.dart';
import '../../services/database.dart';

class BookListViewModel extends ChangeNotifier {

  final Database _database = Database();

  final String _booksRef = 'books';

  Stream<List<Book>> getBookList() {

    // Stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>

    Stream<List<DocumentSnapshot<Object?>>> documentSnapshotListStream = _database
        .getBookListFromApi(_booksRef)
        .map((querySnapshot) => querySnapshot.docs);

    // Stream<List<DocumentSnapshot>> --> Stream<List<Book>>

    Stream<List<Book>> bookListStream = documentSnapshotListStream.map((documentSnapshotList) =>
        documentSnapshotList.map((documentSnapshot) =>
            Book.fromJson(documentSnapshot.data() as Map<String, dynamic>)).toList());

    return bookListStream;
  }

  Future<void> deleteBook(Book book) async{

    await _database.deleteDocument(_booksRef, book.id!);
    
  }


}
