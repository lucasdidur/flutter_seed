import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app/injection/get_it.dart';
import '../../authentication/services/authentication_service.dart';
import '../models/feedback.dart';
import '../ui/new_feedback/new_feedback_view.dart';
import 'fast_feedback_service.dart';

@supabase
@LazySingleton(as: FastFeedbackService)
class SupabaseFeedbackService extends FastFeedbackService {
  SupabaseClient get _supabase => Supabase.instance.client;

  @override
  Future<List<Feedback>> getLatestFeedback() async {
    List<Map<String, dynamic>> response =
        await _supabase.from('feedback').select('*').order('created_at', ascending: false).limit(10);

    if (response.isEmpty) return [];
    return (response).map((e) => Feedback.fromJson(e)).toList();
  }

  @override
  Future<void> submitFeedback(String feedback, FeedbackType type) async {
    return _supabase.from('feedback').insert(Feedback(
          userId: sl<AuthenticationService>().id!,
          createdAt: DateTime.now(),
          message: feedback,
          type: type,
        ).toJson());
  }
}
