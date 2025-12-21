import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'WorldTrace'**
  String get app_title;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'WorldTrace'**
  String get home_title;

  /// No description provided for @drawer_home.
  ///
  /// In en, this message translates to:
  /// **'Home / Dashboard'**
  String get drawer_home;

  /// No description provided for @drawer_world_map.
  ///
  /// In en, this message translates to:
  /// **'World map'**
  String get drawer_world_map;

  /// No description provided for @drawer_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get drawer_trips;

  /// No description provided for @drawer_stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get drawer_stats;

  /// No description provided for @drawer_goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get drawer_goals;

  /// No description provided for @drawer_profile.
  ///
  /// In en, this message translates to:
  /// **'Travel profile'**
  String get drawer_profile;

  /// No description provided for @drawer_account.
  ///
  /// In en, this message translates to:
  /// **'Account / Settings'**
  String get drawer_account;

  /// No description provided for @gallery_title.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery_title;

  /// No description provided for @gallery_nav_label.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery_nav_label;

  /// No description provided for @gallery_profile_cta.
  ///
  /// In en, this message translates to:
  /// **'See all photos'**
  String get gallery_profile_cta;

  /// No description provided for @gallery_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No photos yet'**
  String get gallery_empty_title;

  /// No description provided for @gallery_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Add media to your trips and they\'ll appear here.'**
  String get gallery_empty_message;

  /// No description provided for @trips_title.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips_title;

  /// No description provided for @trip_detail_timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get trip_detail_timeline;

  /// No description provided for @trip_detail_empty_steps_message.
  ///
  /// In en, this message translates to:
  /// **'No steps yet. Start your travel story with the first note.'**
  String get trip_detail_empty_steps_message;

  /// No description provided for @trip_detail_day_header_steps.
  ///
  /// In en, this message translates to:
  /// **'{count} steps'**
  String trip_detail_day_header_steps(Object count);

  /// No description provided for @trip_detail_days_chip.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {{count} day} other {{count} days}}'**
  String trip_detail_days_chip(num count);

  /// No description provided for @trip_detail_section_timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get trip_detail_section_timeline;

  /// No description provided for @trip_detail_section_photos_trip.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get trip_detail_section_photos_trip;

  /// No description provided for @trip_edit_title_new.
  ///
  /// In en, this message translates to:
  /// **'New trip'**
  String get trip_edit_title_new;

  /// No description provided for @trip_edit_title_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get trip_edit_title_edit;

  /// No description provided for @trip_edit_button_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get trip_edit_button_save;

  /// No description provided for @trip_edit_button_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get trip_edit_button_create;

  /// No description provided for @trip_edit_field_country_iso_label.
  ///
  /// In en, this message translates to:
  /// **'Country ISO code'**
  String get trip_edit_field_country_iso_label;

  /// No description provided for @trip_edit_field_country_iso_help.
  ///
  /// In en, this message translates to:
  /// **'E.g. JP, US, IT'**
  String get trip_edit_field_country_iso_help;

  /// No description provided for @trip_edit_field_name_label.
  ///
  /// In en, this message translates to:
  /// **'Trip name'**
  String get trip_edit_field_name_label;

  /// No description provided for @trip_edit_field_notes_label.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get trip_edit_field_notes_label;

  /// No description provided for @trip_edit_button_start_date.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get trip_edit_button_start_date;

  /// No description provided for @trip_edit_button_end_date.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get trip_edit_button_end_date;

  /// No description provided for @trip_editor_new_title.
  ///
  /// In en, this message translates to:
  /// **'New trip'**
  String get trip_editor_new_title;

  /// No description provided for @trip_editor_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get trip_editor_edit_title;

  /// No description provided for @trip_editor_field_country_label.
  ///
  /// In en, this message translates to:
  /// **'Country ISO'**
  String get trip_editor_field_country_label;

  /// No description provided for @trip_editor_field_country_helper.
  ///
  /// In en, this message translates to:
  /// **'E.g. JP, US, IT'**
  String get trip_editor_field_country_helper;

  /// No description provided for @trip_editor_field_name_label.
  ///
  /// In en, this message translates to:
  /// **'Trip name'**
  String get trip_editor_field_name_label;

  /// No description provided for @trip_editor_field_description_label.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get trip_editor_field_description_label;

  /// No description provided for @trip_editor_field_start_date_label.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get trip_editor_field_start_date_label;

  /// No description provided for @trip_editor_field_end_date_label.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get trip_editor_field_end_date_label;

  /// No description provided for @trip_editor_date_range_days.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String trip_editor_date_range_days(Object days);

  /// No description provided for @trip_editor_error_country_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a country ISO code.'**
  String get trip_editor_error_country_required;

  /// No description provided for @trip_editor_error_name_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a trip name.'**
  String get trip_editor_error_name_required;

  /// No description provided for @trip_editor_error_dates_required.
  ///
  /// In en, this message translates to:
  /// **'Please select both a start and end date.'**
  String get trip_editor_error_dates_required;

  /// No description provided for @trip_editor_error_date_order.
  ///
  /// In en, this message translates to:
  /// **'End date cannot be before start date.'**
  String get trip_editor_error_date_order;

  /// No description provided for @trip_editor_save_button.
  ///
  /// In en, this message translates to:
  /// **'Save trip'**
  String get trip_editor_save_button;

  /// No description provided for @step_menu_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit step'**
  String get step_menu_edit;

  /// No description provided for @step_menu_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete step'**
  String get step_menu_delete;

  /// No description provided for @step_delete_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Delete step?'**
  String get step_delete_confirm_title;

  /// No description provided for @step_delete_confirm_body.
  ///
  /// In en, this message translates to:
  /// **'This note will be removed from the trip timeline.'**
  String get step_delete_confirm_body;

  /// No description provided for @step_editor_add_title.
  ///
  /// In en, this message translates to:
  /// **'New step'**
  String get step_editor_add_title;

  /// No description provided for @step_editor_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit step'**
  String get step_editor_edit_title;

  /// No description provided for @step_editor_field_description_label.
  ///
  /// In en, this message translates to:
  /// **'Step description'**
  String get step_editor_field_description_label;

  /// No description provided for @step_editor_field_place_label.
  ///
  /// In en, this message translates to:
  /// **'Place name (optional)'**
  String get step_editor_field_place_label;

  /// No description provided for @step_editor_field_date_time_label.
  ///
  /// In en, this message translates to:
  /// **'Date & time: {value}'**
  String step_editor_field_date_time_label(Object value);

  /// No description provided for @step_editor_hint_diary.
  ///
  /// In en, this message translates to:
  /// **'Write about this moment...'**
  String get step_editor_hint_diary;

  /// No description provided for @step_editor_header_add_place_hint.
  ///
  /// In en, this message translates to:
  /// **'Add where you are'**
  String get step_editor_header_add_place_hint;

  /// No description provided for @step_editor_place_hint.
  ///
  /// In en, this message translates to:
  /// **'City, place or landmark'**
  String get step_editor_place_hint;

  /// No description provided for @step_editor_button_add_photos.
  ///
  /// In en, this message translates to:
  /// **'Add photos'**
  String get step_editor_button_add_photos;

  /// No description provided for @step_editor_photos_selected.
  ///
  /// In en, this message translates to:
  /// **'{count} photos selected'**
  String step_editor_photos_selected(Object count);

  /// No description provided for @step_editor_error_pick_images.
  ///
  /// In en, this message translates to:
  /// **'Error while picking images.'**
  String get step_editor_error_pick_images;

  /// No description provided for @step_editor_error_empty_description.
  ///
  /// In en, this message translates to:
  /// **'Please add a short description for this step.'**
  String get step_editor_error_empty_description;

  /// No description provided for @step_media_add_web_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Adding photos is only supported on mobile and desktop.'**
  String get step_media_add_web_unsupported;

  /// No description provided for @generic_error_saving_step.
  ///
  /// In en, this message translates to:
  /// **'Unable to save the step. Please try again.'**
  String get generic_error_saving_step;

  /// No description provided for @fab_add_step_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add step'**
  String get fab_add_step_tooltip;

  /// No description provided for @fab_add_step_upgrade_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get fab_add_step_upgrade_tooltip;

  /// No description provided for @plan_limit_steps_reached_message.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the limit of {steps} steps per trip on the Free plan. Upgrade to Pro to keep journaling.'**
  String plan_limit_steps_reached_message(Object steps);

  /// No description provided for @plan_limit_steps_reached_generic.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the limit of steps for this plan. Upgrade to Pro to keep journaling.'**
  String get plan_limit_steps_reached_generic;

  /// No description provided for @btn_add_step.
  ///
  /// In en, this message translates to:
  /// **'Add step'**
  String get btn_add_step;

  /// No description provided for @btn_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get btn_save;

  /// No description provided for @btn_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btn_cancel;

  /// No description provided for @btn_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get btn_delete;

  /// No description provided for @on_this_day_title.
  ///
  /// In en, this message translates to:
  /// **'On this day'**
  String get on_this_day_title;

  /// No description provided for @on_this_day_empty.
  ///
  /// In en, this message translates to:
  /// **'No trip recorded on this day yet.'**
  String get on_this_day_empty;

  /// No description provided for @stats_title.
  ///
  /// In en, this message translates to:
  /// **'Global dashboard'**
  String get stats_title;

  /// No description provided for @stats_sign_in_prompt.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to see stats.'**
  String get stats_sign_in_prompt;

  /// No description provided for @stats_highlights_title.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get stats_highlights_title;

  /// No description provided for @stats_metric_trips_logged.
  ///
  /// In en, this message translates to:
  /// **'Trips logged'**
  String get stats_metric_trips_logged;

  /// No description provided for @stats_metric_travel_heavy_year.
  ///
  /// In en, this message translates to:
  /// **'Travel-heavy year'**
  String get stats_metric_travel_heavy_year;

  /// No description provided for @stats_metric_travel_heavy_year_value.
  ///
  /// In en, this message translates to:
  /// **'{year} - {days} days'**
  String stats_metric_travel_heavy_year_value(Object year, Object days);

  /// No description provided for @stats_value_not_available.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get stats_value_not_available;

  /// No description provided for @stats_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Add your first trip to unlock stats.'**
  String get stats_empty_message;

  /// No description provided for @stats_highlight_average_days.
  ///
  /// In en, this message translates to:
  /// **'Average days per trip'**
  String get stats_highlight_average_days;

  /// No description provided for @stats_highlight_longest_trip.
  ///
  /// In en, this message translates to:
  /// **'Longest trip'**
  String get stats_highlight_longest_trip;

  /// No description provided for @stats_highlight_longest_trip_value.
  ///
  /// In en, this message translates to:
  /// **'{days} days - {destination}'**
  String stats_highlight_longest_trip_value(Object days, Object destination);

  /// No description provided for @stats_highlight_recent_trip.
  ///
  /// In en, this message translates to:
  /// **'Most recent trip'**
  String get stats_highlight_recent_trip;

  /// No description provided for @stats_highlight_recent_trip_value.
  ///
  /// In en, this message translates to:
  /// **'{destination} - {date}'**
  String stats_highlight_recent_trip_value(Object destination, Object date);

  /// No description provided for @goals_title.
  ///
  /// In en, this message translates to:
  /// **'Travel goals'**
  String get goals_title;

  /// No description provided for @goals_new_goal_button.
  ///
  /// In en, this message translates to:
  /// **'New goal'**
  String get goals_new_goal_button;

  /// No description provided for @goals_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Create goal'**
  String get goals_dialog_title;

  /// No description provided for @goals_field_title_label.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get goals_field_title_label;

  /// No description provided for @goals_field_year_label.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get goals_field_year_label;

  /// No description provided for @goals_field_target_label.
  ///
  /// In en, this message translates to:
  /// **'Target countries'**
  String get goals_field_target_label;

  /// No description provided for @goals_delete_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete goal'**
  String get goals_delete_tooltip;

  /// No description provided for @goals_card_year_label.
  ///
  /// In en, this message translates to:
  /// **'Year {year}'**
  String goals_card_year_label(Object year);

  /// No description provided for @goals_card_progress_label.
  ///
  /// In en, this message translates to:
  /// **'{current} / {target} countries visited'**
  String goals_card_progress_label(Object current, Object target);

  /// No description provided for @goals_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No goals yet'**
  String get goals_empty_title;

  /// No description provided for @goals_empty_description.
  ///
  /// In en, this message translates to:
  /// **'Set your yearly country goal and we will track your progress automatically.'**
  String get goals_empty_description;

  /// No description provided for @goals_empty_cta.
  ///
  /// In en, this message translates to:
  /// **'Create a goal'**
  String get goals_empty_cta;

  /// No description provided for @account_title.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_title;

  /// No description provided for @plan_free.
  ///
  /// In en, this message translates to:
  /// **'WorldTrace Free'**
  String get plan_free;

  /// No description provided for @plan_upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get plan_upgrade;

  /// No description provided for @year_in_review_title.
  ///
  /// In en, this message translates to:
  /// **'Year in Review'**
  String get year_in_review_title;

  /// No description provided for @trip_story_title.
  ///
  /// In en, this message translates to:
  /// **'Trip Story'**
  String get trip_story_title;

  /// No description provided for @home_sign_in_prompt.
  ///
  /// In en, this message translates to:
  /// **'Please sign in or continue as guest to start tracking your trips.'**
  String get home_sign_in_prompt;

  /// No description provided for @generic_error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String generic_error(Object error);

  /// No description provided for @no_trips_yet.
  ///
  /// In en, this message translates to:
  /// **'No trips yet.'**
  String get no_trips_yet;

  /// No description provided for @stat_countries_visited.
  ///
  /// In en, this message translates to:
  /// **'Countries visited'**
  String get stat_countries_visited;

  /// No description provided for @stat_days_abroad.
  ///
  /// In en, this message translates to:
  /// **'Days abroad'**
  String get stat_days_abroad;

  /// No description provided for @stat_last_trip.
  ///
  /// In en, this message translates to:
  /// **'Last trip'**
  String get stat_last_trip;

  /// No description provided for @on_this_day_label.
  ///
  /// In en, this message translates to:
  /// **'On this day: {date}'**
  String on_this_day_label(Object date);

  /// No description provided for @btn_open_trip.
  ///
  /// In en, this message translates to:
  /// **'Open trip'**
  String get btn_open_trip;

  /// No description provided for @country_sheet_days.
  ///
  /// In en, this message translates to:
  /// **'Days: {count}'**
  String country_sheet_days(Object count);

  /// No description provided for @country_sheet_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips: {count}'**
  String country_sheet_trips(Object count);

  /// No description provided for @country_sheet_view_trips.
  ///
  /// In en, this message translates to:
  /// **'View trips in this country'**
  String get country_sheet_view_trips;

  /// No description provided for @country_sheet_add_trip.
  ///
  /// In en, this message translates to:
  /// **'Add trip'**
  String get country_sheet_add_trip;

  /// No description provided for @country_sheet_no_photos_title.
  ///
  /// In en, this message translates to:
  /// **'No photos here yet'**
  String get country_sheet_no_photos_title;

  /// No description provided for @country_sheet_no_photos_message.
  ///
  /// In en, this message translates to:
  /// **'Add media to your trips and they\'ll appear here.'**
  String get country_sheet_no_photos_message;

  /// No description provided for @country_overview_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Country overview'**
  String get country_overview_subtitle;

  /// No description provided for @country_overview_label_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get country_overview_label_trips;

  /// No description provided for @country_overview_label_days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get country_overview_label_days;

  /// No description provided for @country_overview_label_steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get country_overview_label_steps;

  /// No description provided for @country_overview_label_photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get country_overview_label_photos;

  /// No description provided for @country_overview_label_last_visited.
  ///
  /// In en, this message translates to:
  /// **'Last visited'**
  String get country_overview_label_last_visited;

  /// No description provided for @country_overview_last_visited_never.
  ///
  /// In en, this message translates to:
  /// **'Never visited'**
  String get country_overview_last_visited_never;

  /// No description provided for @country_overview_empty_trips_message.
  ///
  /// In en, this message translates to:
  /// **'Add your first trip in this country to unlock insights.'**
  String get country_overview_empty_trips_message;

  /// No description provided for @country_overview_action_view_trips.
  ///
  /// In en, this message translates to:
  /// **'View trips'**
  String get country_overview_action_view_trips;

  /// No description provided for @country_overview_action_add_trip.
  ///
  /// In en, this message translates to:
  /// **'Add a trip'**
  String get country_overview_action_add_trip;

  /// No description provided for @country_overview_action_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get country_overview_action_close;

  /// No description provided for @guest_user.
  ///
  /// In en, this message translates to:
  /// **'Guest user'**
  String get guest_user;

  /// No description provided for @plan_active.
  ///
  /// In en, this message translates to:
  /// **'Active plan'**
  String get plan_active;

  /// No description provided for @auth_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to WorldTrace'**
  String get auth_welcome;

  /// No description provided for @auth_login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get auth_login;

  /// No description provided for @auth_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get auth_signup;

  /// No description provided for @auth_continue_guest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get auth_continue_guest;

  /// No description provided for @trip_deleted.
  ///
  /// In en, this message translates to:
  /// **'Trip deleted.'**
  String get trip_deleted;

  /// No description provided for @trip_menu_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete trip'**
  String get trip_menu_delete;

  /// No description provided for @trip_delete_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Delete this trip?'**
  String get trip_delete_confirm_title;

  /// No description provided for @trip_delete_confirm_body.
  ///
  /// In en, this message translates to:
  /// **'The trip and all its steps will be permanently removed.'**
  String get trip_delete_confirm_body;

  /// No description provided for @trip_delete_missing_id_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete a trip without an ID.'**
  String get trip_delete_missing_id_error;

  /// No description provided for @menu_open_details.
  ///
  /// In en, this message translates to:
  /// **'Open details'**
  String get menu_open_details;

  /// No description provided for @menu_delete_trip.
  ///
  /// In en, this message translates to:
  /// **'Delete trip'**
  String get menu_delete_trip;

  /// No description provided for @tooltip_add_trip.
  ///
  /// In en, this message translates to:
  /// **'Add trip'**
  String get tooltip_add_trip;

  /// No description provided for @drawer_achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get drawer_achievements;

  /// No description provided for @achievements_sign_in_prompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view your achievements.'**
  String get achievements_sign_in_prompt;

  /// No description provided for @year_in_review_share_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Share year story'**
  String get year_in_review_share_tooltip;

  /// No description provided for @year_in_review_sign_in_prompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in to see your Year in Review.'**
  String get year_in_review_sign_in_prompt;

  /// No description provided for @year_in_review_no_trips.
  ///
  /// In en, this message translates to:
  /// **'Add a few trips to unlock your review.'**
  String get year_in_review_no_trips;

  /// No description provided for @year_in_review_no_data_for_year.
  ///
  /// In en, this message translates to:
  /// **'Review not available for this year.'**
  String get year_in_review_no_data_for_year;

  /// No description provided for @year_in_review_map_title.
  ///
  /// In en, this message translates to:
  /// **'Travel map {year}'**
  String year_in_review_map_title(Object year);

  /// No description provided for @year_in_review_story_title.
  ///
  /// In en, this message translates to:
  /// **'Your {year} in travel'**
  String year_in_review_story_title(Object year);

  /// No description provided for @year_in_review_story_summary.
  ///
  /// In en, this message translates to:
  /// **'{days} days - {trips} trips - {countries} countries'**
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  );

  /// No description provided for @year_in_review_longest_trip.
  ///
  /// In en, this message translates to:
  /// **'Longest trip'**
  String get year_in_review_longest_trip;

  /// No description provided for @year_in_review_longest_trip_value.
  ///
  /// In en, this message translates to:
  /// **'{title} - {days} days'**
  String year_in_review_longest_trip_value(Object title, Object days);

  /// No description provided for @year_in_review_top_country.
  ///
  /// In en, this message translates to:
  /// **'Top country'**
  String get year_in_review_top_country;

  /// No description provided for @year_in_review_top_country_value.
  ///
  /// In en, this message translates to:
  /// **'{country} - {days} days'**
  String year_in_review_top_country_value(Object country, Object days);

  /// No description provided for @year_in_review_no_photo_highlights.
  ///
  /// In en, this message translates to:
  /// **'No photo highlights yet'**
  String get year_in_review_no_photo_highlights;

  /// No description provided for @year_in_review_no_achievements.
  ///
  /// In en, this message translates to:
  /// **'No achievements unlocked (yet).'**
  String get year_in_review_no_achievements;

  /// No description provided for @year_in_review_unlocked_achievements.
  ///
  /// In en, this message translates to:
  /// **'Unlocked achievements'**
  String get year_in_review_unlocked_achievements;

  /// No description provided for @year_in_review_render_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to generate the image.'**
  String get year_in_review_render_error;

  /// No description provided for @year_in_review_encode_error.
  ///
  /// In en, this message translates to:
  /// **'Error while creating the image.'**
  String get year_in_review_encode_error;

  /// No description provided for @year_in_review_share_message.
  ///
  /// In en, this message translates to:
  /// **'My {year} in travel with WorldTrace'**
  String year_in_review_share_message(Object year);

  /// No description provided for @year_in_review_share_failed.
  ///
  /// In en, this message translates to:
  /// **'Share failed: {error}'**
  String year_in_review_share_failed(Object error);

  /// No description provided for @trip_story_share_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Share story'**
  String get trip_story_share_tooltip;

  /// No description provided for @trip_story_share_render_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to generate the story.'**
  String get trip_story_share_render_error;

  /// No description provided for @trip_story_share_image_error.
  ///
  /// In en, this message translates to:
  /// **'Error while creating the image.'**
  String get trip_story_share_image_error;

  /// No description provided for @trip_story_share_message.
  ///
  /// In en, this message translates to:
  /// **'My trip in {country} with WorldTrace'**
  String trip_story_share_message(Object country);

  /// No description provided for @trip_story_share_failed.
  ///
  /// In en, this message translates to:
  /// **'Share failed: {error}'**
  String trip_story_share_failed(Object error);

  /// No description provided for @trip_story_stat_steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get trip_story_stat_steps;

  /// No description provided for @trip_story_stat_photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get trip_story_stat_photos;

  /// No description provided for @trip_story_stat_days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get trip_story_stat_days;

  /// No description provided for @settings_profile_section_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settings_profile_section_title;

  /// No description provided for @settings_plan_section_title.
  ///
  /// In en, this message translates to:
  /// **'WorldTrace plan'**
  String get settings_plan_section_title;

  /// No description provided for @settings_logout_button.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settings_logout_button;

  /// No description provided for @plan_pro.
  ///
  /// In en, this message translates to:
  /// **'WorldTrace Pro'**
  String get plan_pro;

  /// No description provided for @settings_plan_description_pro.
  ///
  /// In en, this message translates to:
  /// **'Unlimited timelines and premium travel tools.'**
  String get settings_plan_description_pro;

  /// No description provided for @settings_plan_description_free.
  ///
  /// In en, this message translates to:
  /// **'Up to {steps} steps per trip. Upgrade to Pro to unlock unlimited timelines and advanced stats.'**
  String settings_plan_description_free(Object steps);

  /// No description provided for @profile_birthdate_label.
  ///
  /// In en, this message translates to:
  /// **'Born on {date}'**
  String profile_birthdate_label(Object date);

  /// No description provided for @profile_birthdate_not_set.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get profile_birthdate_not_set;

  /// No description provided for @profile_edit_button.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profile_edit_button;

  /// No description provided for @profile_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profile_edit_title;

  /// No description provided for @profile_photo_change.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get profile_photo_change;

  /// No description provided for @profile_photo_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get profile_photo_remove;

  /// No description provided for @profile_first_name_label.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get profile_first_name_label;

  /// No description provided for @profile_last_name_label.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get profile_last_name_label;

  /// No description provided for @profile_birthdate_title.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get profile_birthdate_title;

  /// No description provided for @profile_birthdate_pick.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get profile_birthdate_pick;

  /// No description provided for @plan_support_thanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks for supporting WorldTrace!'**
  String get plan_support_thanks;

  /// No description provided for @profile_plan_section_title.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get profile_plan_section_title;

  /// No description provided for @profile_plan_current_pro.
  ///
  /// In en, this message translates to:
  /// **'Current plan: Pro - unlimited steps per trip.'**
  String get profile_plan_current_pro;

  /// No description provided for @profile_plan_current_free.
  ///
  /// In en, this message translates to:
  /// **'Current plan: Free - up to {steps} steps per trip.'**
  String profile_plan_current_free(Object steps);

  /// No description provided for @profile_sign_in_prompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view your travel profile.'**
  String get profile_sign_in_prompt;

  /// No description provided for @profile_no_data.
  ///
  /// In en, this message translates to:
  /// **'No data available.'**
  String get profile_no_data;

  /// No description provided for @profile_travel_summary_title.
  ///
  /// In en, this message translates to:
  /// **'Travel summary'**
  String get profile_travel_summary_title;

  /// No description provided for @profile_stat_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get profile_stat_trips;

  /// No description provided for @profile_stat_countries.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get profile_stat_countries;

  /// No description provided for @profile_stat_days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get profile_stat_days;

  /// No description provided for @profile_top_year_text.
  ///
  /// In en, this message translates to:
  /// **'Most intense year: {year} - {days} days'**
  String profile_top_year_text(Object year, Object days);

  /// No description provided for @profile_top_year_empty.
  ///
  /// In en, this message translates to:
  /// **'Start logging your trips to unlock yearly stats.'**
  String get profile_top_year_empty;

  /// No description provided for @profile_achievements_title.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get profile_achievements_title;

  /// No description provided for @profile_see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get profile_see_all;

  /// No description provided for @profile_achievements_progress.
  ///
  /// In en, this message translates to:
  /// **'Unlocked achievements: {unlocked} of {total}'**
  String profile_achievements_progress(Object unlocked, Object total);

  /// No description provided for @profile_goals_title.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get profile_goals_title;

  /// No description provided for @profile_goals_manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get profile_goals_manage;

  /// No description provided for @profile_goals_empty.
  ///
  /// In en, this message translates to:
  /// **'Set a yearly country goal to track your progress here.'**
  String get profile_goals_empty;

  /// No description provided for @profile_goal_progress_label.
  ///
  /// In en, this message translates to:
  /// **'Year {year} - {current}/{target} countries'**
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  );

  /// No description provided for @profile_view_year_button.
  ///
  /// In en, this message translates to:
  /// **'See your year'**
  String get profile_view_year_button;

  /// No description provided for @profile_share_button.
  ///
  /// In en, this message translates to:
  /// **'Share my profile'**
  String get profile_share_button;

  /// No description provided for @profile_share_no_trips.
  ///
  /// In en, this message translates to:
  /// **'I\'m starting to track my trips with WorldTrace. Follow me on my next adventure!'**
  String get profile_share_no_trips;

  /// No description provided for @profile_share_stats.
  ///
  /// In en, this message translates to:
  /// **'I\'ve logged {trips} trips, visited {countries} countries, and spent {days} days traveling with WorldTrace.'**
  String profile_share_stats(Object trips, Object countries, Object days);

  /// No description provided for @profile_share_top_year.
  ///
  /// In en, this message translates to:
  /// **'My most intense year was {year} with {days} days on the road.'**
  String profile_share_top_year(Object year, Object days);

  /// No description provided for @step_detail_section_story.
  ///
  /// In en, this message translates to:
  /// **'Story'**
  String get step_detail_section_story;

  /// No description provided for @step_detail_story_empty.
  ///
  /// In en, this message translates to:
  /// **'No story was added for this step.'**
  String get step_detail_story_empty;

  /// No description provided for @step_detail_section_photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get step_detail_section_photos;

  /// No description provided for @step_detail_action_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get step_detail_action_share;

  /// No description provided for @step_media_web_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Image sharing is not supported on the web.'**
  String get step_media_web_unsupported;

  /// No description provided for @step_media_image_missing.
  ///
  /// In en, this message translates to:
  /// **'Image not found on this device.'**
  String get step_media_image_missing;

  /// No description provided for @step_media_share_text.
  ///
  /// In en, this message translates to:
  /// **'A snap from my trip with WorldTrace'**
  String get step_media_share_text;

  /// No description provided for @step_media_share_failed.
  ///
  /// In en, this message translates to:
  /// **'Unable to share this image.'**
  String get step_media_share_failed;

  /// No description provided for @step_media_title.
  ///
  /// In en, this message translates to:
  /// **'Photo {current}/{total}'**
  String step_media_title(Object current, Object total);

  /// No description provided for @step_media_share_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get step_media_share_tooltip;

  /// No description provided for @upgrade_title.
  ///
  /// In en, this message translates to:
  /// **'Unlock WorldTrace Pro'**
  String get upgrade_title;

  /// No description provided for @upgrade_headline.
  ///
  /// In en, this message translates to:
  /// **'Upgrade without limits'**
  String get upgrade_headline;

  /// No description provided for @upgrade_description.
  ///
  /// In en, this message translates to:
  /// **'Go Pro to keep telling your stories with unlimited timelines and traveler-focused tools.'**
  String get upgrade_description;

  /// No description provided for @upgrade_benefit_unlimited_steps.
  ///
  /// In en, this message translates to:
  /// **'No step limits per trip'**
  String get upgrade_benefit_unlimited_steps;

  /// No description provided for @upgrade_benefit_advanced_stats.
  ///
  /// In en, this message translates to:
  /// **'Advanced stats and goals (coming soon)'**
  String get upgrade_benefit_advanced_stats;

  /// No description provided for @upgrade_benefit_heavy_users.
  ///
  /// In en, this message translates to:
  /// **'Built for heavy travelers'**
  String get upgrade_benefit_heavy_users;

  /// No description provided for @upgrade_benefit_early_access.
  ///
  /// In en, this message translates to:
  /// **'Early access to experimental features'**
  String get upgrade_benefit_early_access;

  /// No description provided for @upgrade_success_message.
  ///
  /// In en, this message translates to:
  /// **'WorldTrace Pro activated!'**
  String get upgrade_success_message;

  /// No description provided for @upgrade_maybe_later.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get upgrade_maybe_later;

  /// No description provided for @home_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get home_welcome_title;

  /// No description provided for @home_next_trip_prompt.
  ///
  /// In en, this message translates to:
  /// **'Ready to log your next trip?'**
  String get home_next_trip_prompt;

  /// No description provided for @world_map_sign_in_prompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in or continue as guest to view your travel map.'**
  String get world_map_sign_in_prompt;

  /// No description provided for @world_map_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Add your first trip to see the map.'**
  String get world_map_empty_message;

  /// No description provided for @trip_story_open_failed.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the Trip Story: {error}'**
  String trip_story_open_failed(Object error);

  /// No description provided for @photo_viewer_web_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Full-screen photo viewing is only supported on mobile and desktop.'**
  String get photo_viewer_web_unsupported;

  /// No description provided for @onboarding_track_countries_title.
  ///
  /// In en, this message translates to:
  /// **'Track countries'**
  String get onboarding_track_countries_title;

  /// No description provided for @onboarding_track_countries_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add trips, memories, and stats'**
  String get onboarding_track_countries_subtitle;

  /// No description provided for @onboarding_set_goals_title.
  ///
  /// In en, this message translates to:
  /// **'Set goals'**
  String get onboarding_set_goals_title;

  /// No description provided for @onboarding_set_goals_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create targets like \"30 countries by 2030\"'**
  String get onboarding_set_goals_subtitle;

  /// No description provided for @onboarding_share_remember_title.
  ///
  /// In en, this message translates to:
  /// **'Share & remember'**
  String get onboarding_share_remember_title;

  /// No description provided for @onboarding_share_remember_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create shareable cards of your travels'**
  String get onboarding_share_remember_subtitle;

  /// No description provided for @achievement_first_trip_title.
  ///
  /// In en, this message translates to:
  /// **'First trip logged'**
  String get achievement_first_trip_title;

  /// No description provided for @achievement_first_trip_description.
  ///
  /// In en, this message translates to:
  /// **'Log your very first trip in WorldTrace.'**
  String get achievement_first_trip_description;

  /// No description provided for @achievement_five_trips_title.
  ///
  /// In en, this message translates to:
  /// **'Five trips club'**
  String get achievement_five_trips_title;

  /// No description provided for @achievement_five_trips_description.
  ///
  /// In en, this message translates to:
  /// **'Reach five trips recorded in your journal.'**
  String get achievement_five_trips_description;

  /// No description provided for @achievement_ten_trips_title.
  ///
  /// In en, this message translates to:
  /// **'Ten trips milestone'**
  String get achievement_ten_trips_title;

  /// No description provided for @achievement_ten_trips_description.
  ///
  /// In en, this message translates to:
  /// **'Plan and log at least ten adventures.'**
  String get achievement_ten_trips_description;

  /// No description provided for @achievement_five_countries_title.
  ///
  /// In en, this message translates to:
  /// **'Globetrotter I'**
  String get achievement_five_countries_title;

  /// No description provided for @achievement_five_countries_description.
  ///
  /// In en, this message translates to:
  /// **'Visit five different countries.'**
  String get achievement_five_countries_description;

  /// No description provided for @achievement_ten_countries_title.
  ///
  /// In en, this message translates to:
  /// **'Globetrotter II'**
  String get achievement_ten_countries_title;

  /// No description provided for @achievement_ten_countries_description.
  ///
  /// In en, this message translates to:
  /// **'Reach ten unique countries.'**
  String get achievement_ten_countries_description;

  /// No description provided for @achievement_thirty_days_title.
  ///
  /// In en, this message translates to:
  /// **'30 days in a year'**
  String get achievement_thirty_days_title;

  /// No description provided for @achievement_thirty_days_description.
  ///
  /// In en, this message translates to:
  /// **'Spend 30+ days traveling within the same year.'**
  String get achievement_thirty_days_description;

  /// No description provided for @achievement_hundred_days_title.
  ///
  /// In en, this message translates to:
  /// **'100 days on the road'**
  String get achievement_hundred_days_title;

  /// No description provided for @achievement_hundred_days_description.
  ///
  /// In en, this message translates to:
  /// **'Accumulate one hundred travel days overall.'**
  String get achievement_hundred_days_description;

  /// No description provided for @auth_continue_email.
  ///
  /// In en, this message translates to:
  /// **'Continue with email'**
  String get auth_continue_email;

  /// No description provided for @auth_continue_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get auth_continue_google;

  /// No description provided for @auth_continue_facebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get auth_continue_facebook;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
