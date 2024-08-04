import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../app/injection/get_it.dart';
import '../../../../app/router/router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/ui/layout.dart';
import '../../../../shared/ui/loading_overlay.dart';
import '../../services/fast_feedback_service.dart';

enum FeedbackType {
  bug,
  feature,
  other,
}

@RoutePage()
class NewFeedbackView extends StatelessWidget {
  NewFeedbackView({super.key});

  final TextEditingController feedbackController = TextEditingController();

  final ValueNotifier<bool> loading = ValueNotifier(false);

  void setLoading(bool val) {
    loading.value = val;
  }

  final ValueNotifier<FeedbackType?> type = ValueNotifier(null);

  void setType(FeedbackType val) {
    type.value = val;
  }

  Future<void> submitFeedback() async {
    assert(type.value != null, 'Feedback type must be selected');
    assert(feedbackController.text.isNotEmpty, 'Feedback message must not be empty');

    setLoading(true);
    await sl<FastFeedbackService>().submitFeedback(feedbackController.text, type.value!);
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Feedback')),
      body: Layout(
        child: ValueListenableBuilder(
            valueListenable: loading,
            builder: (context, loading, child) {
              return Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      const Text('What type of feedback do you have?'),
                      gap12,
                      ValueListenableBuilder(
                          valueListenable: type,
                          builder: (context, value, child) {
                            return LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  for (FeedbackType type in FeedbackType.values)
                                    SizedBox(
                                      width: (constraints.maxWidth / 3) - 8,
                                      child: FilterChip(
                                        selected: value == type,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        label: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(type.name.toUpperCase()),
                                          ],
                                        ),
                                        onSelected: (value) {
                                          setType(type);
                                        },
                                      ),
                                    ),
                                ],
                              );
                            });
                          }),
                      gap16,
                      TextField(
                        controller: feedbackController,
                        maxLines: null,
                        decoration: const InputDecoration(labelText: 'Feedback', border: OutlineInputBorder()),
                      ),
                      gap16,
                      ElevatedButton(
                          onPressed: () async {
                            if (feedbackController.text.trim().isEmpty || type.value == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text('Please fill out all fields.')));
                            } else {
                              FocusScope.of(context).unfocus();
                              await submitFeedback().then((value) {
                                sl<AppRouter>().maybePop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text('Feedback submitted!')));
                              }).onError((error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                                setLoading(false);
                              });
                            }
                          },
                          child: Text(
                            'Submit',
                            style: context.titleLarge.onPrimary.bold,
                          ))
                    ],
                  ),
                  if (loading) const Positioned.fill(child: LoadingOverlay()),
                ],
              );
            }),
      ),
    );
  }
}
