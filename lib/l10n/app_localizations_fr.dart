// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'Accueil / Tableau de bord';

  @override
  String get drawer_world_map => 'Carte du monde';

  @override
  String get drawer_trips => 'Voyages';

  @override
  String get drawer_stats => 'Statistiques';

  @override
  String get drawer_goals => 'Objectifs';

  @override
  String get drawer_profile => 'Profil de voyage';

  @override
  String get drawer_account => 'Paramètres du compte';

  @override
  String get gallery_title => 'Galerie';

  @override
  String get gallery_nav_label => 'Galerie';

  @override
  String get gallery_profile_cta => 'Voir toutes les photos';

  @override
  String get gallery_empty_title => 'Pas encore de photos';

  @override
  String get gallery_empty_message =>
      'Ajoutez des médias à vos voyages et ils apparaîtront ici.';

  @override
  String get trips_title => 'Voyages';

  @override
  String get trip_detail_timeline => 'Chronologie';

  @override
  String get trip_detail_empty_steps_message =>
      'Aucune étape pour l\'instant. Commencez votre récit de voyage avec la première note.';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count étapes';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'Chronologie';

  @override
  String get trip_detail_section_photos_trip => 'Photos';

  @override
  String get trip_edit_title_new => 'Nouveau voyage';

  @override
  String get trip_edit_title_edit => 'Modifier le voyage';

  @override
  String get trip_edit_button_save => 'Sauvegarder';

  @override
  String get trip_edit_button_create => 'Créer';

  @override
  String get trip_edit_field_country_iso_label => 'Code ISO du pays';

  @override
  String get trip_edit_field_country_iso_help => 'Ex. JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'Nom du voyage';

  @override
  String get trip_edit_field_notes_label => 'Remarques (facultatif)';

  @override
  String get trip_edit_button_start_date => 'Date de début';

  @override
  String get trip_edit_button_end_date => 'Date de fin';

  @override
  String get trip_editor_new_title => 'Nouveau voyage';

  @override
  String get trip_editor_edit_title => 'Modifier le voyage';

  @override
  String get trip_editor_field_country_label => 'Pays ISO';

  @override
  String get trip_editor_field_country_helper => 'Ex. JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'Nom du voyage';

  @override
  String get trip_editor_field_description_label => 'Remarques (facultatif)';

  @override
  String get trip_editor_field_start_date_label => 'Date de début';

  @override
  String get trip_editor_field_end_date_label => 'Date de fin';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days jours';
  }

  @override
  String get trip_editor_error_country_required =>
      'Veuillez saisir un code ISO de pays.';

  @override
  String get trip_editor_error_name_required =>
      'Veuillez saisir un nom de voyage.';

  @override
  String get trip_editor_error_dates_required =>
      'Veuillez sélectionner une date de début et une date de fin.';

  @override
  String get trip_editor_error_date_order =>
      'La date de fin ne peut pas être antérieure à la date de début.';

  @override
  String get trip_editor_save_button => 'Enregistrer le voyage';

  @override
  String get step_menu_edit => 'Modifier l\'étape';

  @override
  String get step_menu_delete => 'Supprimer l\'étape';

  @override
  String get step_delete_confirm_title => 'Supprimer l\'étape ?';

  @override
  String get step_delete_confirm_body =>
      'Cette note sera supprimée de la chronologie du voyage.';

  @override
  String get step_editor_add_title => 'Nouvelle étape';

  @override
  String get step_editor_edit_title => 'Modifier l\'étape';

  @override
  String get step_editor_field_description_label => 'Description de l\'étape';

  @override
  String get step_editor_field_place_label => 'Nom du lieu (facultatif)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'Date et heure : $value';
  }

  @override
  String get step_editor_hint_diary => 'Écrivez sur ce moment...';

  @override
  String get step_editor_header_add_place_hint => 'Ajoutez où vous êtes';

  @override
  String get step_editor_place_hint => 'Ville, lieu ou point de repère';

  @override
  String get step_editor_button_add_photos => 'Ajouter des photos';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count photos sélectionnées';
  }

  @override
  String get step_editor_error_pick_images =>
      'Erreur lors de la sélection des images.';

  @override
  String get step_editor_error_empty_description =>
      'Veuillez ajouter une brève description pour cette étape.';

  @override
  String get step_media_add_web_unsupported =>
      'L\'ajout de photos n\'est pris en charge que sur mobile et ordinateur de bureau.';

  @override
  String get generic_error_saving_step =>
      'Impossible d\'enregistrer l\'étape. Veuillez réessayer.';

  @override
  String get fab_add_step_tooltip => 'Ajouter une étape';

  @override
  String get fab_add_step_upgrade_tooltip => 'Mettre à niveau vers Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'Vous avez atteint la limite de $steps pas par trajet avec le forfait Free. Passez à Pro pour continuer à tenir un journal.';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'Vous avez atteint la limite d\'étapes pour ce plan. Passez à Pro pour continuer à tenir un journal.';

  @override
  String get btn_add_step => 'Ajouter une étape';

  @override
  String get btn_save => 'Sauvegarder';

  @override
  String get btn_cancel => 'Annuler';

  @override
  String get btn_delete => 'Supprimer';

  @override
  String get on_this_day_title => 'Ce jour-là';

  @override
  String get on_this_day_empty =>
      'Aucun déplacement enregistré ce jour pour l\'instant.';

  @override
  String get stats_title => 'Tableau de bord global';

  @override
  String get stats_sign_in_prompt =>
      'Veuillez vous connecter pour voir les statistiques.';

  @override
  String get stats_highlights_title => 'Points forts';

  @override
  String get stats_metric_trips_logged => 'Voyages enregistrés';

  @override
  String get stats_metric_travel_heavy_year => 'Année riche en voyages';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days jours';
  }

  @override
  String get stats_value_not_available => 'Pas disponible';

  @override
  String get stats_empty_message =>
      'Ajoutez votre premier voyage pour débloquer des statistiques.';

  @override
  String get stats_highlight_average_days => 'Jours moyens par voyage';

  @override
  String get stats_highlight_longest_trip => 'Le plus long voyage';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days jours - $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'Voyage le plus récent';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'Objectifs de voyage';

  @override
  String get goals_new_goal_button => 'Nouvel objectif';

  @override
  String get goals_dialog_title => 'Créer un objectif';

  @override
  String get goals_field_title_label => 'Titre';

  @override
  String get goals_field_year_label => 'Année';

  @override
  String get goals_field_target_label => 'Pays cibles';

  @override
  String get goals_delete_tooltip => 'Supprimer l\'objectif';

  @override
  String goals_card_year_label(Object year) {
    return 'Année $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target pays visités';
  }

  @override
  String get goals_empty_title => 'Pas encore de but';

  @override
  String get goals_empty_description =>
      'Définissez votre objectif annuel par pays et nous suivrons automatiquement vos progrès.';

  @override
  String get goals_empty_cta => 'Créer un objectif';

  @override
  String get account_title => 'Compte';

  @override
  String get plan_free => '__MARQUE__ Gratuit';

  @override
  String get plan_upgrade => 'Mettre à niveau vers Pro';

  @override
  String get year_in_review_title => 'Bilan de l\'année';

  @override
  String get trip_story_title => 'Récit de voyage';

  @override
  String get home_sign_in_prompt =>
      'Veuillez vous connecter ou continuer en tant qu\'invité pour commencer à suivre vos voyages.';

  @override
  String generic_error(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get no_trips_yet => 'Pas encore de voyages.';

  @override
  String get stat_countries_visited => 'Pays visités';

  @override
  String get stat_days_abroad => 'Journées à l\'étranger';

  @override
  String get stat_last_trip => 'Dernier voyage';

  @override
  String on_this_day_label(Object date) {
    return 'Ce jour-là : $date';
  }

  @override
  String get btn_open_trip => 'Voyage ouvert';

  @override
  String country_sheet_days(Object count) {
    return 'Jours : $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'Déplacements : $count';
  }

  @override
  String get country_sheet_view_trips => 'Voir les voyages dans ce pays';

  @override
  String get country_sheet_add_trip => 'Ajouter un voyage';

  @override
  String get country_sheet_no_photos_title => 'Pas encore de photos ici';

  @override
  String get country_sheet_no_photos_message =>
      'Ajoutez des médias à vos voyages et ils apparaîtront ici.';

  @override
  String get country_overview_subtitle => 'Aperçu du pays';

  @override
  String get country_overview_label_trips => 'Voyages';

  @override
  String get country_overview_label_days => 'Jours';

  @override
  String get country_overview_label_steps => 'Mesures';

  @override
  String get country_overview_label_photos => 'Photos';

  @override
  String get country_overview_label_last_visited => 'Dernière visite';

  @override
  String get country_overview_last_visited_never => 'Jamais visité';

  @override
  String get country_overview_empty_trips_message =>
      'Ajoutez votre premier voyage dans ce pays pour débloquer des informations.';

  @override
  String get country_overview_action_view_trips => 'Voir les voyages';

  @override
  String get country_overview_action_add_trip => 'Ajouter un voyage';

  @override
  String get country_overview_action_close => 'Fermer';

  @override
  String get guest_user => 'Utilisateur invité';

  @override
  String get plan_active => 'Forfait actif';

  @override
  String get auth_welcome => 'Bienvenue chez WorldTrace';

  @override
  String get auth_login => 'Se connecter';

  @override
  String get auth_signup => 'S\'inscrire';

  @override
  String get auth_continue_guest => 'Continuer en tant qu\'invité';

  @override
  String get trip_deleted => 'Voyage supprimé.';

  @override
  String get trip_menu_delete => 'Supprimer le voyage';

  @override
  String get trip_delete_confirm_title => 'Supprimer ce voyage ?';

  @override
  String get trip_delete_confirm_body =>
      'Le voyage et toutes ses étapes seront définitivement supprimés.';

  @override
  String get trip_delete_missing_id_error =>
      'Impossible de supprimer un voyage sans pièce d\'identité.';

  @override
  String get menu_open_details => 'Ouvrir les détails';

  @override
  String get menu_delete_trip => 'Supprimer le voyage';

  @override
  String get tooltip_add_trip => 'Ajouter un voyage';

  @override
  String get drawer_achievements => 'Réalisations';

  @override
  String get achievements_sign_in_prompt =>
      'Connectez-vous pour voir vos réalisations.';

  @override
  String get year_in_review_share_tooltip => 'Partager l\'histoire de l\'année';

  @override
  String get year_in_review_sign_in_prompt =>
      'Connectez-vous pour voir votre bilan de l\'année.';

  @override
  String get year_in_review_no_trips =>
      'Ajoutez quelques voyages pour débloquer votre avis.';

  @override
  String get year_in_review_no_data_for_year =>
      'Revue non disponible pour cette année.';

  @override
  String year_in_review_map_title(Object year) {
    return 'Carte de voyage $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'Votre $year en voyage';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days jours - $trips voyages - $countries pays';
  }

  @override
  String get year_in_review_longest_trip => 'Le plus long voyage';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days jours';
  }

  @override
  String get year_in_review_top_country => 'Meilleur pays';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days jours';
  }

  @override
  String get year_in_review_no_photo_highlights =>
      'Aucune photo marquante pour l\'instant';

  @override
  String get year_in_review_no_achievements =>
      'Aucun succès débloqué (pour l\'instant).';

  @override
  String get year_in_review_unlocked_achievements => 'Succès débloqués';

  @override
  String get year_in_review_render_error => 'Impossible de générer l\'image.';

  @override
  String get year_in_review_encode_error =>
      'Erreur lors de la création de l\'image.';

  @override
  String year_in_review_share_message(Object year) {
    return 'Mon $year en voyage avec WorldTrace';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'Échec du partage : $error';
  }

  @override
  String get trip_story_share_tooltip => 'Partager une histoire';

  @override
  String get trip_story_share_render_error =>
      'Impossible de générer l\'histoire.';

  @override
  String get trip_story_share_image_error =>
      'Erreur lors de la création de l\'image.';

  @override
  String trip_story_share_message(Object country) {
    return 'Mon voyage en $country avec WorldTrace';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'Échec du partage : $error';
  }

  @override
  String get trip_story_stat_steps => 'Mesures';

  @override
  String get trip_story_stat_photos => 'Photos';

  @override
  String get trip_story_stat_days => 'Jours';

  @override
  String get settings_profile_section_title => 'Profil';

  @override
  String get settings_plan_section_title => 'Forfait __MARQUE__';

  @override
  String get settings_logout_button => 'Se déconnecter';

  @override
  String get plan_pro => '__MARQUE__ Pro';

  @override
  String get settings_plan_description_pro =>
      'Délais illimités et outils de voyage premium.';

  @override
  String settings_plan_description_free(Object steps) {
    return 'Jusqu\'à $steps pas par trajet. Passez à Pro pour débloquer des délais illimités et des statistiques avancées.';
  }

  @override
  String profile_birthdate_label(Object date) {
    return 'Né le $date';
  }

  @override
  String get profile_birthdate_not_set => 'Non défini';

  @override
  String get profile_edit_button => 'Modifier le profil';

  @override
  String get profile_edit_title => 'Modifier le profil';

  @override
  String get profile_photo_change => 'Changer de photo';

  @override
  String get profile_photo_remove => 'Supprimer la photo';

  @override
  String get profile_first_name_label => 'Prénom';

  @override
  String get profile_last_name_label => 'Nom de famille';

  @override
  String get profile_birthdate_title => 'Date de naissance';

  @override
  String get profile_birthdate_pick => 'Choisir';

  @override
  String get plan_support_thanks => 'Merci de soutenir WorldTrace !';

  @override
  String get profile_plan_section_title => 'Plan';

  @override
  String get profile_plan_current_pro =>
      'Forfait actuel : Pro - pas illimités par trajet.';

  @override
  String profile_plan_current_free(Object steps) {
    return 'Forfait actuel : Gratuit - jusqu\'à $steps pas par trajet.';
  }

  @override
  String get profile_sign_in_prompt =>
      'Connectez-vous pour afficher votre profil de voyage.';

  @override
  String get profile_no_data => 'Aucune donnée disponible.';

  @override
  String get profile_travel_summary_title => 'Résumé du voyage';

  @override
  String get profile_stat_trips => 'Voyages';

  @override
  String get profile_stat_countries => 'Pays';

  @override
  String get profile_stat_days => 'Jours';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'Année la plus intense : $year - $days jours';
  }

  @override
  String get profile_top_year_empty =>
      'Commencez à enregistrer vos voyages pour débloquer des statistiques annuelles.';

  @override
  String get profile_achievements_title => 'Réalisations';

  @override
  String get profile_see_all => 'Voir tout';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'Succès débloqués : $unlocked sur $total';
  }

  @override
  String get profile_goals_title => 'Objectifs';

  @override
  String get profile_goals_manage => 'Gérer';

  @override
  String get profile_goals_empty =>
      'Fixez-vous ici un objectif national annuel pour suivre vos progrès.';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'Année $year - $current/$target pays';
  }

  @override
  String get profile_view_year_button => 'Voir votre année';

  @override
  String get profile_share_button => 'Partager mon profil';

  @override
  String get profile_share_no_trips =>
      'Je commence à suivre mes voyages avec WorldTrace. Suivez-moi dans ma prochaine aventure !';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'J\'ai enregistré $trips voyages, visité $countries pays et passé $days jours à voyager avec WorldTrace.';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'Mon année la plus intense a été $year avec $days jours sur la route.';
  }

  @override
  String get step_detail_section_story => 'Histoire';

  @override
  String get step_detail_story_empty =>
      'Aucune histoire n\'a été ajoutée pour cette étape.';

  @override
  String get step_detail_section_photos => 'Photos';

  @override
  String get step_detail_action_share => 'Partager';

  @override
  String get step_media_web_unsupported =>
      'Le partage d\'images n\'est pas pris en charge sur le Web.';

  @override
  String get step_media_image_missing => 'Image introuvable sur cet appareil.';

  @override
  String get step_media_share_text =>
      'Un instantané de mon voyage avec WorldTrace';

  @override
  String get step_media_share_failed => 'Impossible de partager cette image.';

  @override
  String step_media_title(Object current, Object total) {
    return 'Photo $current/$total';
  }

  @override
  String get step_media_share_tooltip => 'Partager';

  @override
  String get upgrade_title => 'Débloquez WorldTrace Pro';

  @override
  String get upgrade_headline => 'Mise à niveau sans limites';

  @override
  String get upgrade_description =>
      'Optez pour Pro pour continuer à raconter vos histoires avec des délais illimités et des outils axés sur les voyageurs.';

  @override
  String get upgrade_benefit_unlimited_steps =>
      'Aucune limite de pas par trajet';

  @override
  String get upgrade_benefit_advanced_stats =>
      'Statistiques et objectifs avancés (à venir)';

  @override
  String get upgrade_benefit_heavy_users => 'Conçu pour les gros voyageurs';

  @override
  String get upgrade_benefit_early_access =>
      'Accès anticipé aux fonctionnalités expérimentales';

  @override
  String get upgrade_success_message => 'WorldTrace Pro activé !';

  @override
  String get upgrade_maybe_later => 'Peut-être plus tard';

  @override
  String get home_welcome_title => 'Accueillir';

  @override
  String get home_next_trip_prompt =>
      'Prêt à enregistrer votre prochain voyage ?';

  @override
  String get world_map_sign_in_prompt =>
      'Connectez-vous ou continuez en tant qu\'invité pour afficher votre carte de voyage.';

  @override
  String get world_map_empty_message =>
      'Ajoutez votre premier voyage pour voir la carte.';

  @override
  String trip_story_open_failed(Object error) {
    return 'Impossible d\'ouvrir le récit de voyage : $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'L\'affichage des photos en plein écran n\'est pris en charge que sur les appareils mobiles et les ordinateurs de bureau.';

  @override
  String get onboarding_track_countries_title => 'Suivre les pays';

  @override
  String get onboarding_track_countries_subtitle =>
      'Ajoutez des voyages, des souvenirs et des statistiques';

  @override
  String get onboarding_set_goals_title => 'Fixer des objectifs';

  @override
  String get onboarding_set_goals_subtitle =>
      'Créer des objectifs comme \"30 pays d\'ici 2030\"';

  @override
  String get onboarding_share_remember_title => 'Partagez et souvenez-vous';

  @override
  String get onboarding_share_remember_subtitle =>
      'Créez des cartes partageables de vos voyages';

  @override
  String get achievement_first_trip_title => 'Premier voyage enregistré';

  @override
  String get achievement_first_trip_description =>
      'Enregistrez votre tout premier voyage dans WorldTrace.';

  @override
  String get achievement_five_trips_title => 'Club cinq voyages';

  @override
  String get achievement_five_trips_description =>
      'Atteignez cinq voyages enregistrés dans votre journal.';

  @override
  String get achievement_ten_trips_title => 'Jalon des dix voyages';

  @override
  String get achievement_ten_trips_description =>
      'Planifiez et enregistrez au moins dix aventures.';

  @override
  String get achievement_five_countries_title => 'Globe-trotter I';

  @override
  String get achievement_five_countries_description =>
      'Visitez cinq pays différents.';

  @override
  String get achievement_ten_countries_title => 'Globe-trotter II';

  @override
  String get achievement_ten_countries_description =>
      'Atteignez dix pays uniques.';

  @override
  String get achievement_thirty_days_title => '30 jours par an';

  @override
  String get achievement_thirty_days_description =>
      'Passez plus de 30 jours à voyager au cours de la même année.';

  @override
  String get achievement_hundred_days_title => '100 jours sur la route';

  @override
  String get achievement_hundred_days_description =>
      'Cumulez cent jours de voyage au total.';

  @override
  String get auth_continue_email => 'Continuez avec email';

  @override
  String get auth_continue_google => 'Continuer avec Google';

  @override
  String get auth_continue_facebook => 'Continuer avec Facebook';
}
