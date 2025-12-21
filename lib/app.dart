import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'screens/achievements_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/travel_profile_screen.dart';
import 'screens/trips/trips_list.dart';
import 'screens/world_map_screen.dart';
import 'screens/year_in_review_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

class WorldTraceApp extends StatelessWidget {
  const WorldTraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final signedIn = auth.currentUser != null && !auth.currentUser!.isGuest;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.app_title,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('it'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('pt'),
        Locale('ja'),
        Locale('ru'),
        Locale('zh'),
        Locale('hi'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return const Locale('en');
        for (final supported in supportedLocales) {
          if (supported.languageCode == locale.languageCode) {
            return supported;
          }
        }
        return const Locale('en');
      },
      home: signedIn
          ? const HomeScreen()
          : (auth.currentUser != null && auth.currentUser!.isGuest
              ? const HomeScreen()
              : const AuthScreen()),
      routes: {
        '/home': (_) => const HomeScreen(),
        '/trips': (_) => const TripsListScreen(),
        '/stats': (_) => const StatsScreen(),
        '/goals': (_) => const GoalsScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/profile': (_) => const TravelProfileScreen(),
        '/world-map': (_) => const WorldMapScreen(),
        '/achievements': (_) => const AchievementsScreen(),
        '/year-review': (_) => const YearInReviewScreen(),
      },
    );
  }
}
