import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/injection/get_it.dart';
import '../../../core/utils/constants.dart';
import 'tab_one_view.dart';
import 'tab_two_view.dart';
import 'widgets/drawer.dart';
import 'widgets/rail.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  void setIndex(int val) {
    setState(() => index = val);
  }

  @override
  void initState() {
    sl<SharedPreferences>().setInt('open_count', (sl<SharedPreferences>().getInt('open_count') ?? 0) + 1);

    int openCount = sl<SharedPreferences>().getInt('open_count') ?? 0;

    if (openCount == 3) {
      final InAppReview inAppReview = InAppReview.instance;

      inAppReview.isAvailable().then((bool isAvailable) {
        if (isAvailable) {
          inAppReview.requestReview();
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool xsmallScreen = constraints.maxWidth <= Breakpoints.xs;
      bool smallScreen = constraints.maxWidth >= Breakpoints.xs && constraints.maxWidth < Breakpoints.sm;
      bool mediumScreen = constraints.maxWidth >= Breakpoints.sm && constraints.maxWidth < Breakpoints.md;
      bool largeScreen = constraints.maxWidth >= Breakpoints.md && constraints.maxWidth < Breakpoints.lg;
      bool xlargeScreen = constraints.maxWidth >= Breakpoints.lg;

      return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: xsmallScreen ? HomeDrawer() : null,
          appBar: xsmallScreen
              ? AppBar(
                  bottom: TabBar(
                    tabs: [
                      const Tab(
                        // icon: Icon(Icons.home),
                        text: 'One',
                      ),
                      const Tab(
                        //icon: Icon(Icons.rss_feed),
                        text: 'Two',
                      ),
                    ],
                  ),
                )
              : null,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (largeScreen || xlargeScreen) ...[const HomeDrawer(), VerticalDivider(width: 2)],
              if (smallScreen || mediumScreen) ...[HomeRail(), VerticalDivider(width: 2)],
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          children: [
                            TabOneView(),
                            TabTwoView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (smallScreen || mediumScreen) ...[VerticalDivider(width: 2), SizedBox(width: 200)],
              if (largeScreen || xlargeScreen) ...[VerticalDivider(width: 2), SizedBox(width: 400)]
            ],
          ),
          /* bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            backgroundColor: context.primaryContainer,
            onTap: (index) {
              setIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: 'Feed'),
            ],
          ), */
        ),
      );
    });
  }
}
