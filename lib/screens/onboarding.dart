import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pc = PageController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pc,
                children: [
                  _page(
                    l10n.onboarding_track_countries_title,
                    l10n.onboarding_track_countries_subtitle,
                  ),
                  _page(
                    l10n.onboarding_set_goals_title,
                    l10n.onboarding_set_goals_subtitle,
                  ),
                  _page(
                    l10n.onboarding_share_remember_title,
                    l10n.onboarding_share_remember_subtitle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        await auth.signInAsGuest();
                        if (!mounted) return;
                        navigator.pushReplacementNamed('/home');
                      },
                      child: Text(l10n.auth_continue_guest),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _page(String title, String subtitle) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(subtitle, style: const TextStyle(fontSize: 18)),
            const Spacer(),
          ],
        ),
      );
}
