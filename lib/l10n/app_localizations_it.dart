// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'Casa / Cruscotto';

  @override
  String get drawer_world_map => 'Mappa del mondo';

  @override
  String get drawer_trips => 'Viaggi';

  @override
  String get drawer_stats => 'Statistiche';

  @override
  String get drawer_goals => 'Obiettivi';

  @override
  String get drawer_profile => 'Profilo di viaggio';

  @override
  String get drawer_account => 'Impostazioni dell\'account';

  @override
  String get gallery_title => 'Galleria';

  @override
  String get gallery_nav_label => 'Galleria';

  @override
  String get gallery_profile_cta => 'Vedi tutte le foto';

  @override
  String get gallery_empty_title => 'Nessuna foto ancora';

  @override
  String get gallery_empty_message =>
      'Aggiungi contenuti multimediali ai tuoi viaggi e verranno visualizzati qui.';

  @override
  String get trips_title => 'Viaggi';

  @override
  String get trip_detail_timeline => 'Cronologia';

  @override
  String get trip_detail_empty_steps_message =>
      'Nessun passaggio ancora. Inizia il tuo racconto di viaggio con la prima nota.';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count passi';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '$count giorno',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'Cronologia';

  @override
  String get trip_detail_section_photos_trip => 'Foto';

  @override
  String get trip_edit_title_new => 'Nuovo viaggio';

  @override
  String get trip_edit_title_edit => 'Modifica viaggio';

  @override
  String get trip_edit_button_save => 'Salva';

  @override
  String get trip_edit_button_create => 'Creare';

  @override
  String get trip_edit_field_country_iso_label => 'Codice ISO del paese';

  @override
  String get trip_edit_field_country_iso_help => 'Es. JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'Nome del viaggio';

  @override
  String get trip_edit_field_notes_label => 'Note (facoltativo)';

  @override
  String get trip_edit_button_start_date => 'Data di inizio';

  @override
  String get trip_edit_button_end_date => 'Data di fine';

  @override
  String get trip_editor_new_title => 'Nuovo viaggio';

  @override
  String get trip_editor_edit_title => 'Modifica viaggio';

  @override
  String get trip_editor_field_country_label => 'ISO del paese';

  @override
  String get trip_editor_field_country_helper => 'Es. JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'Nome del viaggio';

  @override
  String get trip_editor_field_description_label => 'Note (facoltativo)';

  @override
  String get trip_editor_field_start_date_label => 'Data di inizio';

  @override
  String get trip_editor_field_end_date_label => 'Data di fine';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days giorni';
  }

  @override
  String get trip_editor_error_country_required =>
      'Inserisci il codice ISO del paese.';

  @override
  String get trip_editor_error_name_required =>
      'Inserisci il nome del viaggio.';

  @override
  String get trip_editor_error_dates_required =>
      'Seleziona sia la data di inizio che quella di fine.';

  @override
  String get trip_editor_error_date_order =>
      'La data di fine non può essere anteriore alla data di inizio.';

  @override
  String get trip_editor_save_button => 'Salva viaggio';

  @override
  String get step_menu_edit => 'Modifica passaggio';

  @override
  String get step_menu_delete => 'Elimina passaggio';

  @override
  String get step_delete_confirm_title => 'Eliminare il passaggio?';

  @override
  String get step_delete_confirm_body =>
      'Questa nota verrà rimossa dalla cronologia del viaggio.';

  @override
  String get step_editor_add_title => 'Nuovo passo';

  @override
  String get step_editor_edit_title => 'Modifica passaggio';

  @override
  String get step_editor_field_description_label => 'Descrizione del passaggio';

  @override
  String get step_editor_field_place_label => 'Nome del luogo (facoltativo)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'Data e ora: $value';
  }

  @override
  String get step_editor_hint_diary => 'Scrivi di questo momento...';

  @override
  String get step_editor_header_add_place_hint => 'Aggiungi dove ti trovi';

  @override
  String get step_editor_place_hint => 'Città, luogo o punto di riferimento';

  @override
  String get step_editor_button_add_photos => 'Aggiungi foto';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count foto selezionate';
  }

  @override
  String get step_editor_error_pick_images =>
      'Errore durante la raccolta delle immagini.';

  @override
  String get step_editor_error_empty_description =>
      'Aggiungi una breve descrizione per questo passaggio.';

  @override
  String get step_media_add_web_unsupported =>
      'L\'aggiunta di foto è supportata solo su dispositivi mobili e desktop.';

  @override
  String get generic_error_saving_step =>
      'Impossibile salvare il passaggio. Per favore riprova.';

  @override
  String get fab_add_step_tooltip => 'Aggiungi passaggio';

  @override
  String get fab_add_step_upgrade_tooltip => 'Aggiorna a Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'Hai raggiunto il limite di $steps passi per viaggio con il piano gratuito. Aggiorna a Pro per continuare a inserire nel journal.';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'Hai raggiunto il limite di passaggi per questo piano. Aggiorna a Pro per continuare a inserire nel journal.';

  @override
  String get btn_add_step => 'Aggiungi passaggio';

  @override
  String get btn_save => 'Salva';

  @override
  String get btn_cancel => 'Cancellare';

  @override
  String get btn_delete => 'Eliminare';

  @override
  String get on_this_day_title => 'In questo giorno';

  @override
  String get on_this_day_empty =>
      'Nessun viaggio registrato ancora in questo giorno.';

  @override
  String get stats_title => 'Cruscotto globale';

  @override
  String get stats_sign_in_prompt => 'Accedi per visualizzare le statistiche.';

  @override
  String get stats_highlights_title => 'Punti salienti';

  @override
  String get stats_metric_trips_logged => 'Viaggi registrati';

  @override
  String get stats_metric_travel_heavy_year => 'Anno ricco di viaggi';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days giorni';
  }

  @override
  String get stats_value_not_available => 'Non disponibile';

  @override
  String get stats_empty_message =>
      'Aggiungi il tuo primo viaggio per sbloccare le statistiche.';

  @override
  String get stats_highlight_average_days => 'Giorni medi per viaggio';

  @override
  String get stats_highlight_longest_trip => 'Il viaggio più lungo';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days giorni - $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'Viaggio più recente';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'Obiettivi di viaggio';

  @override
  String get goals_new_goal_button => 'Nuovo obiettivo';

  @override
  String get goals_dialog_title => 'Crea obiettivo';

  @override
  String get goals_field_title_label => 'Titolo';

  @override
  String get goals_field_year_label => 'Anno';

  @override
  String get goals_field_target_label => 'Paesi target';

  @override
  String get goals_delete_tooltip => 'Elimina obiettivo';

  @override
  String goals_card_year_label(Object year) {
    return 'Anno $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target paesi visitati';
  }

  @override
  String get goals_empty_title => 'Nessun obiettivo ancora';

  @override
  String get goals_empty_description =>
      'Imposta il tuo obiettivo nazionale annuale e monitoreremo automaticamente i tuoi progressi.';

  @override
  String get goals_empty_cta => 'Crea un obiettivo';

  @override
  String get account_title => 'Account';

  @override
  String get plan_free => '__MARCA__ Gratuito';

  @override
  String get plan_upgrade => 'Aggiorna a Pro';

  @override
  String get year_in_review_title => 'Anno in rassegna';

  @override
  String get trip_story_title => 'Storia di viaggio';

  @override
  String get home_sign_in_prompt =>
      'Accedi o continua come ospite per iniziare a monitorare i tuoi viaggi.';

  @override
  String generic_error(Object error) {
    return 'Errore: $error';
  }

  @override
  String get no_trips_yet => 'Nessun viaggio ancora.';

  @override
  String get stat_countries_visited => 'Paesi visitati';

  @override
  String get stat_days_abroad => 'Giornate all\'estero';

  @override
  String get stat_last_trip => 'Ultimo viaggio';

  @override
  String on_this_day_label(Object date) {
    return 'In questo giorno: $date';
  }

  @override
  String get btn_open_trip => 'Viaggio aperto';

  @override
  String country_sheet_days(Object count) {
    return 'Giorni: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'Viaggi: $count';
  }

  @override
  String get country_sheet_view_trips => 'Visualizza i viaggi in questo paese';

  @override
  String get country_sheet_add_trip => 'Aggiungi viaggio';

  @override
  String get country_sheet_no_photos_title => 'Nessuna foto qui ancora';

  @override
  String get country_sheet_no_photos_message =>
      'Aggiungi contenuti multimediali ai tuoi viaggi e verranno visualizzati qui.';

  @override
  String get country_overview_subtitle => 'Panoramica del paese';

  @override
  String get country_overview_label_trips => 'Viaggi';

  @override
  String get country_overview_label_days => 'Giorni';

  @override
  String get country_overview_label_steps => 'Passi';

  @override
  String get country_overview_label_photos => 'Foto';

  @override
  String get country_overview_label_last_visited => 'Ultima visita';

  @override
  String get country_overview_last_visited_never => 'Mai visitato';

  @override
  String get country_overview_empty_trips_message =>
      'Aggiungi il tuo primo viaggio in questo Paese per sbloccare approfondimenti.';

  @override
  String get country_overview_action_view_trips => 'Visualizza viaggi';

  @override
  String get country_overview_action_add_trip => 'Aggiungi un viaggio';

  @override
  String get country_overview_action_close => 'Vicino';

  @override
  String get guest_user => 'Utente ospite';

  @override
  String get plan_active => 'Piano attivo';

  @override
  String get auth_welcome => 'Benvenuto in WorldTrace';

  @override
  String get auth_login => 'Login';

  @override
  String get auth_signup => 'Iscrizione';

  @override
  String get auth_continue_guest => 'Continua come ospite';

  @override
  String get trip_deleted => 'Viaggio cancellato.';

  @override
  String get trip_menu_delete => 'Elimina viaggio';

  @override
  String get trip_delete_confirm_title => 'Eliminare questo viaggio?';

  @override
  String get trip_delete_confirm_body =>
      'Il viaggio e tutti i relativi passaggi verranno rimossi definitivamente.';

  @override
  String get trip_delete_missing_id_error =>
      'Impossibile eliminare un viaggio senza ID.';

  @override
  String get menu_open_details => 'Apri i dettagli';

  @override
  String get menu_delete_trip => 'Elimina viaggio';

  @override
  String get tooltip_add_trip => 'Aggiungi viaggio';

  @override
  String get drawer_achievements => 'Risultati';

  @override
  String get achievements_sign_in_prompt =>
      'Accedi per visualizzare i tuoi risultati.';

  @override
  String get year_in_review_share_tooltip => 'Condividi la storia dell\'anno';

  @override
  String get year_in_review_sign_in_prompt =>
      'Accedi per visualizzare il tuo anno in rassegna.';

  @override
  String get year_in_review_no_trips =>
      'Aggiungi qualche viaggio per sbloccare la tua recensione.';

  @override
  String get year_in_review_no_data_for_year =>
      'Recensione non disponibile per quest\'anno.';

  @override
  String year_in_review_map_title(Object year) {
    return 'Mappa di viaggio $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'Il tuo $year nei viaggi';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days giorni - $trips viaggi - $countries paesi';
  }

  @override
  String get year_in_review_longest_trip => 'Il viaggio più lungo';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days giorni';
  }

  @override
  String get year_in_review_top_country => 'Paese principale';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days giorni';
  }

  @override
  String get year_in_review_no_photo_highlights =>
      'Nessuna foto in evidenza ancora';

  @override
  String get year_in_review_no_achievements =>
      'Nessun obiettivo sbloccato (ancora).';

  @override
  String get year_in_review_unlocked_achievements => 'Obiettivi sbloccati';

  @override
  String get year_in_review_render_error => 'Impossibile generare l\'immagine.';

  @override
  String get year_in_review_encode_error =>
      'Errore durante la creazione dell\'immagine.';

  @override
  String year_in_review_share_message(Object year) {
    return 'Il mio $year in viaggio con WorldTrace';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'Condivisione non riuscita: $error';
  }

  @override
  String get trip_story_share_tooltip => 'Condividi la storia';

  @override
  String get trip_story_share_render_error => 'Impossibile generare la storia.';

  @override
  String get trip_story_share_image_error =>
      'Errore durante la creazione dell\'immagine.';

  @override
  String trip_story_share_message(Object country) {
    return 'Il mio viaggio in $country con WorldTrace';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'Condivisione non riuscita: $error';
  }

  @override
  String get trip_story_stat_steps => 'Passi';

  @override
  String get trip_story_stat_photos => 'Foto';

  @override
  String get trip_story_stat_days => 'Giorni';

  @override
  String get settings_profile_section_title => 'Profilo';

  @override
  String get settings_plan_section_title => 'Piano WorldTrace';

  @override
  String get settings_logout_button => 'Esci';

  @override
  String get plan_pro => '__MARCA__ Pro';

  @override
  String get settings_plan_description_pro =>
      'Cronometrie illimitate e strumenti di viaggio premium.';

  @override
  String settings_plan_description_free(Object steps) {
    return 'Fino a $steps passi per viaggio. Esegui l\'upgrade a Pro per sbloccare sequenze temporali illimitate e statistiche avanzate.';
  }

  @override
  String profile_birthdate_label(Object date) {
    return 'Nato il $date';
  }

  @override
  String get profile_birthdate_not_set => 'Non impostato';

  @override
  String get profile_edit_button => 'Modifica profilo';

  @override
  String get profile_edit_title => 'Modifica profilo';

  @override
  String get profile_photo_change => 'Cambia foto';

  @override
  String get profile_photo_remove => 'Rimuovi foto';

  @override
  String get profile_first_name_label => 'Nome di battesimo';

  @override
  String get profile_last_name_label => 'Cognome';

  @override
  String get profile_birthdate_title => 'Data di nascita';

  @override
  String get profile_birthdate_pick => 'Scegliere';

  @override
  String get plan_support_thanks => 'Grazie per aver supportato WorldTrace!';

  @override
  String get profile_plan_section_title => 'Piano';

  @override
  String get profile_plan_current_pro =>
      'Piano attuale: Pro - passi illimitati per viaggio.';

  @override
  String profile_plan_current_free(Object steps) {
    return 'Piano attuale: gratuito: fino a $steps passi per viaggio.';
  }

  @override
  String get profile_sign_in_prompt =>
      'Accedi per visualizzare il tuo profilo di viaggio.';

  @override
  String get profile_no_data => 'Nessun dato disponibile.';

  @override
  String get profile_travel_summary_title => 'Riepilogo del viaggio';

  @override
  String get profile_stat_trips => 'Viaggi';

  @override
  String get profile_stat_countries => 'Paesi';

  @override
  String get profile_stat_days => 'Giorni';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'Anno più intenso: $year - $days giorni';
  }

  @override
  String get profile_top_year_empty =>
      'Inizia a registrare i tuoi viaggi per sbloccare le statistiche annuali.';

  @override
  String get profile_achievements_title => 'Risultati';

  @override
  String get profile_see_all => 'Vedi tutto';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'Risultati sbloccati: $unlocked di $total';
  }

  @override
  String get profile_goals_title => 'Obiettivi';

  @override
  String get profile_goals_manage => 'Maneggio';

  @override
  String get profile_goals_empty =>
      'Imposta un obiettivo nazionale annuale per monitorare i tuoi progressi qui.';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'Anno $year - $current/$target paesi';
  }

  @override
  String get profile_view_year_button => 'Vedi il tuo anno';

  @override
  String get profile_share_button => 'Condividi il mio profilo';

  @override
  String get profile_share_no_trips =>
      'Sto iniziando a tenere traccia dei miei viaggi con WorldTrace. Seguitemi nella mia prossima avventura!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'Ho registrato $trips viaggi, visitato $countries paesi e trascorso $days giorni viaggiando con WorldTrace.';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'Il mio anno più intenso è stato $year con $days giorni in viaggio.';
  }

  @override
  String get step_detail_section_story => 'Storia';

  @override
  String get step_detail_story_empty =>
      'Non è stata aggiunta alcuna storia per questo passaggio.';

  @override
  String get step_detail_section_photos => 'Foto';

  @override
  String get step_detail_action_share => 'Condividere';

  @override
  String get step_media_web_unsupported =>
      'La condivisione delle immagini non è supportata sul Web.';

  @override
  String get step_media_image_missing =>
      'Immagine non trovata su questo dispositivo.';

  @override
  String get step_media_share_text =>
      'Uno scatto del mio viaggio con WorldTrace';

  @override
  String get step_media_share_failed =>
      'Impossibile condividere questa immagine.';

  @override
  String step_media_title(Object current, Object total) {
    return 'Foto $current/$total';
  }

  @override
  String get step_media_share_tooltip => 'Condividere';

  @override
  String get upgrade_title => 'Sblocca WorldTrace Pro';

  @override
  String get upgrade_headline => 'Aggiorna senza limiti';

  @override
  String get upgrade_description =>
      'Passa a Pro per continuare a raccontare le tue storie con tempistiche illimitate e strumenti incentrati sui viaggiatori.';

  @override
  String get upgrade_benefit_unlimited_steps =>
      'Nessun limite di passi per viaggio';

  @override
  String get upgrade_benefit_advanced_stats =>
      'Statistiche e obiettivi avanzati (disponibile a breve)';

  @override
  String get upgrade_benefit_heavy_users => 'Costruito per viaggiatori pesanti';

  @override
  String get upgrade_benefit_early_access =>
      'Accesso anticipato alle funzionalità sperimentali';

  @override
  String get upgrade_success_message => 'WorldTrace Pro attivato!';

  @override
  String get upgrade_maybe_later => 'Forse più tardi';

  @override
  String get home_welcome_title => 'Benvenuto';

  @override
  String get home_next_trip_prompt =>
      'Pronto a registrare il tuo prossimo viaggio?';

  @override
  String get world_map_sign_in_prompt =>
      'Accedi o continua come ospite per visualizzare la mappa di viaggio.';

  @override
  String get world_map_empty_message =>
      'Aggiungi il tuo primo viaggio per vedere la mappa.';

  @override
  String trip_story_open_failed(Object error) {
    return 'Impossibile aprire la Storia del viaggio: $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'La visualizzazione delle foto a schermo intero è supportata solo su dispositivi mobili e desktop.';

  @override
  String get onboarding_track_countries_title => 'Tieni traccia dei paesi';

  @override
  String get onboarding_track_countries_subtitle =>
      'Aggiungi viaggi, ricordi e statistiche';

  @override
  String get onboarding_set_goals_title => 'Stabilisci obiettivi';

  @override
  String get onboarding_set_goals_subtitle =>
      'Creare obiettivi come \"30 paesi entro il 2030\"';

  @override
  String get onboarding_share_remember_title => 'Condividi e ricorda';

  @override
  String get onboarding_share_remember_subtitle =>
      'Crea cartoline condivisibili dei tuoi viaggi';

  @override
  String get achievement_first_trip_title => 'Primo viaggio registrato';

  @override
  String get achievement_first_trip_description =>
      'Registra il tuo primo viaggio in WorldTrace.';

  @override
  String get achievement_five_trips_title => 'Club dei cinque viaggi';

  @override
  String get achievement_five_trips_description =>
      'Raggiungi cinque viaggi registrati nel tuo diario.';

  @override
  String get achievement_ten_trips_title => 'Traguardo di dieci viaggi';

  @override
  String get achievement_ten_trips_description =>
      'Pianifica e registra almeno dieci avventure.';

  @override
  String get achievement_five_countries_title => 'Il giramondo I';

  @override
  String get achievement_five_countries_description =>
      'Visita cinque paesi diversi.';

  @override
  String get achievement_ten_countries_title => 'Giramondo II';

  @override
  String get achievement_ten_countries_description =>
      'Raggiungi dieci paesi unici.';

  @override
  String get achievement_thirty_days_title => '30 giorni all\'anno';

  @override
  String get achievement_thirty_days_description =>
      'Trascorri più di 30 giorni viaggiando nello stesso anno.';

  @override
  String get achievement_hundred_days_title => '100 giorni in viaggio';

  @override
  String get achievement_hundred_days_description =>
      'Accumula cento giorni di viaggio in totale.';

  @override
  String get auth_continue_email => 'Continua con email';

  @override
  String get auth_continue_google => 'Continua con Google';

  @override
  String get auth_continue_facebook => 'Continua con Facebook';
}
