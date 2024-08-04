import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/json.dart';
import '../ui/new_feedback/new_feedback_view.dart';

part 'feedback.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Feedback {
  int? id;

  final String message;

  @JsonKey(name: 'user_id')
  String? userId;

  @JsonKey(name: 'created_at', fromJson: getDateTimeFromTimestamp, toJson: getTimestampFromDateTime)
  final DateTime? createdAt;

  /// bug, feature, other
  final FeedbackType type;

  Feedback({
    required this.message,
    required this.type,
    required this.createdAt,
    this.id,
    this.userId,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
