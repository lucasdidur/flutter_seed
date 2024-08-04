import '../models/feedback.dart';
import '../ui/new_feedback/new_feedback_view.dart';

abstract class FastFeedbackService {
  Future<void> submitFeedback(String feedback, FeedbackType type);

  Future<List<Feedback>> getLatestFeedback();
}
