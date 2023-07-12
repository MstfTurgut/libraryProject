import 'dart:io';
import 'package:firebase_firestore_deneme/model/profile.dart';
import 'package:firebase_firestore_deneme/services/my_converter.dart';
import 'package:firebase_firestore_deneme/views/view-models/borrows_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetForm extends StatefulWidget {
  const BottomSheetForm({super.key});

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm> {
  File? _image;
  String _photoUrl =
      'https://firebasestorage.googleapis.com/v0/b/library-demo-e9210.appspot.com/o/photos%2Fimages.jpg?alt=media&token=dd718804-436a-4a3c-97a5-4a581818dc7e';

  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  TextEditingController borrowDateCtr = TextEditingController();
  TextEditingController returnDateCtr = TextEditingController();

  final validatorKey = GlobalKey<FormState>();

  DateTime? selectedBorrowDate;
  DateTime? selectedReturnDate;

  @override
  void dispose() {
    nameCtr.dispose();
    surnameCtr.dispose();
    borrowDateCtr.dispose();
    returnDateCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BorrowsListViewModel(),
      builder: (context, child) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.55,
          color: Colors.white,
          child: Center(
            child: Form(
              key: validatorKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              backgroundImage: (_image == null)
                                  ? const NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/library-demo-e9210.appspot.com/o/photos%2Fimages.jpg?alt=media&token=dd718804-436a-4a3c-97a5-4a581818dc7e')
                                  : FileImage(_image!) as ImageProvider,
                            )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.zero,
                              width: 40,
                              child: IconButton(
                                onPressed: () async {
                                  var selectedImage = await context
                                      .read<BorrowsListViewModel>()
                                      .getImage();
                                  if (selectedImage != null) {
                                    _image = selectedImage;
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 27,
                                  color: Colors.grey.shade50,
                                ),
                              ),
                            )),
                      ]),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field cannot be blank';
                                } else {
                                  return null;
                                }
                              },
                              controller: nameCtr,
                              decoration:
                                  const InputDecoration(hintText: 'Name'),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field cannot be blank';
                                } else {
                                  return null;
                                }
                              },
                              controller: surnameCtr,
                              decoration:
                                  const InputDecoration(hintText: 'Surname'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          onTap: () async {
                            selectedBorrowDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now());

                            if (selectedBorrowDate != null) {
                              borrowDateCtr.text = MyConverter.dateTimeToString(
                                  selectedBorrowDate);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be blank';
                            } else {
                              return null;
                            }
                          },
                          controller: borrowDateCtr,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              hintText: 'Borrow Date'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          onTap: () async {
                            selectedReturnDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now());

                            if (selectedReturnDate != null) {
                              returnDateCtr.text = MyConverter.dateTimeToString(
                                  selectedReturnDate);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be blank';
                            } else {
                              return null;
                            }
                          },
                          controller: returnDateCtr,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              hintText: 'Return Date'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if (validatorKey.currentState!.validate()) {
                              if (_image != null) {
                                _photoUrl = await context
                                    .read<BorrowsListViewModel>()
                                    .putImageToStorage(_image!);
                              }
                              Profile profile = Profile(
                                  photoUrl: _photoUrl,
                                  name: nameCtr.text,
                                  surname: surnameCtr.text,
                                  borrowDate: MyConverter.dateTimeToTimestamp(
                                      selectedBorrowDate!),
                                  returnDate: MyConverter.dateTimeToTimestamp(
                                      selectedReturnDate!));

                              if (!mounted) return;
                              Navigator.pop(context, profile);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue),
                          child: const Text(
                            'Add Loan Record',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
