// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'होम/डैशबोर्ड';

  @override
  String get drawer_world_map => 'विश्व मानचित्र';

  @override
  String get drawer_trips => 'ट्रिप्स';

  @override
  String get drawer_stats => 'आँकड़े';

  @override
  String get drawer_goals => 'लक्ष्य';

  @override
  String get drawer_profile => 'यात्रा प्रोफ़ाइल';

  @override
  String get drawer_account => 'अकाउंट सेटिंग';

  @override
  String get gallery_title => 'गैलरी';

  @override
  String get gallery_nav_label => 'गैलरी';

  @override
  String get gallery_profile_cta => 'सभी तस्वीरें देखें';

  @override
  String get gallery_empty_title => 'अभी तक कोई फ़ोटो नहीं';

  @override
  String get gallery_empty_message =>
      'अपनी यात्राओं में मीडिया जोड़ें और वे यहां दिखाई देंगे।';

  @override
  String get trips_title => 'ट्रिप्स';

  @override
  String get trip_detail_timeline => 'समय';

  @override
  String get trip_detail_empty_steps_message =>
      'अभी तक कोई कदम नहीं. अपनी यात्रा कहानी पहले नोट से शुरू करें।';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count चरण';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '$count दिन',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'समय';

  @override
  String get trip_detail_section_photos_trip => 'तस्वीरें';

  @override
  String get trip_edit_title_new => 'नई यात्रा';

  @override
  String get trip_edit_title_edit => 'यात्रा संपादित करें';

  @override
  String get trip_edit_button_save => 'बचाना';

  @override
  String get trip_edit_button_create => 'बनाएं';

  @override
  String get trip_edit_field_country_iso_label => 'देश आईएसओ कोड';

  @override
  String get trip_edit_field_country_iso_help => 'उदा. JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'यात्रा का नाम';

  @override
  String get trip_edit_field_notes_label => 'नोट्स (वैकल्पिक)';

  @override
  String get trip_edit_button_start_date => 'आरंभ करने की तिथि';

  @override
  String get trip_edit_button_end_date => 'अंतिम तिथि';

  @override
  String get trip_editor_new_title => 'नई यात्रा';

  @override
  String get trip_editor_edit_title => 'यात्रा संपादित करें';

  @override
  String get trip_editor_field_country_label => 'देश आईएसओ';

  @override
  String get trip_editor_field_country_helper => 'उदा. JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'यात्रा का नाम';

  @override
  String get trip_editor_field_description_label => 'नोट्स (वैकल्पिक)';

  @override
  String get trip_editor_field_start_date_label => 'आरंभ करने की तिथि';

  @override
  String get trip_editor_field_end_date_label => 'अंतिम तिथि';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days दिन';
  }

  @override
  String get trip_editor_error_country_required =>
      'कृपया एक देश आईएसओ कोड दर्ज करें।';

  @override
  String get trip_editor_error_name_required =>
      'कृपया यात्रा का नाम दर्ज करें.';

  @override
  String get trip_editor_error_dates_required =>
      'कृपया प्रारंभ और समाप्ति तिथि दोनों का चयन करें।';

  @override
  String get trip_editor_error_date_order =>
      'समाप्ति तिथि आरंभ तिथि से पहले नहीं हो सकती.';

  @override
  String get trip_editor_save_button => 'यात्रा सहेजें';

  @override
  String get step_menu_edit => 'चरण संपादित करें';

  @override
  String get step_menu_delete => 'चरण हटाएँ';

  @override
  String get step_delete_confirm_title => 'चरण हटाएं?';

  @override
  String get step_delete_confirm_body =>
      'यह नोट यात्रा समयरेखा से हटा दिया जाएगा।';

  @override
  String get step_editor_add_title => 'नया कदम';

  @override
  String get step_editor_edit_title => 'चरण संपादित करें';

  @override
  String get step_editor_field_description_label => 'चरण विवरण';

  @override
  String get step_editor_field_place_label => 'स्थान का नाम (वैकल्पिक)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'दिनांक और समय: $value';
  }

  @override
  String get step_editor_hint_diary => 'इस पल के बारे में लिखें...';

  @override
  String get step_editor_header_add_place_hint => 'आप जहां हैं वहां जोड़ें';

  @override
  String get step_editor_place_hint => 'शहर, स्थान या मील का पत्थर';

  @override
  String get step_editor_button_add_photos => 'तस्वीरें जोडो';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count फ़ोटो चयनित';
  }

  @override
  String get step_editor_error_pick_images => 'छवियाँ चुनते समय त्रुटि.';

  @override
  String get step_editor_error_empty_description =>
      'कृपया इस चरण के लिए एक संक्षिप्त विवरण जोड़ें.';

  @override
  String get step_media_add_web_unsupported =>
      'फ़ोटो जोड़ना केवल मोबाइल और डेस्कटॉप पर समर्थित है।';

  @override
  String get generic_error_saving_step =>
      'चरण सहेजने में असमर्थ. कृपया पुन: प्रयास करें।';

  @override
  String get fab_add_step_tooltip => 'चरण जोड़ें';

  @override
  String get fab_add_step_upgrade_tooltip => 'प्रो में अपग्रेड__';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'आप निःशुल्क योजना पर प्रति यात्रा $steps चरणों की सीमा तक पहुँच गए हैं। जर्नलिंग जारी रखने के लिए Pro में अपग्रेड करें।';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'आप इस योजना के चरणों की सीमा तक पहुंच गए हैं. जर्नलिंग जारी रखने के लिए Pro में अपग्रेड करें।';

  @override
  String get btn_add_step => 'चरण जोड़ें';

  @override
  String get btn_save => 'बचाना';

  @override
  String get btn_cancel => 'रद्द करना';

  @override
  String get btn_delete => 'मिटाना';

  @override
  String get on_this_day_title => 'इस दिन';

  @override
  String get on_this_day_empty =>
      'इस दिन अभी तक कोई यात्रा रिकॉर्ड नहीं की गई है.';

  @override
  String get stats_title => 'वैश्विक डैशबोर्ड';

  @override
  String get stats_sign_in_prompt => 'आँकड़े देखने के लिए कृपया साइन इन करें।';

  @override
  String get stats_highlights_title => 'हाइलाइट';

  @override
  String get stats_metric_trips_logged => 'यात्राएँ लॉग की गईं';

  @override
  String get stats_metric_travel_heavy_year => 'यात्रा-भारी वर्ष';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days दिन';
  }

  @override
  String get stats_value_not_available => 'उपलब्ध नहीं है';

  @override
  String get stats_empty_message =>
      'आँकड़े अनलॉक करने के लिए अपनी पहली यात्रा जोड़ें।';

  @override
  String get stats_highlight_average_days => 'प्रति यात्रा औसत दिन';

  @override
  String get stats_highlight_longest_trip => 'सबसे लंबी यात्रा';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days दिन - $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'सबसे हाल की यात्रा';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'यात्रा लक्ष्य';

  @override
  String get goals_new_goal_button => 'नया लक्ष्य';

  @override
  String get goals_dialog_title => 'लक्ष्य बनाएं';

  @override
  String get goals_field_title_label => 'शीर्षक';

  @override
  String get goals_field_year_label => 'वर्ष';

  @override
  String get goals_field_target_label => 'लक्षित देश';

  @override
  String get goals_delete_tooltip => 'लक्ष्य हटाएँ';

  @override
  String goals_card_year_label(Object year) {
    return 'वर्ष $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target देशों का दौरा किया';
  }

  @override
  String get goals_empty_title => 'अभी तक कोई लक्ष्य नहीं';

  @override
  String get goals_empty_description =>
      'अपना वार्षिक देश लक्ष्य निर्धारित करें और हम आपकी प्रगति को स्वचालित रूप से ट्रैक करेंगे।';

  @override
  String get goals_empty_cta => 'एक लक्ष्य बनाएं';

  @override
  String get account_title => 'खाता';

  @override
  String get plan_free => '__ब्रांड__ निःशुल्क';

  @override
  String get plan_upgrade => 'प्रो में अपग्रेड__';

  @override
  String get year_in_review_title => 'सर्वेक्षण का वर्ष';

  @override
  String get trip_story_title => 'यात्रा कथा';

  @override
  String get home_sign_in_prompt =>
      'अपनी यात्राओं पर नज़र रखना शुरू करने के लिए कृपया साइन इन करें या अतिथि के रूप में जारी रखें।';

  @override
  String generic_error(Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get no_trips_yet => 'अभी तक कोई यात्रा नहीं.';

  @override
  String get stat_countries_visited => 'देशों का दौरा किया';

  @override
  String get stat_days_abroad => 'विदेश में दिन';

  @override
  String get stat_last_trip => 'अंतिम यात्रा';

  @override
  String on_this_day_label(Object date) {
    return 'इस दिन: $date';
  }

  @override
  String get btn_open_trip => 'खुली यात्रा';

  @override
  String country_sheet_days(Object count) {
    return 'दिन: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'यात्राएँ: $count';
  }

  @override
  String get country_sheet_view_trips => 'इस देश में यात्राएँ देखें';

  @override
  String get country_sheet_add_trip => 'यात्रा जोड़ें';

  @override
  String get country_sheet_no_photos_title => 'यहां अभी तक कोई फोटो नहीं है';

  @override
  String get country_sheet_no_photos_message =>
      'अपनी यात्राओं में मीडिया जोड़ें और वे यहां दिखाई देंगे।';

  @override
  String get country_overview_subtitle => 'देश का सिंहावलोकन';

  @override
  String get country_overview_label_trips => 'ट्रिप्स';

  @override
  String get country_overview_label_days => 'दिन';

  @override
  String get country_overview_label_steps => 'कदम';

  @override
  String get country_overview_label_photos => 'तस्वीरें';

  @override
  String get country_overview_label_last_visited => 'अंतिम बार दौरा किया';

  @override
  String get country_overview_last_visited_never => 'कभी दौरा नहीं किया';

  @override
  String get country_overview_empty_trips_message =>
      'अंतर्दृष्टि अनलॉक करने के लिए इस देश में अपनी पहली यात्रा जोड़ें।';

  @override
  String get country_overview_action_view_trips => 'यात्राएँ देखें';

  @override
  String get country_overview_action_add_trip => 'एक यात्रा जोड़ें';

  @override
  String get country_overview_action_close => 'बंद करना';

  @override
  String get guest_user => 'अतिथि उपयोक्ता';

  @override
  String get plan_active => 'सक्रिय योजना';

  @override
  String get auth_welcome => '__ब्रांड__ में आपका स्वागत है';

  @override
  String get auth_login => 'लॉग इन करें';

  @override
  String get auth_signup => 'साइन अप करें';

  @override
  String get auth_continue_guest => 'अतिथि के रूप में जारी रखें';

  @override
  String get trip_deleted => 'यात्रा हटा दी गई.';

  @override
  String get trip_menu_delete => 'यात्रा हटाएँ';

  @override
  String get trip_delete_confirm_title => 'यह यात्रा हटाएं?';

  @override
  String get trip_delete_confirm_body =>
      'यात्रा और उसके सभी चरण स्थायी रूप से हटा दिए जाएंगे.';

  @override
  String get trip_delete_missing_id_error =>
      'बिना आईडी के यात्रा को हटाने में असमर्थ.';

  @override
  String get menu_open_details => 'विवरण खोलें';

  @override
  String get menu_delete_trip => 'यात्रा हटाएँ';

  @override
  String get tooltip_add_trip => 'यात्रा जोड़ें';

  @override
  String get drawer_achievements => 'उपलब्धियों';

  @override
  String get achievements_sign_in_prompt =>
      'अपनी उपलब्धियाँ देखने के लिए साइन इन करें.';

  @override
  String get year_in_review_share_tooltip => 'वर्ष की कहानी साझा करें';

  @override
  String get year_in_review_sign_in_prompt =>
      'अपने वर्ष की समीक्षा देखने के लिए साइन इन करें।';

  @override
  String get year_in_review_no_trips =>
      'अपनी समीक्षा अनलॉक करने के लिए कुछ यात्राएँ जोड़ें।';

  @override
  String get year_in_review_no_data_for_year =>
      'इस वर्ष के लिए समीक्षा उपलब्ध नहीं है.';

  @override
  String year_in_review_map_title(Object year) {
    return 'यात्रा मानचित्र $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'यात्रा में आपका $year';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days दिन - $trips यात्राएं - $countries देश';
  }

  @override
  String get year_in_review_longest_trip => 'सबसे लंबी यात्रा';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days दिन';
  }

  @override
  String get year_in_review_top_country => 'शीर्ष देश';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days दिन';
  }

  @override
  String get year_in_review_no_photo_highlights =>
      'अभी तक कोई फोटो हाइलाइट नहीं';

  @override
  String get year_in_review_no_achievements =>
      'कोई उपलब्धि अनलॉक नहीं हुई (अभी तक)।';

  @override
  String get year_in_review_unlocked_achievements => 'अनलॉक उपलब्धियां';

  @override
  String get year_in_review_render_error => 'छवि उत्पन्न करने में असमर्थ.';

  @override
  String get year_in_review_encode_error => 'छवि बनाते समय त्रुटि.';

  @override
  String year_in_review_share_message(Object year) {
    return 'मेरा $year __ब्रांड__ के साथ यात्रा पर है';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'साझा करना विफल: $error';
  }

  @override
  String get trip_story_share_tooltip => 'कहानी साझा करें';

  @override
  String get trip_story_share_render_error => 'कहानी उत्पन्न करने में असमर्थ.';

  @override
  String get trip_story_share_image_error => 'छवि बनाते समय त्रुटि.';

  @override
  String trip_story_share_message(Object country) {
    return '$country में WorldTrace के साथ मेरी यात्रा';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'साझा करना विफल: $error';
  }

  @override
  String get trip_story_stat_steps => 'कदम';

  @override
  String get trip_story_stat_photos => 'तस्वीरें';

  @override
  String get trip_story_stat_days => 'दिन';

  @override
  String get settings_profile_section_title => 'प्रोफ़ाइल';

  @override
  String get settings_plan_section_title => '__ब्रांड__ योजना';

  @override
  String get settings_logout_button => 'लॉग आउट';

  @override
  String get plan_pro => '__ब्रांड__ __प्रो__';

  @override
  String get settings_plan_description_pro =>
      'असीमित समयसीमा और प्रीमियम यात्रा उपकरण।';

  @override
  String settings_plan_description_free(Object steps) {
    return 'प्रति यात्रा $steps कदम तक। असीमित समयसीमा और उन्नत आँकड़े अनलॉक करने के लिए Pro में अपग्रेड करें।';
  }

  @override
  String profile_birthdate_label(Object date) {
    return '$date को जन्म';
  }

  @override
  String get profile_birthdate_not_set => 'सेट नहीं';

  @override
  String get profile_edit_button => 'प्रोफ़ाइल संपादित करें';

  @override
  String get profile_edit_title => 'प्रोफ़ाइल संपादित करें';

  @override
  String get profile_photo_change => 'छवि बदलो';

  @override
  String get profile_photo_remove => 'फ़ोटो हटाएँ';

  @override
  String get profile_first_name_label => 'पहला नाम';

  @override
  String get profile_last_name_label => 'उपनाम';

  @override
  String get profile_birthdate_title => 'जन्म तिथि';

  @override
  String get profile_birthdate_pick => 'चुनना';

  @override
  String get plan_support_thanks => '__ब्रांड__ का समर्थन करने के लिए धन्यवाद!';

  @override
  String get profile_plan_section_title => 'योजना';

  @override
  String get profile_plan_current_pro =>
      'वर्तमान योजना: Pro - प्रति यात्रा असीमित कदम।';

  @override
  String profile_plan_current_free(Object steps) {
    return 'वर्तमान योजना: निःशुल्क - प्रति यात्रा $steps कदम तक।';
  }

  @override
  String get profile_sign_in_prompt =>
      'अपनी यात्रा प्रोफ़ाइल देखने के लिए साइन इन करें।';

  @override
  String get profile_no_data => 'कोई डेटा मौजूद नहीं।';

  @override
  String get profile_travel_summary_title => 'यात्रा सारांश';

  @override
  String get profile_stat_trips => 'ट्रिप्स';

  @override
  String get profile_stat_countries => 'देशों';

  @override
  String get profile_stat_days => 'दिन';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'सबसे गहन वर्ष: $year - $days दिन';
  }

  @override
  String get profile_top_year_empty =>
      'वार्षिक आँकड़े अनलॉक करने के लिए अपनी यात्राओं को लॉग करना प्रारंभ करें।';

  @override
  String get profile_achievements_title => 'उपलब्धियों';

  @override
  String get profile_see_all => 'सभी देखें';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'अनलॉक उपलब्धियां: $unlocked में से $total';
  }

  @override
  String get profile_goals_title => 'लक्ष्य';

  @override
  String get profile_goals_manage => 'प्रबंधित करना';

  @override
  String get profile_goals_empty =>
      'यहां अपनी प्रगति पर नज़र रखने के लिए एक वार्षिक देश लक्ष्य निर्धारित करें।';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'वर्ष $year - $current/$target देश';
  }

  @override
  String get profile_view_year_button => 'अपना वर्ष देखें';

  @override
  String get profile_share_button => 'मेरी प्रोफ़ाइल साझा करें';

  @override
  String get profile_share_no_trips =>
      'मैं __ब्रांड__ के साथ अपनी यात्राओं को ट्रैक करना शुरू कर रहा हूं। मेरे अगले साहसिक कार्य पर मेरा अनुसरण करें!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'मैंने $trips यात्राएं लॉग की हैं, $countries देशों का दौरा किया है, और WorldTrace के साथ यात्रा करते हुए $days दिन बिताए हैं।';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'मेरा सबसे गहन वर्ष $year था जिसमें सड़क पर $days दिन थे।';
  }

  @override
  String get step_detail_section_story => 'कहानी';

  @override
  String get step_detail_story_empty =>
      'इस चरण के लिए कोई कहानी नहीं जोड़ी गई.';

  @override
  String get step_detail_section_photos => 'तस्वीरें';

  @override
  String get step_detail_action_share => 'शेयर करना';

  @override
  String get step_media_web_unsupported =>
      'वेब पर छवि साझाकरण समर्थित नहीं है.';

  @override
  String get step_media_image_missing => 'इस डिवाइस पर छवि नहीं मिली.';

  @override
  String get step_media_share_text =>
      '__ब्रांड__ के साथ मेरी यात्रा की एक तस्वीर';

  @override
  String get step_media_share_failed => 'इस छवि को साझा करने में असमर्थ.';

  @override
  String step_media_title(Object current, Object total) {
    return 'फ़ोटो$current/$total';
  }

  @override
  String get step_media_share_tooltip => 'शेयर करना';

  @override
  String get upgrade_title => 'अनलॉक __ब्रांड__ __प्रो__';

  @override
  String get upgrade_headline => 'बिना किसी सीमा के अपग्रेड करें';

  @override
  String get upgrade_description =>
      'असीमित समयसीमा और यात्री-केंद्रित टूल के साथ अपनी कहानियाँ सुनाते रहने के लिए Pro पर जाएँ।';

  @override
  String get upgrade_benefit_unlimited_steps =>
      'प्रति यात्रा कोई चरण सीमा नहीं';

  @override
  String get upgrade_benefit_advanced_stats =>
      'उन्नत आँकड़े और लक्ष्य (जल्द ही आ रहे हैं)';

  @override
  String get upgrade_benefit_heavy_users => 'भारी यात्रियों के लिए बनाया गया';

  @override
  String get upgrade_benefit_early_access =>
      'प्रायोगिक सुविधाओं तक शीघ्र पहुंच';

  @override
  String get upgrade_success_message => '__ब्रांड__ Pro सक्रिय!';

  @override
  String get upgrade_maybe_later => 'शायद बाद में';

  @override
  String get home_welcome_title => 'स्वागत';

  @override
  String get home_next_trip_prompt =>
      'क्या आप अपनी अगली यात्रा लॉग करने के लिए तैयार हैं?';

  @override
  String get world_map_sign_in_prompt =>
      'अपना यात्रा मानचित्र देखने के लिए साइन इन करें या अतिथि के रूप में जारी रखें।';

  @override
  String get world_map_empty_message =>
      'मानचित्र देखने के लिए अपनी पहली यात्रा जोड़ें।';

  @override
  String trip_story_open_failed(Object error) {
    return 'ट्रिप स्टोरी खोलने में असमर्थ: $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'फ़ुल-स्क्रीन फ़ोटो देखना केवल मोबाइल और डेस्कटॉप पर समर्थित है।';

  @override
  String get onboarding_track_countries_title => 'देशों को ट्रैक करें';

  @override
  String get onboarding_track_countries_subtitle =>
      'यात्राएँ, यादें और आँकड़े जोड़ें';

  @override
  String get onboarding_set_goals_title => 'लक्ष्य बनाना';

  @override
  String get onboarding_set_goals_subtitle =>
      '\"2030 तक 30 देश\" जैसे लक्ष्य बनाएं';

  @override
  String get onboarding_share_remember_title => 'साझा करें और याद रखें';

  @override
  String get onboarding_share_remember_subtitle =>
      'अपनी यात्रा के साझा करने योग्य कार्ड बनाएं';

  @override
  String get achievement_first_trip_title => 'पहली यात्रा लॉग की गई';

  @override
  String get achievement_first_trip_description =>
      'अपनी पहली यात्रा को __ब्रांड__ में लॉग करें।';

  @override
  String get achievement_five_trips_title => 'पाँच यात्राएँ क्लब';

  @override
  String get achievement_five_trips_description =>
      'अपनी पत्रिका में दर्ज पाँच यात्राओं तक पहुँचें।';

  @override
  String get achievement_ten_trips_title => 'दस यात्राएँ मील का पत्थर';

  @override
  String get achievement_ten_trips_description =>
      'कम से कम दस साहसिक कार्यों की योजना बनाएं और लॉग इन करें।';

  @override
  String get achievement_five_countries_title => 'ग्लोबट्रॉटर आई';

  @override
  String get achievement_five_countries_description =>
      'पाँच अलग-अलग देशों की यात्रा करें।';

  @override
  String get achievement_ten_countries_title => 'ग्लोबट्रॉटर II';

  @override
  String get achievement_ten_countries_description =>
      'दस अद्वितीय देशों तक पहुंचें.';

  @override
  String get achievement_thirty_days_title => 'साल में 30 दिन';

  @override
  String get achievement_thirty_days_description =>
      'एक ही वर्ष में यात्रा करते हुए 30+ दिन बिताएं।';

  @override
  String get achievement_hundred_days_title => 'सड़क पर 100 दिन';

  @override
  String get achievement_hundred_days_description =>
      'कुल मिलाकर एक सौ यात्रा दिवस संचित करें।';

  @override
  String get auth_continue_email => 'email के साथ जारी रखें';

  @override
  String get auth_continue_google => 'Google के साथ जारी रखें';

  @override
  String get auth_continue_facebook => '__Facebook__ के साथ जारी रखें';
}
