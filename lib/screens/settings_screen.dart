import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../services/plan_service.dart';
import '../services/user_profile_service.dart';
import 'upgrade_screen.dart';
import '../widgets/glass_panel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _profileService = UserProfileService.instance;
  Future<void> _profileFuture = Future<void>.value();
  String _activeUserId = 'guest';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = Provider.of<AuthService>(context);
    final userId = auth.currentUser?.id ?? 'guest';
    if (_activeUserId != userId) {
      _activeUserId = userId;
      _profileFuture = _profileService.ensureLoaded(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final currentYear = DateTime.now().year;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.account_title)),
      body: FutureBuilder<void>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return ValueListenableBuilder<UserProfile>(
            valueListenable: _profileService.profileNotifier,
            builder: (context, profile, _) {
              return ValueListenableBuilder<PlanType>(
                valueListenable: PlanService.instance.planTypeListenable,
                builder: (context, plan, _) {
                  final isPro = plan == PlanType.pro;
                  final maxSteps = PlanService.instance.maxStepsPerTripForCurrentPlan();
                  final planName = isPro ? l10n.plan_pro : l10n.plan_free;
                  final planDescription = isPro
                      ? l10n.settings_plan_description_pro
                      : l10n.settings_plan_description_free(maxSteps);
                  return SafeArea(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                      children: [
                        Text(
                          l10n.settings_profile_section_title,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        _ProfileCard(
                          profile: profile,
                          user: auth.currentUser,
                          l10n: l10n,
                          onEdit: () => _onEditProfile(profile),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          l10n.settings_plan_section_title,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        _PlanCard(
                          planName: planName,
                          description: planDescription,
                          isPro: isPro,
                          l10n: l10n,
                          onUpgradeTap: () => _openUpgrade(context),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _handleLogout(auth),
                            icon: const Icon(Icons.logout),
                            label: Text(l10n.settings_logout_button),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Center(
                          child: Text(
                            'Copyright © $currentYear Katania91. All rights reserved.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _onEditProfile(UserProfile current) async {
    final l10n = AppLocalizations.of(context)!;
    final updated = await showDialog<UserProfile>(
      context: context,
      builder: (context) => _ProfileEditDialog(initialProfile: current, l10n: l10n),
    );
    if (updated != null) {
      await _profileService.saveProfile(_activeUserId, updated);
    }
  }

  Future<void> _handleLogout(AuthService auth) async {
    await auth.signOut();
    _profileService.clearCache();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _openUpgrade(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UpgradeScreen()),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final UserProfile profile;
  final AppUser? user;
  final AppLocalizations l10n;
  final VoidCallback onEdit;

  const _ProfileCard({required this.profile, required this.user, required this.l10n, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.yMMMd(localeName);
    final displayName = profile.fullName ?? _fallbackName(l10n, user);
    final email = user?.email;
    final birthLabel = profile.birthDate != null ? l10n.profile_birthdate_label(dateFormat.format(profile.birthDate!)) : null;
    final initials = profile.initials ?? _initialsFrom(displayName);
    final avatarImage = _avatarImage(profile.photoPath);

    return GlassPanel(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundImage: avatarImage,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                child: avatarImage == null
                    ? Text(
                        initials,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (email != null) ...[
                      const SizedBox(height: 4),
                      Text(email, style: theme.textTheme.bodyMedium),
                    ],
                    if (birthLabel != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        birthLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
              label: Text(l10n.profile_edit_button),
            ),
          ),
        ],
      ),
    );
  }

  String _initialsFrom(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    final first = parts.first.isNotEmpty ? parts.first[0].toUpperCase() : '';
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0].toUpperCase() : '';
    final value = '$first$last'.trim();
    return value.isEmpty ? '?' : value;
  }
}

String _fallbackName(AppLocalizations l10n, AppUser? user) {
  if (user == null || user.isGuest) {
    return l10n.guest_user;
  }
  return user.email ?? user.id;
}

class _PlanCard extends StatelessWidget {
  final bool isPro;
  final String planName;
  final String description;
  final AppLocalizations l10n;
  final VoidCallback onUpgradeTap;

  const _PlanCard({
    required this.isPro,
    required this.planName,
    required this.description,
    required this.l10n,
    required this.onUpgradeTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return GlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            planName,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 20),
          if (!isPro)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onUpgradeTap,
                child: Text(l10n.plan_upgrade),
              ),
            )
          else
            Row(
              children: [
                Icon(Icons.workspace_premium, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(l10n.plan_active, style: theme.textTheme.bodyMedium),
              ],
            ),
        ],
      ),
    );
  }
}

class _ProfileEditDialog extends StatefulWidget {
  final UserProfile initialProfile;
  final AppLocalizations l10n;

  const _ProfileEditDialog({required this.initialProfile, required this.l10n});

  @override
  State<_ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<_ProfileEditDialog> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  DateTime? _birthDate;
  String? _photoPath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialProfile.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.initialProfile.lastName ?? '');
    _birthDate = widget.initialProfile.birthDate;
    _photoPath = widget.initialProfile.photoPath;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.yMMMd(localeName);
    final previewImage = _avatarImage(_photoPath);

    return AlertDialog(
      title: Text(widget.l10n.profile_edit_title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: previewImage,
                  child: previewImage == null ? const Icon(Icons.person_outline, size: 28) : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickPhoto,
                        icon: const Icon(Icons.photo_camera_back_outlined),
                        label: Text(widget.l10n.profile_photo_change),
                      ),
                      if (_photoPath?.isNotEmpty == true)
                        TextButton(
                          onPressed: () => setState(() => _photoPath = null),
                          child: Text(widget.l10n.profile_photo_remove),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: widget.l10n.profile_first_name_label),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: widget.l10n.profile_last_name_label),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            Text(widget.l10n.profile_birthdate_title, style: theme.textTheme.labelMedium),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _birthDate != null ? dateFormat.format(_birthDate!) : widget.l10n.profile_birthdate_not_set,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: _pickBirthDate,
                  child: Text(widget.l10n.profile_birthdate_pick),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.l10n.btn_cancel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(widget.l10n.btn_save),
        ),
      ],
    );
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final initialDate = _birthDate ?? DateTime(now.year - 25, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  Future<void> _pickPhoto() async {
    final image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (image != null) {
      setState(() => _photoPath = image.path);
    }
  }

  void _submit() {
    final first = _firstNameController.text.trim();
    final last = _lastNameController.text.trim();
    final updated = UserProfile(
      firstName: first.isEmpty ? null : first,
      lastName: last.isEmpty ? null : last,
      birthDate: _birthDate,
      photoPath: _photoPath,
    );
    Navigator.of(context).pop(updated);
  }
}

ImageProvider? _avatarImage(String? path) {
  if (kIsWeb || path == null || path.isEmpty) {
    return null;
  }
  final file = File(path);
  if (!file.existsSync()) {
    return null;
  }
  return FileImage(file);
}
