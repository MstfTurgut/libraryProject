// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String?,
      bookName: json['bookName'] as String?,
      authorName: json['authorName'] as String?,
      publishDate: Book._dateTimeFromEpoch(json['publishDate'] as int),
      borrows: (json['borrows'] as List<dynamic>?)
              ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'bookName': instance.bookName,
      'authorName': instance.authorName,
      'publishDate': Book._dateTimeToEpoch(instance.publishDate),
      'borrows': Book._profileListToJson(instance.borrows),
    };
