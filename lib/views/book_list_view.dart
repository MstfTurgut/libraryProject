import 'package:firebase_firestore_deneme/views/add_book_view.dart';
import 'package:firebase_firestore_deneme/views/view-models/book_list_view_model.dart';
import 'package:firebase_firestore_deneme/views/widgets/book_list_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/book.dart';

class BookListView extends StatefulWidget {
  const BookListView({super.key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListViewModel>(
      create: (context) => BookListViewModel(),
      builder: 
      (context, child) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        floatingActionButton: 
        FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddBookView(),));
            },
            child: const Icon(
              Icons.add,
            )),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('BOOK LIST'),
        ),
        body: StreamBuilder<List<Book>>(
          stream: context.read<BookListViewModel>().getBookList(),
          builder: (context, snapshot) {

            if (snapshot.hasError) {
              return const Text(
                "Couldn't load books. Something went wrong",
                style: TextStyle(color: Colors.red),
              );
            } 
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Center(child: CircularProgressIndicator()),
              );
            } 
            else {
              List<Book> books = snapshot.data!;

              return BookListBody(books: books);
            }
          },
        ),
      ),
    );
  }


}
