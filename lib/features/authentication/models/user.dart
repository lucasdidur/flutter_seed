import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/json.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  String? id;

  String? email;

  String? username;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  String? phone;

  bool? onboarded;

  @JsonKey(
    name: 'date_of_birth',
    fromJson: getDateTimeFromTimestamp,
    toJson: getTimestampFromDateTime,
  )
  DateTime? dateOfBirth;

  @JsonKey(
    name: 'created_at',
    fromJson: getDateTimeFromTimestamp,
    toJson: getTimestampFromDateTime,
  )
  DateTime? createdAt;

  @JsonKey(
    name: 'last_login',
    fromJson: getDateTimeFromTimestamp,
    toJson: getTimestampFromDateTime,
  )
  DateTime? lastLogin;

  User({
    this.id,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.phone,
    this.onboarded,
    this.dateOfBirth,
    this.createdAt,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, firstName: $firstName, lastName: $lastName, phone: $phone, onboarded: $onboarded, dateOfBirth: $dateOfBirth, createdAt: $createdAt, lastLogin: $lastLogin)';
  }
}
