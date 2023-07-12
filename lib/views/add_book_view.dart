import 'package:firebase_firestore_deneme/services/my_converter.dart';
import 'package:firebase_firestore_deneme/views/add_book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({super.key});

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
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

    DateTime? selectedDate;

    return ChangeNotifierProvider(
      create: (context) => AddBookViewModel(),
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Add Book'),
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
                        publishDateCtr.text = MyConverter.dateTimeToString(selectedDate);
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
                      onPressed: () async{

                        if (_validatorKey.currentState!.validate()) {
                          await context.read<AddBookViewModel>().addBook(authorName: authorNameCtr.text,bookName: bookNameCtr.text,publishDate: selectedDate!);
                          if (!mounted) return;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book succesfully added!')));
                        }
                      },
                      child: const Text('Save'))
                ],
              )),
        ),
      ),
    );
  }
}
