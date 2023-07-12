import 'package:firebase_firestore_deneme/views/add_book_view.dart';
import 'package:firebase_firestore_deneme/views/books_view_model.dart';
import 'package:firebase_firestore_deneme/widgets/book_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/book.dart';

class BooksView extends StatefulWidget {
  const BooksView({super.key});

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BooksViewModel>(
      create: (context) => BooksViewModel(),
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
          stream: context.read<BooksViewModel>().getBookList(),
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

              return BookListWidget(books: books);
            }
          },
        ),
      ),
    );
  }


}
