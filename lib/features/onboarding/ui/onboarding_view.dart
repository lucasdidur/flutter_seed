import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/injection/get_it.dart';
import '../../../shared/services/navigation_service.dart';
import 'widgets/page_one.dart';
import 'widgets/page_three.dart';
import 'widgets/page_two.dart';

@RoutePage()
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          PageOne(),
          PageTwo(),
          PageThree(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (pageController.page == 2) {
            await sl<SharedPreferences>().setBool('onboarded', true);
            sl<NavigationService>().navigateToHome();
          } else if (pageController.page == 1) {
            pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          } else if (pageController.page == 0) {
            pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
