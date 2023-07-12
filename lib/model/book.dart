import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_deneme/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  final String? id;
  final String? bookName;
  final String? authorName;

  @JsonKey(toJson: _dateTimeToEpoch,fromJson: _dateTimeFromEpoch)
  final Timestamp? publishDate;

  @JsonKey(toJson: _profileListToJson)
  final List<Profile> borrows;

  Book(
      {this.id,
      this.bookName,
      this.authorName,
      this.publishDate,
      this.borrows = const []});


  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);    


  static Timestamp? _dateTimeFromEpoch(int value) => Timestamp.fromMillisecondsSinceEpoch(value);

  static int _dateTimeToEpoch(Timestamp? timestamp) => timestamp!.millisecondsSinceEpoch;


  static List<Map<String,dynamic>> _profileListToJson(List<Profile> list) => list.map((profile) => profile.toJson()).toList();



}