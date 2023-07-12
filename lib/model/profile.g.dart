// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      photoUrl: json['photoUrl'] as String?,
      borrowDate: Profile._dateTimeFromEpoch(json['borrowDate'] as int),
      returnDate: Profile._dateTimeFromEpoch(json['returnDate'] as int),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'photoUrl': instance.photoUrl,
      'borrowDate': Profile._dateTimeToEpoch(instance.borrowDate),
      'returnDate': Profile._dateTimeToEpoch(instance.returnDate),
    };
