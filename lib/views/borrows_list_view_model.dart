import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_firestore_deneme/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/book.dart';
import '../model/profile.dart';

class BorrowsListViewModel extends ChangeNotifier {
  final _database = Database();
  final _booksRef = 'books';


  Future<void> updateBookWithProfile({required Book book, required Profile profile}) async {

    book.borrows.add(profile);

    print(book.toJson());

    await _database.addAndUpdateDocument(
        booksRef: _booksRef, map: book.toJson());

  }

    Future<String> putImageToStorage(File file) async {

    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('photos')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg')
        .putFile(file);

    String uploadedImageUrl = await taskSnapshot.ref.getDownloadURL();

    return uploadedImageUrl;

  }

    Future<File?> getImage() async {

    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      sourcePath: pickedImage!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.amber,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
      ],
    );

      if (croppedFile != null) {
        return File(croppedFile.path);
      } else {
        return null;
      }

  }

}
