// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'Startseite / Dashboard';

  @override
  String get drawer_world_map => 'Weltkarte';

  @override
  String get drawer_trips => 'Ausflüge';

  @override
  String get drawer_stats => 'Statistiken';

  @override
  String get drawer_goals => 'Ziele';

  @override
  String get drawer_profile => 'Reiseprofil';

  @override
  String get drawer_account => 'Konto / Einstellungen';

  @override
  String get gallery_title => 'Galerie';

  @override
  String get gallery_nav_label => 'Galerie';

  @override
  String get gallery_profile_cta => 'Alle Fotos ansehen';

  @override
  String get gallery_empty_title => 'Noch keine Fotos';

  @override
  String get gallery_empty_message =>
      'Fügen Sie Medien zu Ihren Reisen hinzu und diese werden hier angezeigt.';

  @override
  String get trips_title => 'Ausflüge';

  @override
  String get trip_detail_timeline => 'Zeitleiste';

  @override
  String get trip_detail_empty_steps_message =>
      'Noch keine Schritte. Beginnen Sie Ihre Reisegeschichte mit der ersten Notiz.';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count Schritte';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '$count Tag',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'Zeitleiste';

  @override
  String get trip_detail_section_photos_trip => 'Fotos';

  @override
  String get trip_edit_title_new => 'Neue Reise';

  @override
  String get trip_edit_title_edit => 'Reise bearbeiten';

  @override
  String get trip_edit_button_save => 'Speichern';

  @override
  String get trip_edit_button_create => 'Erstellen';

  @override
  String get trip_edit_field_country_iso_label => 'Länder-ISO-Code';

  @override
  String get trip_edit_field_country_iso_help => 'Z. B. JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'Reisename';

  @override
  String get trip_edit_field_notes_label => 'Notizen (optional)';

  @override
  String get trip_edit_button_start_date => 'Startdatum';

  @override
  String get trip_edit_button_end_date => 'Enddatum';

  @override
  String get trip_editor_new_title => 'Neue Reise';

  @override
  String get trip_editor_edit_title => 'Reise bearbeiten';

  @override
  String get trip_editor_field_country_label => 'Länder-ISO';

  @override
  String get trip_editor_field_country_helper => 'Z. B. JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'Reisename';

  @override
  String get trip_editor_field_description_label => 'Notizen (optional)';

  @override
  String get trip_editor_field_start_date_label => 'Startdatum';

  @override
  String get trip_editor_field_end_date_label => 'Enddatum';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days Tage';
  }

  @override
  String get trip_editor_error_country_required =>
      'Bitte geben Sie einen Länder-ISO-Code ein.';

  @override
  String get trip_editor_error_name_required =>
      'Bitte geben Sie einen Reisenamen ein.';

  @override
  String get trip_editor_error_dates_required =>
      'Bitte wählen Sie sowohl ein Start- als auch ein Enddatum aus.';

  @override
  String get trip_editor_error_date_order =>
      'Das Enddatum darf nicht vor dem Startdatum liegen.';

  @override
  String get trip_editor_save_button => 'Reise speichern';

  @override
  String get step_menu_edit => 'Schritt bearbeiten';

  @override
  String get step_menu_delete => 'Schritt löschen';

  @override
  String get step_delete_confirm_title => 'Schritt löschen?';

  @override
  String get step_delete_confirm_body =>
      'Dieser Hinweis wird aus der Reisezeitleiste entfernt.';

  @override
  String get step_editor_add_title => 'Neuer Schritt';

  @override
  String get step_editor_edit_title => 'Schritt bearbeiten';

  @override
  String get step_editor_field_description_label => 'Schrittbeschreibung';

  @override
  String get step_editor_field_place_label => 'Ortsname (optional)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'Datum und Uhrzeit: $value';
  }

  @override
  String get step_editor_hint_diary => 'Schreiben Sie über diesen Moment...';

  @override
  String get step_editor_header_add_place_hint =>
      'Fügen Sie hinzu, wo Sie sind';

  @override
  String get step_editor_place_hint => 'Stadt, Ort oder Wahrzeichen';

  @override
  String get step_editor_button_add_photos => 'Fügen Sie Fotos hinzu';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count Fotos ausgewählt';
  }

  @override
  String get step_editor_error_pick_images =>
      'Fehler beim Auswählen von Bildern.';

  @override
  String get step_editor_error_empty_description =>
      'Bitte fügen Sie eine kurze Beschreibung für diesen Schritt hinzu.';

  @override
  String get step_media_add_web_unsupported =>
      'Das Hinzufügen von Fotos wird nur auf Mobilgeräten und Desktops unterstützt.';

  @override
  String get generic_error_saving_step =>
      'Der Schritt kann nicht gespeichert werden. Bitte versuchen Sie es erneut.';

  @override
  String get fab_add_step_tooltip => 'Schritt hinzufügen';

  @override
  String get fab_add_step_upgrade_tooltip => 'Upgrade auf Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'Sie haben das Limit von $steps Schritten pro Fahrt im kostenlosen Plan erreicht. Führen Sie ein Upgrade auf Pro durch, um mit dem Journaling fortzufahren.';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'Sie haben die maximale Anzahl an Schritten für diesen Plan erreicht. Führen Sie ein Upgrade auf Pro durch, um mit dem Journaling fortzufahren.';

  @override
  String get btn_add_step => 'Schritt hinzufügen';

  @override
  String get btn_save => 'Speichern';

  @override
  String get btn_cancel => 'Stornieren';

  @override
  String get btn_delete => 'Löschen';

  @override
  String get on_this_day_title => 'An diesem Tag';

  @override
  String get on_this_day_empty =>
      'An diesem Tag wurde noch keine Fahrt aufgezeichnet.';

  @override
  String get stats_title => 'Globales Dashboard';

  @override
  String get stats_sign_in_prompt =>
      'Bitte melden Sie sich an, um Statistiken anzuzeigen.';

  @override
  String get stats_highlights_title => 'Höhepunkte';

  @override
  String get stats_metric_trips_logged => 'Fahrten protokolliert';

  @override
  String get stats_metric_travel_heavy_year => 'Reiselastiges Jahr';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days Tage';
  }

  @override
  String get stats_value_not_available => 'Nicht verfügbar';

  @override
  String get stats_empty_message =>
      'Fügen Sie Ihre erste Reise hinzu, um Statistiken freizuschalten.';

  @override
  String get stats_highlight_average_days => 'Durchschnittliche Tage pro Reise';

  @override
  String get stats_highlight_longest_trip => 'Längste Reise';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days Tage – $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'Letzte Reise';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'Reiseziele';

  @override
  String get goals_new_goal_button => 'Neues Ziel';

  @override
  String get goals_dialog_title => 'Ziel erstellen';

  @override
  String get goals_field_title_label => 'Titel';

  @override
  String get goals_field_year_label => 'Jahr';

  @override
  String get goals_field_target_label => 'Zielländer';

  @override
  String get goals_delete_tooltip => 'Ziel löschen';

  @override
  String goals_card_year_label(Object year) {
    return 'Jahr $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target Länder besucht';
  }

  @override
  String get goals_empty_title => 'Noch keine Ziele';

  @override
  String get goals_empty_description =>
      'Legen Sie Ihr jährliches Länderziel fest und wir verfolgen Ihren Fortschritt automatisch.';

  @override
  String get goals_empty_cta => 'Erstellen Sie ein Ziel';

  @override
  String get account_title => 'Konto';

  @override
  String get plan_free => 'WorldTrace Kostenlos';

  @override
  String get plan_upgrade => 'Upgrade auf Pro';

  @override
  String get year_in_review_title => 'Jahresrückblick';

  @override
  String get trip_story_title => 'Reisegeschichte';

  @override
  String get home_sign_in_prompt =>
      'Bitte melden Sie sich an oder fahren Sie als Gast fort, um mit der Verfolgung Ihrer Reisen zu beginnen.';

  @override
  String generic_error(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get no_trips_yet => 'Noch keine Reisen.';

  @override
  String get stat_countries_visited => 'Länder besucht';

  @override
  String get stat_days_abroad => 'Tage im Ausland';

  @override
  String get stat_last_trip => 'Letzte Reise';

  @override
  String on_this_day_label(Object date) {
    return 'An diesem Tag: $date';
  }

  @override
  String get btn_open_trip => 'Offene Reise';

  @override
  String country_sheet_days(Object count) {
    return 'Tage: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'Fahrten: $count';
  }

  @override
  String get country_sheet_view_trips =>
      'Sehen Sie sich Reisen in diesem Land an';

  @override
  String get country_sheet_add_trip => 'Reise hinzufügen';

  @override
  String get country_sheet_no_photos_title => 'Noch keine Fotos hier';

  @override
  String get country_sheet_no_photos_message =>
      'Fügen Sie Medien zu Ihren Reisen hinzu und diese werden hier angezeigt.';

  @override
  String get country_overview_subtitle => 'Länderübersicht';

  @override
  String get country_overview_label_trips => 'Ausflüge';

  @override
  String get country_overview_label_days => 'Tage';

  @override
  String get country_overview_label_steps => 'Schritte';

  @override
  String get country_overview_label_photos => 'Fotos';

  @override
  String get country_overview_label_last_visited => 'Zuletzt besucht';

  @override
  String get country_overview_last_visited_never => 'Nie besucht';

  @override
  String get country_overview_empty_trips_message =>
      'Fügen Sie Ihre erste Reise in diesem Land hinzu, um Erkenntnisse zu gewinnen.';

  @override
  String get country_overview_action_view_trips => 'Reisen ansehen';

  @override
  String get country_overview_action_add_trip => 'Fügen Sie eine Reise hinzu';

  @override
  String get country_overview_action_close => 'Schließen';

  @override
  String get guest_user => 'Gastbenutzer';

  @override
  String get plan_active => 'Aktiver Plan';

  @override
  String get auth_welcome => 'Willkommen bei WorldTrace';

  @override
  String get auth_login => 'Einloggen';

  @override
  String get auth_signup => 'Melden Sie sich an';

  @override
  String get auth_continue_guest => 'Als Gast fortfahren';

  @override
  String get trip_deleted => 'Reise gelöscht.';

  @override
  String get trip_menu_delete => 'Reise löschen';

  @override
  String get trip_delete_confirm_title => 'Diese Reise löschen?';

  @override
  String get trip_delete_confirm_body =>
      'Die Reise und alle ihre Schritte werden dauerhaft entfernt.';

  @override
  String get trip_delete_missing_id_error =>
      'Eine Reise ohne ID kann nicht gelöscht werden.';

  @override
  String get menu_open_details => 'Details öffnen';

  @override
  String get menu_delete_trip => 'Reise löschen';

  @override
  String get tooltip_add_trip => 'Reise hinzufügen';

  @override
  String get drawer_achievements => 'Erfolge';

  @override
  String get achievements_sign_in_prompt =>
      'Melden Sie sich an, um Ihre Erfolge anzuzeigen.';

  @override
  String get year_in_review_share_tooltip => 'Teilen Sie die Jahresgeschichte';

  @override
  String get year_in_review_sign_in_prompt =>
      'Melden Sie sich an, um Ihren Jahresrückblick zu sehen.';

  @override
  String get year_in_review_no_trips =>
      'Fügen Sie ein paar Reisen hinzu, um Ihre Bewertung freizuschalten.';

  @override
  String get year_in_review_no_data_for_year =>
      'Rezension für dieses Jahr nicht verfügbar.';

  @override
  String year_in_review_map_title(Object year) {
    return 'Reisekarte $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'Ihr $year auf Reisen';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days Tage – $trips Reisen – $countries Länder';
  }

  @override
  String get year_in_review_longest_trip => 'Längste Reise';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days Tage';
  }

  @override
  String get year_in_review_top_country => 'Top Land';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days Tage';
  }

  @override
  String get year_in_review_no_photo_highlights => 'Noch keine Foto-Highlights';

  @override
  String get year_in_review_no_achievements =>
      '(Noch) keine Erfolge freigeschaltet.';

  @override
  String get year_in_review_unlocked_achievements => 'Freigeschaltete Erfolge';

  @override
  String get year_in_review_render_error =>
      'Das Bild kann nicht generiert werden.';

  @override
  String get year_in_review_encode_error => 'Fehler beim Erstellen des Bildes.';

  @override
  String year_in_review_share_message(Object year) {
    return 'Mein $year auf Reisen mit WorldTrace';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'Freigabe fehlgeschlagen: $error';
  }

  @override
  String get trip_story_share_tooltip => 'Geschichte teilen';

  @override
  String get trip_story_share_render_error =>
      'Die Geschichte kann nicht generiert werden.';

  @override
  String get trip_story_share_image_error =>
      'Fehler beim Erstellen des Bildes.';

  @override
  String trip_story_share_message(Object country) {
    return 'Meine Reise in $country mit WorldTrace';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'Freigabe fehlgeschlagen: $error';
  }

  @override
  String get trip_story_stat_steps => 'Schritte';

  @override
  String get trip_story_stat_photos => 'Fotos';

  @override
  String get trip_story_stat_days => 'Tage';

  @override
  String get settings_profile_section_title => 'Profil';

  @override
  String get settings_plan_section_title => 'WorldTrace-Plan';

  @override
  String get settings_logout_button => 'Abmelden';

  @override
  String get plan_pro => '__MARKE__ Pro';

  @override
  String get settings_plan_description_pro =>
      'Unbegrenzte Zeitpläne und Premium-Reisetools.';

  @override
  String settings_plan_description_free(Object steps) {
    return 'Bis zu $steps Schritte pro Fahrt. Führen Sie ein Upgrade auf Pro durch, um unbegrenzte Zeitleisten und erweiterte Statistiken freizuschalten.';
  }

  @override
  String profile_birthdate_label(Object date) {
    return 'Geboren am $date';
  }

  @override
  String get profile_birthdate_not_set => 'Nicht festgelegt';

  @override
  String get profile_edit_button => 'Profil bearbeiten';

  @override
  String get profile_edit_title => 'Profil bearbeiten';

  @override
  String get profile_photo_change => 'Foto ändern';

  @override
  String get profile_photo_remove => 'Foto entfernen';

  @override
  String get profile_first_name_label => 'Vorname';

  @override
  String get profile_last_name_label => 'Nachname';

  @override
  String get profile_birthdate_title => 'Geburtsdatum';

  @override
  String get profile_birthdate_pick => 'Wählen';

  @override
  String get plan_support_thanks =>
      'Vielen Dank für die Unterstützung von WorldTrace!';

  @override
  String get profile_plan_section_title => 'Planen';

  @override
  String get profile_plan_current_pro =>
      'Aktueller Plan: Pro – unbegrenzte Schritte pro Fahrt.';

  @override
  String profile_plan_current_free(Object steps) {
    return 'Aktueller Plan: Kostenlos – bis zu $steps Schritte pro Fahrt.';
  }

  @override
  String get profile_sign_in_prompt =>
      'Melden Sie sich an, um Ihr Reiseprofil anzuzeigen.';

  @override
  String get profile_no_data => 'Keine Daten verfügbar.';

  @override
  String get profile_travel_summary_title => 'Reisezusammenfassung';

  @override
  String get profile_stat_trips => 'Ausflüge';

  @override
  String get profile_stat_countries => 'Länder';

  @override
  String get profile_stat_days => 'Tage';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'Intensivstes Jahr: $year - $days Tage';
  }

  @override
  String get profile_top_year_empty =>
      'Beginnen Sie mit der Protokollierung Ihrer Reisen, um jährliche Statistiken freizuschalten.';

  @override
  String get profile_achievements_title => 'Erfolge';

  @override
  String get profile_see_all => 'Alle anzeigen';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'Freigeschaltete Erfolge: $unlocked von $total';
  }

  @override
  String get profile_goals_title => 'Ziele';

  @override
  String get profile_goals_manage => 'Verwalten';

  @override
  String get profile_goals_empty =>
      'Legen Sie hier ein jährliches Länderziel fest, um Ihren Fortschritt zu verfolgen.';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'Jahr $year - $current/$target Länder';
  }

  @override
  String get profile_view_year_button => 'Sehen Sie Ihr Jahr';

  @override
  String get profile_share_button => 'Teile mein Profil';

  @override
  String get profile_share_no_trips =>
      'Ich fange an, meine Reisen mit WorldTrace zu verfolgen. Folge mir auf meinem nächsten Abenteuer!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'Ich habe $trips Reisen protokolliert, $countries Länder besucht und $days Tage damit verbracht, mit WorldTrace zu reisen.';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'Mein intensivstes Jahr war $year mit $days Tagen unterwegs.';
  }

  @override
  String get step_detail_section_story => 'Geschichte';

  @override
  String get step_detail_story_empty =>
      'Für diesen Schritt wurde keine Story hinzugefügt.';

  @override
  String get step_detail_section_photos => 'Fotos';

  @override
  String get step_detail_action_share => 'Aktie';

  @override
  String get step_media_web_unsupported =>
      'Das Teilen von Bildern wird im Web nicht unterstützt.';

  @override
  String get step_media_image_missing =>
      'Bild wurde auf diesem Gerät nicht gefunden.';

  @override
  String get step_media_share_text =>
      'Ein Schnappschuss von meiner Reise mit WorldTrace';

  @override
  String get step_media_share_failed =>
      'Dieses Bild kann nicht geteilt werden.';

  @override
  String step_media_title(Object current, Object total) {
    return 'Foto $current/$total';
  }

  @override
  String get step_media_share_tooltip => 'Aktie';

  @override
  String get upgrade_title => 'Schalten Sie WorldTrace Pro frei';

  @override
  String get upgrade_headline => 'Upgraden Sie ohne Grenzen';

  @override
  String get upgrade_description =>
      'Gehen Sie Pro, um Ihre Geschichten weiterhin mit unbegrenzten Zeitplänen und reiseorientierten Tools zu erzählen.';

  @override
  String get upgrade_benefit_unlimited_steps =>
      'Keine Schrittbegrenzung pro Fahrt';

  @override
  String get upgrade_benefit_advanced_stats =>
      'Erweiterte Statistiken und Ziele (in Kürze verfügbar)';

  @override
  String get upgrade_benefit_heavy_users => 'Gebaut für schwere Reisende';

  @override
  String get upgrade_benefit_early_access =>
      'Frühzeitiger Zugriff auf experimentelle Funktionen';

  @override
  String get upgrade_success_message => 'WorldTrace Pro aktiviert!';

  @override
  String get upgrade_maybe_later => 'Vielleicht später';

  @override
  String get home_welcome_title => 'Willkommen';

  @override
  String get home_next_trip_prompt =>
      'Sind Sie bereit, Ihre nächste Reise zu protokollieren?';

  @override
  String get world_map_sign_in_prompt =>
      'Melden Sie sich an oder fahren Sie als Gast fort, um Ihre Reisekarte anzuzeigen.';

  @override
  String get world_map_empty_message =>
      'Fügen Sie Ihre erste Reise hinzu, um die Karte anzuzeigen.';

  @override
  String trip_story_open_failed(Object error) {
    return 'Die Reisegeschichte kann nicht geöffnet werden: $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'Die Anzeige von Fotos im Vollbildmodus wird nur auf Mobilgeräten und Desktops unterstützt.';

  @override
  String get onboarding_track_countries_title => 'Verfolgen Sie Länder';

  @override
  String get onboarding_track_countries_subtitle =>
      'Fügen Sie Reisen, Erinnerungen und Statistiken hinzu';

  @override
  String get onboarding_set_goals_title => 'Setzen Sie sich Ziele';

  @override
  String get onboarding_set_goals_subtitle =>
      'Erstellen Sie Ziele wie „30 Länder bis 2030“';

  @override
  String get onboarding_share_remember_title => 'Teilen und erinnern';

  @override
  String get onboarding_share_remember_subtitle =>
      'Erstellen Sie gemeinsam nutzbare Karten Ihrer Reisen';

  @override
  String get achievement_first_trip_title => 'Erste Fahrt protokolliert';

  @override
  String get achievement_first_trip_description =>
      'Tragen Sie Ihre allererste Reise in WorldTrace ein.';

  @override
  String get achievement_five_trips_title => 'Fünf-Reise-Club';

  @override
  String get achievement_five_trips_description =>
      'Erreichen Sie fünf Fahrten, die in Ihrem Tagebuch aufgezeichnet sind.';

  @override
  String get achievement_ten_trips_title => 'Meilenstein von zehn Reisen';

  @override
  String get achievement_ten_trips_description =>
      'Planen und protokollieren Sie mindestens zehn Abenteuer.';

  @override
  String get achievement_five_countries_title => 'Weltenbummler I';

  @override
  String get achievement_five_countries_description =>
      'Besuchen Sie fünf verschiedene Länder.';

  @override
  String get achievement_ten_countries_title => 'Globetrotter II';

  @override
  String get achievement_ten_countries_description =>
      'Erreichen Sie zehn einzigartige Länder.';

  @override
  String get achievement_thirty_days_title => '30 Tage im Jahr';

  @override
  String get achievement_thirty_days_description =>
      'Verbringen Sie mehr als 30 Tage im selben Jahr auf Reisen.';

  @override
  String get achievement_hundred_days_title => '100 Tage unterwegs';

  @override
  String get achievement_hundred_days_description =>
      'Sammeln Sie insgesamt einhundert Reisetage.';

  @override
  String get auth_continue_email => 'Weiter mit email';

  @override
  String get auth_continue_google => 'Weiter mit Google';

  @override
  String get auth_continue_facebook => 'Weiter mit Facebook';
}
