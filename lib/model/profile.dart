import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String? name;
  final String? surname;
  final String? photoUrl;

  @JsonKey(toJson: _dateTimeToEpoch,fromJson: _dateTimeFromEpoch)
  final Timestamp? borrowDate;

  @JsonKey(toJson: _dateTimeToEpoch,fromJson: _dateTimeFromEpoch)
  final Timestamp? returnDate;

  Profile({
    this.name,
    this.surname,
    this.photoUrl,
    this.borrowDate,
    this.returnDate,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);



  static Timestamp? _dateTimeFromEpoch(int value) => Timestamp.fromMillisecondsSinceEpoch(value);

  static int _dateTimeToEpoch(Timestamp? timestamp) => timestamp!.millisecondsSinceEpoch;

}