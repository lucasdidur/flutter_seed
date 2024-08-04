import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/injection/get_it.dart';
import '../../app/router/router.dart';

String? _fontFamily = GoogleFonts.quicksand().fontFamily;
FlexScheme flexScheme = FlexScheme.flutterDash;

PageTransitionsTheme? pageTransitionsTheme = PageTransitionsTheme(
  builders: kIsWeb
      ? {
          // No animations for every OS if the app running on the web
          for (final platform in TargetPlatform.values) platform: const NoTransitionsBuilder(),
        }
      : {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
);

// https://docs.flexcolorscheme.com/api_guide#flexsubthemesdata
FlexSubThemesData theme = FlexSubThemesData(
  appBarCenterTitle: false,
  tabBarIndicatorSize: TabBarIndicatorSize.label,
  inputDecoratorRadius: 8,
);

ThemeData lightTheme = FlexThemeData.light(
  fontFamily: _fontFamily,
  scheme: flexScheme,
  colorScheme: lightLogoColorScheme,
  subThemesData: theme,
  pageTransitionsTheme: pageTransitionsTheme,
);

ThemeData darkTheme = FlexThemeData.dark(
  fontFamily: _fontFamily,
  scheme: flexScheme,
  colorScheme: darkLogoColorScheme,
  subThemesData: theme,
  pageTransitionsTheme: pageTransitionsTheme,
);

ColorScheme? lightLogoColorScheme;
ColorScheme? darkLogoColorScheme;

extension FastColor on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primary => colorScheme.primary;

  Color get secondary => colorScheme.secondary;

  Color get tertiary => colorScheme.tertiary;

  Color get primaryContainer => colorScheme.primaryContainer;

  Color get secondaryContainer => colorScheme.secondaryContainer;

  Color get tertiaryContainer => colorScheme.tertiaryContainer;

  Color get onPrimary => colorScheme.onPrimary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get onTertiary => colorScheme.onTertiary;

  Color get background => colorScheme.surface;

  Color get onBackground => colorScheme.onSurface;

  Color get surface => colorScheme.surface;

  Color get onSurface => colorScheme.onSurface;

  Color get surfaceTint => colorScheme.surfaceTint;

  Color get error => colorScheme.error;

  Color get onError => colorScheme.onError;

  Color get outline => colorScheme.outline;

  Color get inversePrimary => colorScheme.inversePrimary;

  Color get inverseSurface => colorScheme.inverseSurface;

  Color get onInverseSurface => colorScheme.onInverseSurface;
}

extension FastTextStyle on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get bodySmall => textTheme.bodySmall!;

  TextStyle get bodyMedium => textTheme.bodyMedium!;

  TextStyle get bodyLarge => textTheme.bodyLarge!;

  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get labelMedium => textTheme.labelMedium!;

  TextStyle get labelLarge => textTheme.labelLarge!;

  TextStyle get titleSmall => textTheme.titleSmall!;

  TextStyle get titleMedium => textTheme.titleMedium!;

  TextStyle get titleLarge => textTheme.titleLarge!;

  TextStyle get headlineSmall => textTheme.headlineSmall!;

  TextStyle get headlineMedium => textTheme.headlineMedium!;

  TextStyle get headlineLarge => textTheme.headlineLarge!;

  TextStyle get displaySmall => textTheme.displaySmall!;

  TextStyle get displayMedium => textTheme.displayMedium!;

  TextStyle get displayLarge => textTheme.displayLarge!;
}

extension FastTextColor on TextStyle {
  BuildContext get context => sl<AppRouter>().navigatorKey.currentContext!;

  TextStyle get primary => copyWith(color: Theme.of(context).colorScheme.primary);

  TextStyle get secondary => copyWith(color: Theme.of(context).colorScheme.secondary);

  TextStyle get tertiary => copyWith(color: Theme.of(context).colorScheme.tertiary);

  TextStyle get onPrimary => copyWith(color: Theme.of(context).colorScheme.onPrimary);

  TextStyle get onSecondary => copyWith(color: Theme.of(context).colorScheme.onSecondary);

  TextStyle get onTertiary => copyWith(color: Theme.of(context).colorScheme.onTertiary);

  TextStyle get background => copyWith(color: Theme.of(context).colorScheme.surface);

  TextStyle get onBackground => copyWith(color: Theme.of(context).colorScheme.onSurface);

  TextStyle get surface => copyWith(color: Theme.of(context).colorScheme.surface);

  TextStyle get onSurface => copyWith(color: Theme.of(context).colorScheme.onSurface);

  TextStyle get surfaceTint => copyWith(color: Theme.of(context).colorScheme.surfaceTint);

  TextStyle get error => copyWith(color: Theme.of(context).colorScheme.error);

  TextStyle get onError => copyWith(color: Theme.of(context).colorScheme.onError);

  TextStyle get outline => copyWith(color: Theme.of(context).colorScheme.outline);

  TextStyle get inversePrimary => copyWith(color: Theme.of(context).colorScheme.inversePrimary);

  TextStyle get inverseSurface => copyWith(color: Theme.of(context).colorScheme.inverseSurface);

  TextStyle get onInverseSurface => copyWith(color: Theme.of(context).colorScheme.onInverseSurface);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}
