// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'Главная / Панель управления';

  @override
  String get drawer_world_map => 'Карта мира';

  @override
  String get drawer_trips => 'Путешествия';

  @override
  String get drawer_stats => 'Статистика';

  @override
  String get drawer_goals => 'Цели';

  @override
  String get drawer_profile => 'Профиль путешествия';

  @override
  String get drawer_account => 'Настройки учетной записи';

  @override
  String get gallery_title => 'Галерея';

  @override
  String get gallery_nav_label => 'Галерея';

  @override
  String get gallery_profile_cta => 'Посмотреть все фотографии';

  @override
  String get gallery_empty_title => 'Фото пока нет';

  @override
  String get gallery_empty_message =>
      'Добавьте медиа в свои поездки, и они появятся здесь.';

  @override
  String get trips_title => 'Путешествия';

  @override
  String get trip_detail_timeline => 'Хронология';

  @override
  String get trip_detail_empty_steps_message =>
      'Никаких шагов пока нет. Начните свой рассказ о путешествии с первой заметки.';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count шагов';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дни',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'Хронология';

  @override
  String get trip_detail_section_photos_trip => 'Фотографии';

  @override
  String get trip_edit_title_new => 'Новая поездка';

  @override
  String get trip_edit_title_edit => 'Изменить поездку';

  @override
  String get trip_edit_button_save => 'Сохранять';

  @override
  String get trip_edit_button_create => 'Создавать';

  @override
  String get trip_edit_field_country_iso_label => 'ISO-код страны';

  @override
  String get trip_edit_field_country_iso_help => 'Напр.: JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'Название поездки';

  @override
  String get trip_edit_field_notes_label => 'Примечания (необязательно)';

  @override
  String get trip_edit_button_start_date => 'Дата начала';

  @override
  String get trip_edit_button_end_date => 'Дата окончания';

  @override
  String get trip_editor_new_title => 'Новая поездка';

  @override
  String get trip_editor_edit_title => 'Изменить поездку';

  @override
  String get trip_editor_field_country_label => 'Страна ИСО';

  @override
  String get trip_editor_field_country_helper => 'Напр.: JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'Название поездки';

  @override
  String get trip_editor_field_description_label =>
      'Примечания (необязательно)';

  @override
  String get trip_editor_field_start_date_label => 'Дата начала';

  @override
  String get trip_editor_field_end_date_label => 'Дата окончания';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days дней';
  }

  @override
  String get trip_editor_error_country_required =>
      'Пожалуйста, введите ISO-код страны.';

  @override
  String get trip_editor_error_name_required => 'Введите название поездки.';

  @override
  String get trip_editor_error_dates_required =>
      'Пожалуйста, выберите дату начала и окончания.';

  @override
  String get trip_editor_error_date_order =>
      'Дата окончания не может быть раньше даты начала.';

  @override
  String get trip_editor_save_button => 'Сохранить поездку';

  @override
  String get step_menu_edit => 'Изменить шаг';

  @override
  String get step_menu_delete => 'Удалить шаг';

  @override
  String get step_delete_confirm_title => 'Удалить шаг?';

  @override
  String get step_delete_confirm_body =>
      'Эта заметка будет удалена из хронологии поездки.';

  @override
  String get step_editor_add_title => 'Новый шаг';

  @override
  String get step_editor_edit_title => 'Изменить шаг';

  @override
  String get step_editor_field_description_label => 'Описание шага';

  @override
  String get step_editor_field_place_label => 'Название места (необязательно)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'Дата и время: $value';
  }

  @override
  String get step_editor_hint_diary => 'Напишите об этом моменте...';

  @override
  String get step_editor_header_add_place_hint => 'Добавьте, где вы находитесь';

  @override
  String get step_editor_place_hint => 'Город, место или достопримечательность';

  @override
  String get step_editor_button_add_photos => 'Добавить фотографии';

  @override
  String step_editor_photos_selected(Object count) {
    return 'Выбрано $count фотографий';
  }

  @override
  String get step_editor_error_pick_images => 'Ошибка при выборе изображений.';

  @override
  String get step_editor_error_empty_description =>
      'Добавьте краткое описание этого шага.';

  @override
  String get step_media_add_web_unsupported =>
      'Добавление фотографий поддерживается только на мобильных устройствах и компьютерах.';

  @override
  String get generic_error_saving_step =>
      'Не удалось сохранить шаг. Пожалуйста, попробуйте еще раз.';

  @override
  String get fab_add_step_tooltip => 'Добавить шаг';

  @override
  String get fab_add_step_upgrade_tooltip => 'Обновите до Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'Вы достигли предела в $steps шагов за поездку по бесплатному плану. Обновите версию до Pro, чтобы продолжать вести журнал.';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'Вы достигли максимального количества шагов для этого плана. Обновите версию до Pro, чтобы продолжать вести журнал.';

  @override
  String get btn_add_step => 'Добавить шаг';

  @override
  String get btn_save => 'Сохранять';

  @override
  String get btn_cancel => 'Отмена';

  @override
  String get btn_delete => 'Удалить';

  @override
  String get on_this_day_title => 'В этот день';

  @override
  String get on_this_day_empty =>
      'В этот день еще не зарегистрировано ни одной поездки.';

  @override
  String get stats_title => 'Глобальная информационная панель';

  @override
  String get stats_sign_in_prompt =>
      'Пожалуйста, войдите, чтобы увидеть статистику.';

  @override
  String get stats_highlights_title => 'Основные моменты';

  @override
  String get stats_metric_trips_logged => 'Зарегистрировано поездок';

  @override
  String get stats_metric_travel_heavy_year => 'Год, насыщенный путешествиями';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year – $days дней';
  }

  @override
  String get stats_value_not_available => 'Нет в наличии';

  @override
  String get stats_empty_message =>
      'Добавьте свою первую поездку, чтобы разблокировать статистику.';

  @override
  String get stats_highlight_average_days =>
      'Среднее количество дней в поездке';

  @override
  String get stats_highlight_longest_trip => 'Самая длинная поездка';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days дней - $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'Самая последняя поездка';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'Цели путешествия';

  @override
  String get goals_new_goal_button => 'Новая цель';

  @override
  String get goals_dialog_title => 'Создать цель';

  @override
  String get goals_field_title_label => 'Заголовок';

  @override
  String get goals_field_year_label => 'Год';

  @override
  String get goals_field_target_label => 'Целевые страны';

  @override
  String get goals_delete_tooltip => 'Удалить цель';

  @override
  String goals_card_year_label(Object year) {
    return 'Год $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target посещенных стран';
  }

  @override
  String get goals_empty_title => 'Целей пока нет';

  @override
  String get goals_empty_description =>
      'Установите годовую цель для страны, и мы будем автоматически отслеживать ваш прогресс.';

  @override
  String get goals_empty_cta => 'Создать цель';

  @override
  String get account_title => 'Счет';

  @override
  String get plan_free => '__БРЭНД__ Бесплатно';

  @override
  String get plan_upgrade => 'Обновите до Pro';

  @override
  String get year_in_review_title => 'Обзор года';

  @override
  String get trip_story_title => 'История поездки';

  @override
  String get home_sign_in_prompt =>
      'Пожалуйста, войдите в систему или продолжите работу в качестве гостя, чтобы начать отслеживать свои поездки.';

  @override
  String generic_error(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get no_trips_yet => 'Поездок пока нет.';

  @override
  String get stat_countries_visited => 'Посещенные страны';

  @override
  String get stat_days_abroad => 'Дни за границей';

  @override
  String get stat_last_trip => 'Последняя поездка';

  @override
  String on_this_day_label(Object date) {
    return 'В этот день: $date';
  }

  @override
  String get btn_open_trip => 'Открытая поездка';

  @override
  String country_sheet_days(Object count) {
    return 'Дни: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'Поездки: $count';
  }

  @override
  String get country_sheet_view_trips => 'Посмотреть поездки в эту страну';

  @override
  String get country_sheet_add_trip => 'Добавить поездку';

  @override
  String get country_sheet_no_photos_title => 'Здесь пока нет фотографий';

  @override
  String get country_sheet_no_photos_message =>
      'Добавьте медиа в свои поездки, и они появятся здесь.';

  @override
  String get country_overview_subtitle => 'Обзор страны';

  @override
  String get country_overview_label_trips => 'Путешествия';

  @override
  String get country_overview_label_days => 'Дни';

  @override
  String get country_overview_label_steps => 'Шаги';

  @override
  String get country_overview_label_photos => 'Фотографии';

  @override
  String get country_overview_label_last_visited => 'Последнее посещение';

  @override
  String get country_overview_last_visited_never => 'Никогда не посещал';

  @override
  String get country_overview_empty_trips_message =>
      'Добавьте свою первую поездку в эту страну, чтобы получить ценную информацию.';

  @override
  String get country_overview_action_view_trips => 'Посмотреть поездки';

  @override
  String get country_overview_action_add_trip => 'Добавить поездку';

  @override
  String get country_overview_action_close => 'Закрывать';

  @override
  String get guest_user => 'Гость пользователь';

  @override
  String get plan_active => 'Активный план';

  @override
  String get auth_welcome => 'Добро пожаловать в WorldTrace';

  @override
  String get auth_login => 'Авторизоваться';

  @override
  String get auth_signup => 'Зарегистрироваться';

  @override
  String get auth_continue_guest => 'Продолжить в качестве гостя';

  @override
  String get trip_deleted => 'Поездка удалена.';

  @override
  String get trip_menu_delete => 'Удалить поездку';

  @override
  String get trip_delete_confirm_title => 'Удалить эту поездку?';

  @override
  String get trip_delete_confirm_body =>
      'Поездка и все ее этапы будут удалены без возможности восстановления.';

  @override
  String get trip_delete_missing_id_error =>
      'Невозможно удалить поездку без идентификатора.';

  @override
  String get menu_open_details => 'Открыть детали';

  @override
  String get menu_delete_trip => 'Удалить поездку';

  @override
  String get tooltip_add_trip => 'Добавить поездку';

  @override
  String get drawer_achievements => 'Достижения';

  @override
  String get achievements_sign_in_prompt =>
      'Войдите, чтобы просмотреть свои достижения.';

  @override
  String get year_in_review_share_tooltip => 'Поделитесь историей года';

  @override
  String get year_in_review_sign_in_prompt =>
      'Войдите в систему, чтобы просмотреть обзор своего года.';

  @override
  String get year_in_review_no_trips =>
      'Добавьте несколько поездок, чтобы разблокировать свой отзыв.';

  @override
  String get year_in_review_no_data_for_year => 'Обзор недоступен в этом году.';

  @override
  String year_in_review_map_title(Object year) {
    return 'Карта путешествия $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'Ваш $year в путешествии';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days дней - $trips поездок - $countries стран';
  }

  @override
  String get year_in_review_longest_trip => 'Самая длинная поездка';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title – $days дней';
  }

  @override
  String get year_in_review_top_country => 'Лучшая страна';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country – $days дней';
  }

  @override
  String get year_in_review_no_photo_highlights => 'Пока нет ярких фотографий';

  @override
  String get year_in_review_no_achievements =>
      'Достижения не разблокированы (пока).';

  @override
  String get year_in_review_unlocked_achievements =>
      'Разблокированные достижения';

  @override
  String get year_in_review_render_error => 'Не удалось создать изображение.';

  @override
  String get year_in_review_encode_error => 'Ошибка при создании изображения.';

  @override
  String year_in_review_share_message(Object year) {
    return 'Мой $year в путешествии с WorldTrace';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'Не удалось поделиться: $error';
  }

  @override
  String get trip_story_share_tooltip => 'Поделиться историей';

  @override
  String get trip_story_share_render_error => 'Не удалось создать историю.';

  @override
  String get trip_story_share_image_error => 'Ошибка при создании изображения.';

  @override
  String trip_story_share_message(Object country) {
    return 'Моя поездка в $country с WorldTrace';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'Не удалось поделиться: $error';
  }

  @override
  String get trip_story_stat_steps => 'Шаги';

  @override
  String get trip_story_stat_photos => 'Фотографии';

  @override
  String get trip_story_stat_days => 'Дни';

  @override
  String get settings_profile_section_title => 'Профиль';

  @override
  String get settings_plan_section_title => 'WorldTrace план';

  @override
  String get settings_logout_button => 'Выйти';

  @override
  String get plan_pro => '__БРЕНД__ Pro';

  @override
  String get settings_plan_description_pro =>
      'Неограниченные сроки и инструменты для путешествий премиум-класса.';

  @override
  String settings_plan_description_free(Object steps) {
    return 'До $steps шагов за поездку. Обновите версию до Pro, чтобы разблокировать неограниченные сроки и расширенную статистику.';
  }

  @override
  String profile_birthdate_label(Object date) {
    return 'Родился $date';
  }

  @override
  String get profile_birthdate_not_set => 'Не установлено';

  @override
  String get profile_edit_button => 'Редактировать профиль';

  @override
  String get profile_edit_title => 'Редактировать профиль';

  @override
  String get profile_photo_change => 'Изменить фотографию';

  @override
  String get profile_photo_remove => 'Удалить фото';

  @override
  String get profile_first_name_label => 'Имя';

  @override
  String get profile_last_name_label => 'Фамилия';

  @override
  String get profile_birthdate_title => 'Дата рождения';

  @override
  String get profile_birthdate_pick => 'Выбирать';

  @override
  String get plan_support_thanks => 'Спасибо за поддержку WorldTrace!';

  @override
  String get profile_plan_section_title => 'План';

  @override
  String get profile_plan_current_pro =>
      'Текущий план: Pro — неограниченное количество шагов за поездку.';

  @override
  String profile_plan_current_free(Object steps) {
    return 'Текущий план: Бесплатно — до $steps шагов за поездку.';
  }

  @override
  String get profile_sign_in_prompt =>
      'Войдите, чтобы просмотреть свой профиль путешествия.';

  @override
  String get profile_no_data => 'Данные отсутствуют.';

  @override
  String get profile_travel_summary_title => 'Краткое описание путешествия';

  @override
  String get profile_stat_trips => 'Путешествия';

  @override
  String get profile_stat_countries => 'Страны';

  @override
  String get profile_stat_days => 'Дни';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'Самый интенсивный год: $year - $days дней.';
  }

  @override
  String get profile_top_year_empty =>
      'Начните регистрировать свои поездки, чтобы разблокировать годовую статистику.';

  @override
  String get profile_achievements_title => 'Достижения';

  @override
  String get profile_see_all => 'Посмотреть все';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'Разблокированные достижения: $unlocked из $total.';
  }

  @override
  String get profile_goals_title => 'Цели';

  @override
  String get profile_goals_manage => 'Управлять';

  @override
  String get profile_goals_empty =>
      'Установите годовую цель для страны, чтобы отслеживать свой прогресс здесь.';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'Год $year – $current/$target стран';
  }

  @override
  String get profile_view_year_button => 'Увидеть свой год';

  @override
  String get profile_share_button => 'Поделитесь моим профилем';

  @override
  String get profile_share_no_trips =>
      'Я начинаю отслеживать свои поездки с помощью WorldTrace. Следуй за мной в моем следующем приключении!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'Я зарегистрировал $trips поездок, посетил $countries стран и провел $days дней, путешествуя с WorldTrace.';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'Мой самый напряженный год был $year, когда я был в дороге $days дней.';
  }

  @override
  String get step_detail_section_story => 'История';

  @override
  String get step_detail_story_empty =>
      'Для этого шага история не была добавлена.';

  @override
  String get step_detail_section_photos => 'Фотографии';

  @override
  String get step_detail_action_share => 'Делиться';

  @override
  String get step_media_web_unsupported =>
      'Обмен изображениями в Интернете не поддерживается.';

  @override
  String get step_media_image_missing =>
      'Изображение не найдено на этом устройстве.';

  @override
  String get step_media_share_text => 'Кадр из моей поездки с WorldTrace';

  @override
  String get step_media_share_failed =>
      'Невозможно поделиться этим изображением.';

  @override
  String step_media_title(Object current, Object total) {
    return 'Фото $current/$total';
  }

  @override
  String get step_media_share_tooltip => 'Делиться';

  @override
  String get upgrade_title => 'Разблокируйте WorldTrace Pro';

  @override
  String get upgrade_headline => 'Обновление без ограничений';

  @override
  String get upgrade_description =>
      'Перейдите на Pro, чтобы продолжать рассказывать свои истории, используя неограниченные сроки и инструменты, ориентированные на путешественников.';

  @override
  String get upgrade_benefit_unlimited_steps =>
      'Нет ограничений по шагам за поездку';

  @override
  String get upgrade_benefit_advanced_stats =>
      'Расширенная статистика и цели (скоро)';

  @override
  String get upgrade_benefit_heavy_users =>
      'Создан для тяжелых путешественников';

  @override
  String get upgrade_benefit_early_access =>
      'Ранний доступ к экспериментальным функциям';

  @override
  String get upgrade_success_message => 'WorldTrace Pro активирован!';

  @override
  String get upgrade_maybe_later => 'Может быть, позже';

  @override
  String get home_welcome_title => 'Добро пожаловать';

  @override
  String get home_next_trip_prompt => 'Готовы записать свою следующую поездку?';

  @override
  String get world_map_sign_in_prompt =>
      'Войдите в систему или продолжите работу в качестве гостя, чтобы просмотреть карту путешествий.';

  @override
  String get world_map_empty_message =>
      'Добавьте свою первую поездку, чтобы увидеть карту.';

  @override
  String trip_story_open_failed(Object error) {
    return 'Невозможно открыть историю путешествия: $error.';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'Полноэкранный просмотр фотографий поддерживается только на мобильных устройствах и компьютерах.';

  @override
  String get onboarding_track_countries_title => 'Отслеживать страны';

  @override
  String get onboarding_track_countries_subtitle =>
      'Добавляйте поездки, воспоминания и статистику';

  @override
  String get onboarding_set_goals_title => 'Ставьте цели';

  @override
  String get onboarding_set_goals_subtitle =>
      'Поставьте цели типа «30 стран к 2030 году».';

  @override
  String get onboarding_share_remember_title => 'Поделитесь и запомните';

  @override
  String get onboarding_share_remember_subtitle =>
      'Создавайте общие карты своих путешествий';

  @override
  String get achievement_first_trip_title => 'Записана первая поездка';

  @override
  String get achievement_first_trip_description =>
      'Запишите свою первую поездку в WorldTrace.';

  @override
  String get achievement_five_trips_title => 'Клуб пяти поездок';

  @override
  String get achievement_five_trips_description =>
      'Совершите пять поездок, записанных в вашем журнале.';

  @override
  String get achievement_ten_trips_title => 'Десять поездок';

  @override
  String get achievement_ten_trips_description =>
      'Запланируйте и запишите не менее десяти приключений.';

  @override
  String get achievement_five_countries_title => 'Путешественник I';

  @override
  String get achievement_five_countries_description =>
      'Посетите пять разных стран.';

  @override
  String get achievement_ten_countries_title => 'Путешественник II';

  @override
  String get achievement_ten_countries_description =>
      'Доберитесь до десяти уникальных стран.';

  @override
  String get achievement_thirty_days_title => '30 дней в году';

  @override
  String get achievement_thirty_days_description =>
      'Проведите более 30 дней в путешествии в течение одного года.';

  @override
  String get achievement_hundred_days_title => '100 дней в пути';

  @override
  String get achievement_hundred_days_description =>
      'Накопите в общей сложности сто дней путешествия.';

  @override
  String get auth_continue_email => 'Продолжить с email';

  @override
  String get auth_continue_google => 'Продолжить с Google';

  @override
  String get auth_continue_facebook => 'Продолжить с Facebook';
}
