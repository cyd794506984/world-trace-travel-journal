// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'Home / Dashboard';

  @override
  String get drawer_world_map => 'World map';

  @override
  String get drawer_trips => 'Trips';

  @override
  String get drawer_stats => 'Stats';

  @override
  String get drawer_goals => 'Goals';

  @override
  String get drawer_profile => 'Travel profile';

  @override
  String get drawer_account => 'Account / Settings';

  @override
  String get gallery_title => 'Gallery';

  @override
  String get gallery_nav_label => 'Gallery';

  @override
  String get gallery_profile_cta => 'See all photos';

  @override
  String get gallery_empty_title => 'No photos yet';

  @override
  String get gallery_empty_message =>
      'Add media to your trips and they\'ll appear here.';

  @override
  String get trips_title => 'Trips';

  @override
  String get trip_detail_timeline => 'Timeline';

  @override
  String get trip_detail_empty_steps_message =>
      'No steps yet. Start your travel story with the first note.';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count steps';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'Timeline';

  @override
  String get trip_detail_section_photos_trip => 'Photos';

  @override
  String get trip_edit_title_new => 'New trip';

  @override
  String get trip_edit_title_edit => 'Edit trip';

  @override
  String get trip_edit_button_save => 'Save';

  @override
  String get trip_edit_button_create => 'Create';

  @override
  String get trip_edit_field_country_iso_label => 'Country ISO code';

  @override
  String get trip_edit_field_country_iso_help => 'E.g. JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'Trip name';

  @override
  String get trip_edit_field_notes_label => 'Notes (optional)';

  @override
  String get trip_edit_button_start_date => 'Start date';

  @override
  String get trip_edit_button_end_date => 'End date';

  @override
  String get trip_editor_new_title => 'New trip';

  @override
  String get trip_editor_edit_title => 'Edit trip';

  @override
  String get trip_editor_field_country_label => 'Country ISO';

  @override
  String get trip_editor_field_country_helper => 'E.g. JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'Trip name';

  @override
  String get trip_editor_field_description_label => 'Notes (optional)';

  @override
  String get trip_editor_field_start_date_label => 'Start date';

  @override
  String get trip_editor_field_end_date_label => 'End date';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days days';
  }

  @override
  String get trip_editor_error_country_required =>
      'Please enter a country ISO code.';

  @override
  String get trip_editor_error_name_required => 'Please enter a trip name.';

  @override
  String get trip_editor_error_dates_required =>
      'Please select both a start and end date.';

  @override
  String get trip_editor_error_date_order =>
      'End date cannot be before start date.';

  @override
  String get trip_editor_save_button => 'Save trip';

  @override
  String get step_menu_edit => 'Edit step';

  @override
  String get step_menu_delete => 'Delete step';

  @override
  String get step_delete_confirm_title => 'Delete step?';

  @override
  String get step_delete_confirm_body =>
      'This note will be removed from the trip timeline.';

  @override
  String get step_editor_add_title => 'New step';

  @override
  String get step_editor_edit_title => 'Edit step';

  @override
  String get step_editor_field_description_label => 'Step description';

  @override
  String get step_editor_field_place_label => 'Place name (optional)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'Date & time: $value';
  }

  @override
  String get step_editor_hint_diary => 'Write about this moment...';

  @override
  String get step_editor_header_add_place_hint => 'Add where you are';

  @override
  String get step_editor_place_hint => 'City, place or landmark';

  @override
  String get step_editor_button_add_photos => 'Add photos';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count photos selected';
  }

  @override
  String get step_editor_error_pick_images => 'Error while picking images.';

  @override
  String get step_editor_error_empty_description =>
      'Please add a short description for this step.';

  @override
  String get step_media_add_web_unsupported =>
      'Adding photos is only supported on mobile and desktop.';

  @override
  String get generic_error_saving_step =>
      'Unable to save the step. Please try again.';

  @override
  String get fab_add_step_tooltip => 'Add step';

  @override
  String get fab_add_step_upgrade_tooltip => 'Upgrade to Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'You\'ve reached the limit of $steps steps per trip on the Free plan. Upgrade to Pro to keep journaling.';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'You\'ve reached the limit of steps for this plan. Upgrade to Pro to keep journaling.';

  @override
  String get btn_add_step => 'Add step';

  @override
  String get btn_save => 'Save';

  @override
  String get btn_cancel => 'Cancel';

  @override
  String get btn_delete => 'Delete';

  @override
  String get on_this_day_title => 'On this day';

  @override
  String get on_this_day_empty => 'No trip recorded on this day yet.';

  @override
  String get stats_title => 'Global dashboard';

  @override
  String get stats_sign_in_prompt => 'Please sign in to see stats.';

  @override
  String get stats_highlights_title => 'Highlights';

  @override
  String get stats_metric_trips_logged => 'Trips logged';

  @override
  String get stats_metric_travel_heavy_year => 'Travel-heavy year';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days days';
  }

  @override
  String get stats_value_not_available => 'Not available';

  @override
  String get stats_empty_message => 'Add your first trip to unlock stats.';

  @override
  String get stats_highlight_average_days => 'Average days per trip';

  @override
  String get stats_highlight_longest_trip => 'Longest trip';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days days - $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'Most recent trip';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'Travel goals';

  @override
  String get goals_new_goal_button => 'New goal';

  @override
  String get goals_dialog_title => 'Create goal';

  @override
  String get goals_field_title_label => 'Title';

  @override
  String get goals_field_year_label => 'Year';

  @override
  String get goals_field_target_label => 'Target countries';

  @override
  String get goals_delete_tooltip => 'Delete goal';

  @override
  String goals_card_year_label(Object year) {
    return 'Year $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target countries visited';
  }

  @override
  String get goals_empty_title => 'No goals yet';

  @override
  String get goals_empty_description =>
      'Set your yearly country goal and we will track your progress automatically.';

  @override
  String get goals_empty_cta => 'Create a goal';

  @override
  String get account_title => 'Account';

  @override
  String get plan_free => 'WorldTrace Free';

  @override
  String get plan_upgrade => 'Upgrade to Pro';

  @override
  String get year_in_review_title => 'Year in Review';

  @override
  String get trip_story_title => 'Trip Story';

  @override
  String get home_sign_in_prompt =>
      'Please sign in or continue as guest to start tracking your trips.';

  @override
  String generic_error(Object error) {
    return 'Error: $error';
  }

  @override
  String get no_trips_yet => 'No trips yet.';

  @override
  String get stat_countries_visited => 'Countries visited';

  @override
  String get stat_days_abroad => 'Days abroad';

  @override
  String get stat_last_trip => 'Last trip';

  @override
  String on_this_day_label(Object date) {
    return 'On this day: $date';
  }

  @override
  String get btn_open_trip => 'Open trip';

  @override
  String country_sheet_days(Object count) {
    return 'Days: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'Trips: $count';
  }

  @override
  String get country_sheet_view_trips => 'View trips in this country';

  @override
  String get country_sheet_add_trip => 'Add trip';

  @override
  String get country_sheet_no_photos_title => 'No photos here yet';

  @override
  String get country_sheet_no_photos_message =>
      'Add media to your trips and they\'ll appear here.';

  @override
  String get country_overview_subtitle => 'Country overview';

  @override
  String get country_overview_label_trips => 'Trips';

  @override
  String get country_overview_label_days => 'Days';

  @override
  String get country_overview_label_steps => 'Steps';

  @override
  String get country_overview_label_photos => 'Photos';

  @override
  String get country_overview_label_last_visited => 'Last visited';

  @override
  String get country_overview_last_visited_never => 'Never visited';

  @override
  String get country_overview_empty_trips_message =>
      'Add your first trip in this country to unlock insights.';

  @override
  String get country_overview_action_view_trips => 'View trips';

  @override
  String get country_overview_action_add_trip => 'Add a trip';

  @override
  String get country_overview_action_close => 'Close';

  @override
  String get guest_user => 'Guest user';

  @override
  String get plan_active => 'Active plan';

  @override
  String get auth_welcome => 'Welcome to WorldTrace';

  @override
  String get auth_login => 'Log in';

  @override
  String get auth_signup => 'Sign up';

  @override
  String get auth_continue_guest => 'Continue as guest';

  @override
  String get trip_deleted => 'Trip deleted.';

  @override
  String get trip_menu_delete => 'Delete trip';

  @override
  String get trip_delete_confirm_title => 'Delete this trip?';

  @override
  String get trip_delete_confirm_body =>
      'The trip and all its steps will be permanently removed.';

  @override
  String get trip_delete_missing_id_error =>
      'Unable to delete a trip without an ID.';

  @override
  String get menu_open_details => 'Open details';

  @override
  String get menu_delete_trip => 'Delete trip';

  @override
  String get tooltip_add_trip => 'Add trip';

  @override
  String get drawer_achievements => 'Achievements';

  @override
  String get achievements_sign_in_prompt =>
      'Sign in to view your achievements.';

  @override
  String get year_in_review_share_tooltip => 'Share year story';

  @override
  String get year_in_review_sign_in_prompt =>
      'Sign in to see your Year in Review.';

  @override
  String get year_in_review_no_trips =>
      'Add a few trips to unlock your review.';

  @override
  String get year_in_review_no_data_for_year =>
      'Review not available for this year.';

  @override
  String year_in_review_map_title(Object year) {
    return 'Travel map $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'Your $year in travel';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days days - $trips trips - $countries countries';
  }

  @override
  String get year_in_review_longest_trip => 'Longest trip';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days days';
  }

  @override
  String get year_in_review_top_country => 'Top country';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days days';
  }

  @override
  String get year_in_review_no_photo_highlights => 'No photo highlights yet';

  @override
  String get year_in_review_no_achievements =>
      'No achievements unlocked (yet).';

  @override
  String get year_in_review_unlocked_achievements => 'Unlocked achievements';

  @override
  String get year_in_review_render_error => 'Unable to generate the image.';

  @override
  String get year_in_review_encode_error => 'Error while creating the image.';

  @override
  String year_in_review_share_message(Object year) {
    return 'My $year in travel with WorldTrace';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'Share failed: $error';
  }

  @override
  String get trip_story_share_tooltip => 'Share story';

  @override
  String get trip_story_share_render_error => 'Unable to generate the story.';

  @override
  String get trip_story_share_image_error => 'Error while creating the image.';

  @override
  String trip_story_share_message(Object country) {
    return 'My trip in $country with WorldTrace';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'Share failed: $error';
  }

  @override
  String get trip_story_stat_steps => 'Steps';

  @override
  String get trip_story_stat_photos => 'Photos';

  @override
  String get trip_story_stat_days => 'Days';

  @override
  String get settings_profile_section_title => 'Profile';

  @override
  String get settings_plan_section_title => 'WorldTrace plan';

  @override
  String get settings_logout_button => 'Log out';

  @override
  String get plan_pro => 'WorldTrace Pro';

  @override
  String get settings_plan_description_pro =>
      'Unlimited timelines and premium travel tools.';

  @override
  String settings_plan_description_free(Object steps) {
    return 'Up to $steps steps per trip. Upgrade to Pro to unlock unlimited timelines and advanced stats.';
  }

  @override
  String profile_birthdate_label(Object date) {
    return 'Born on $date';
  }

  @override
  String get profile_birthdate_not_set => 'Not set';

  @override
  String get profile_edit_button => 'Edit profile';

  @override
  String get profile_edit_title => 'Edit profile';

  @override
  String get profile_photo_change => 'Change photo';

  @override
  String get profile_photo_remove => 'Remove photo';

  @override
  String get profile_first_name_label => 'First name';

  @override
  String get profile_last_name_label => 'Last name';

  @override
  String get profile_birthdate_title => 'Birth date';

  @override
  String get profile_birthdate_pick => 'Choose';

  @override
  String get plan_support_thanks => 'Thanks for supporting WorldTrace!';

  @override
  String get profile_plan_section_title => 'Plan';

  @override
  String get profile_plan_current_pro =>
      'Current plan: Pro - unlimited steps per trip.';

  @override
  String profile_plan_current_free(Object steps) {
    return 'Current plan: Free - up to $steps steps per trip.';
  }

  @override
  String get profile_sign_in_prompt => 'Sign in to view your travel profile.';

  @override
  String get profile_no_data => 'No data available.';

  @override
  String get profile_travel_summary_title => 'Travel summary';

  @override
  String get profile_stat_trips => 'Trips';

  @override
  String get profile_stat_countries => 'Countries';

  @override
  String get profile_stat_days => 'Days';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'Most intense year: $year - $days days';
  }

  @override
  String get profile_top_year_empty =>
      'Start logging your trips to unlock yearly stats.';

  @override
  String get profile_achievements_title => 'Achievements';

  @override
  String get profile_see_all => 'See all';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'Unlocked achievements: $unlocked of $total';
  }

  @override
  String get profile_goals_title => 'Goals';

  @override
  String get profile_goals_manage => 'Manage';

  @override
  String get profile_goals_empty =>
      'Set a yearly country goal to track your progress here.';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'Year $year - $current/$target countries';
  }

  @override
  String get profile_view_year_button => 'See your year';

  @override
  String get profile_share_button => 'Share my profile';

  @override
  String get profile_share_no_trips =>
      'I\'m starting to track my trips with WorldTrace. Follow me on my next adventure!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'I\'ve logged $trips trips, visited $countries countries, and spent $days days traveling with WorldTrace.';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'My most intense year was $year with $days days on the road.';
  }

  @override
  String get step_detail_section_story => 'Story';

  @override
  String get step_detail_story_empty => 'No story was added for this step.';

  @override
  String get step_detail_section_photos => 'Photos';

  @override
  String get step_detail_action_share => 'Share';

  @override
  String get step_media_web_unsupported =>
      'Image sharing is not supported on the web.';

  @override
  String get step_media_image_missing => 'Image not found on this device.';

  @override
  String get step_media_share_text => 'A snap from my trip with WorldTrace';

  @override
  String get step_media_share_failed => 'Unable to share this image.';

  @override
  String step_media_title(Object current, Object total) {
    return 'Photo $current/$total';
  }

  @override
  String get step_media_share_tooltip => 'Share';

  @override
  String get upgrade_title => 'Unlock WorldTrace Pro';

  @override
  String get upgrade_headline => 'Upgrade without limits';

  @override
  String get upgrade_description =>
      'Go Pro to keep telling your stories with unlimited timelines and traveler-focused tools.';

  @override
  String get upgrade_benefit_unlimited_steps => 'No step limits per trip';

  @override
  String get upgrade_benefit_advanced_stats =>
      'Advanced stats and goals (coming soon)';

  @override
  String get upgrade_benefit_heavy_users => 'Built for heavy travelers';

  @override
  String get upgrade_benefit_early_access =>
      'Early access to experimental features';

  @override
  String get upgrade_success_message => 'WorldTrace Pro activated!';

  @override
  String get upgrade_maybe_later => 'Maybe later';

  @override
  String get home_welcome_title => 'Welcome';

  @override
  String get home_next_trip_prompt => 'Ready to log your next trip?';

  @override
  String get world_map_sign_in_prompt =>
      'Sign in or continue as guest to view your travel map.';

  @override
  String get world_map_empty_message => 'Add your first trip to see the map.';

  @override
  String trip_story_open_failed(Object error) {
    return 'Unable to open the Trip Story: $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'Full-screen photo viewing is only supported on mobile and desktop.';

  @override
  String get onboarding_track_countries_title => 'Track countries';

  @override
  String get onboarding_track_countries_subtitle =>
      'Add trips, memories, and stats';

  @override
  String get onboarding_set_goals_title => 'Set goals';

  @override
  String get onboarding_set_goals_subtitle =>
      'Create targets like \"30 countries by 2030\"';

  @override
  String get onboarding_share_remember_title => 'Share & remember';

  @override
  String get onboarding_share_remember_subtitle =>
      'Create shareable cards of your travels';

  @override
  String get achievement_first_trip_title => 'First trip logged';

  @override
  String get achievement_first_trip_description =>
      'Log your very first trip in WorldTrace.';

  @override
  String get achievement_five_trips_title => 'Five trips club';

  @override
  String get achievement_five_trips_description =>
      'Reach five trips recorded in your journal.';

  @override
  String get achievement_ten_trips_title => 'Ten trips milestone';

  @override
  String get achievement_ten_trips_description =>
      'Plan and log at least ten adventures.';

  @override
  String get achievement_five_countries_title => 'Globetrotter I';

  @override
  String get achievement_five_countries_description =>
      'Visit five different countries.';

  @override
  String get achievement_ten_countries_title => 'Globetrotter II';

  @override
  String get achievement_ten_countries_description =>
      'Reach ten unique countries.';

  @override
  String get achievement_thirty_days_title => '30 days in a year';

  @override
  String get achievement_thirty_days_description =>
      'Spend 30+ days traveling within the same year.';

  @override
  String get achievement_hundred_days_title => '100 days on the road';

  @override
  String get achievement_hundred_days_description =>
      'Accumulate one hundred travel days overall.';

  @override
  String get auth_continue_email => 'Continue with email';

  @override
  String get auth_continue_google => 'Continue with Google';

  @override
  String get auth_continue_facebook => 'Continue with Facebook';
}
