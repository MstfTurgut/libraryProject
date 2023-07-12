import 'package:firebase_firestore_deneme/views/borrows_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../model/book.dart';
import '../view-models/book_list_view_model.dart';
import '../update_book_view.dart';

class BookListBody extends StatefulWidget {
  const BookListBody({super.key, required this.books});

  final List<Book> books;

  @override
  State<BookListBody> createState() => _BookListBodyState();
}

class _BookListBodyState extends State<BookListBody> {
  bool isFiltered = false;

  late List<Book> filteredBookList;

  @override
  Widget build(BuildContext context) {
    List<Book> bookList = widget.books;

    List<Book> finalBookList = isFiltered ? filteredBookList : bookList;

    return Column(
      children: [
        TextField(
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                isFiltered = true;
                filteredBookList = bookList
                    .where((book) => book.bookName!
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            } else {
              setState(() {
                isFiltered = false;
              });
            }
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search : Book name',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: finalBookList.length,
            itemBuilder: (context, index) {
              return Column(children: [
                Slidable(
                  startActionPane:
                      ActionPane(
                        extentRatio: 0.35,
                        motion: const ScrollMotion(), children: [
                    SlidableAction(
                        backgroundColor: Colors.lightBlue,
                        label: 'Profiles',
                        icon: Icons.person,
                        onPressed: (contexttt) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BorrowsListView(book: finalBookList[index]),
                              )); 
                        })
                  ]),
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                        backgroundColor: Colors.greenAccent,
                        label: 'Edit',
                        icon: Icons.edit,
                        onPressed: (context) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateBookView(
                              book: finalBookList[index],
                            ),
                          ));
                        }),
                    SlidableAction(
                        backgroundColor: Colors.redAccent,
                        label: 'Delete',
                        icon: Icons.delete,
                        onPressed: (contextt) async {
                          bool? deleteCard = false;
                          deleteCard = await _showMyConfirmDialog(
                              finalBookList[index].bookName);
                          if (deleteCard!) {
                            if (!mounted) return;
                            await context
                                .read<BookListViewModel>()
                                .deleteBook(finalBookList[index]);
                          }
                        }),
                  ]),
                  child: Card(
                      color: Colors.amber.shade50,
                      child: ListTile(
                        title: Text(finalBookList[index].bookName!),
                        subtitle: Text(finalBookList[index].authorName!),
                      )),
                ),
                const Divider(),
              ]);
            },
          ),
        ),
      ],
    );

  }

  Future<bool?> _showMyConfirmDialog(String? bookName) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to delete book $bookName ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
  
}
