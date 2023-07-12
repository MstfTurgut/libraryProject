
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/book.dart';

class Database {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Stream<QuerySnapshot> getBookListFromApi(String booksRef) {

    return _firestore.collection(booksRef).snapshots();
    
  }

  Future<void> deleteDocument(String booksRef,String id) async{

    await _firestore.collection(booksRef).doc(id).delete();
    
  }

  Future<void> addAndUpdateDocument({Map<String,dynamic>? map, String? booksRef}) async{

    await _firestore.collection(booksRef!).doc(Book.fromJson(map!).id).set(map);

  }















}