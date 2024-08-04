// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      onboarded: json['onboarded'] as bool?,
      dateOfBirth: getDateTimeFromTimestamp(json['date_of_birth']),
      createdAt: getDateTimeFromTimestamp(json['created_at']),
      lastLogin: getDateTimeFromTimestamp(json['last_login']),
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('username', instance.username);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('phone', instance.phone);
  writeNotNull('onboarded', instance.onboarded);
  writeNotNull('date_of_birth', getTimestampFromDateTime(instance.dateOfBirth));
  writeNotNull('created_at', getTimestampFromDateTime(instance.createdAt));
  writeNotNull('last_login', getTimestampFromDateTime(instance.lastLogin));
  return val;
}
