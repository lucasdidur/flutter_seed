DateTime? getDateTimeFromTimestamp(timestamp) {
  if (timestamp == null) return null;
  return (timestamp is String) ? DateTime.parse(timestamp) : timestamp.toDate();
}

String? getTimestampFromDateTime(DateTime? dateTime) {
  if (dateTime == null) return null;
  return dateTime.toIso8601String();
}
