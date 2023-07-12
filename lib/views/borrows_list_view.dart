import 'package:firebase_firestore_deneme/views/borrows_list_view_model.dart';
import 'package:firebase_firestore_deneme/widgets/borrow_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/book.dart';
import '../model/profile.dart';

class BorrowsListView extends StatefulWidget {
  const BorrowsListView({super.key, required this.book});

  final Book book;
  

  @override
  State<BorrowsListView> createState() => _BorrowsListViewState();
}

class _BorrowsListViewState extends State<BorrowsListView> {


  @override
  Widget build(BuildContext context) {
    List<Profile>? borrowList = widget.book.borrows;

    return ChangeNotifierProvider(
      create: (context) => BorrowsListViewModel(),
      builder: (context, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: Text(
              '${widget.book.bookName} Borrow Records',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: borrowList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(borrowList[index].photoUrl!),
                          ),
                          title: Text(
                              '${borrowList[index].name} ${borrowList[index].surname}'),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  Profile? profile = await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return const BorrowForm();
                    },
                  );

                  if (profile != null) {
                    if (!mounted) return;
                    await context
                        .read<BorrowsListViewModel>()
                        .updateBookWithProfile(
                            book: widget.book, profile: profile);
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  height: 70,
                  alignment: Alignment.bottomCenter,
                  child: const Center(
                      child: Text(
                    'New Borrow Record',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
              )
            ],
          )),
    );
  }
}
