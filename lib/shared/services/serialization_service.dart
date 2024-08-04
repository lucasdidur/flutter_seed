import 'package:injectable/injectable.dart';

@LazySingleton()
class SerializationService {
  DateTime? getDateTimeFromTimestamp(timestamp) {
    return (timestamp is String) ? DateTime.parse(timestamp) : timestamp.toDate();
  }

  getTimestampFromDateTime(DateTime? dateTime) {
    return dateTime!.toIso8601String();
  }
}
