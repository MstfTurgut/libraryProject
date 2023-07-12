import 'package:firebase_firestore_deneme/services/my_converter.dart';
import 'package:firebase_firestore_deneme/views/view-models/update_book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/book.dart';

class UpdateBookView extends StatefulWidget {
  const UpdateBookView({required this.book, super.key});

  final Book book;

  @override
  State<UpdateBookView> createState() => _UpdateBookViewState();
}

class _UpdateBookViewState extends State<UpdateBookView> {
  final _validatorKey = GlobalKey<FormState>();

  TextEditingController bookNameCtr = TextEditingController();
  TextEditingController authorNameCtr = TextEditingController();
  TextEditingController publishDateCtr = TextEditingController();

  @override
  void dispose() {
    bookNameCtr.dispose();
    authorNameCtr.dispose();
    publishDateCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bookNameCtr.text = widget.book.bookName!;
    authorNameCtr.text = widget.book.authorName!;
    publishDateCtr.text = MyConverter.dateTimeToString(
        MyConverter.timestampToDateTime(widget.book.publishDate!));

    DateTime? selectedDate;

    return ChangeNotifierProvider(
      create: (context) => UpdateBookViewModel(),
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Update Book'),
          backgroundColor: Colors.amber,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
              key: _validatorKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: bookNameCtr,
                    decoration: InputDecoration(
                        hintText: 'Enter book name',
                        icon: const Icon(Icons.book),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.amber.shade700),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: authorNameCtr,
                    decoration: InputDecoration(
                        hintText: 'Enter book author name',
                        icon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.amber.shade700),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onTap: () async {
                      selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(-1000),
                          lastDate: DateTime.now());

                      if (selectedDate != null) {
                        publishDateCtr.text =
                            MyConverter.dateTimeToString(selectedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: publishDateCtr,
                    decoration: InputDecoration(
                        hintText: 'Enter book publish date',
                        icon: const Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.amber.shade700),
                        )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_validatorKey.currentState!.validate()) {
                          context.read<UpdateBookViewModel>().updateBook(
                              book: widget.book,
                              authorName: authorNameCtr.text,
                              bookName: bookNameCtr.text,

                              publishDate: selectedDate ?? MyConverter.timestampToDateTime(widget.book.publishDate!)
                              
                              );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Book succesfully updated!')));
                        }
                      },
                      child: const Text('Update'))
                ],
              )),
        ),
      ),
    );
  }
}
