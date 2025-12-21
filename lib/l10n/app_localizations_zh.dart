// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => '主页 / 仪表板';

  @override
  String get drawer_world_map => '世界地图';

  @override
  String get drawer_trips => '行程';

  @override
  String get drawer_stats => '统计数据';

  @override
  String get drawer_goals => '目标';

  @override
  String get drawer_profile => '旅行简介';

  @override
  String get drawer_account => '帐户/设置';

  @override
  String get gallery_title => '画廊';

  @override
  String get gallery_nav_label => '画廊';

  @override
  String get gallery_profile_cta => '查看所有照片';

  @override
  String get gallery_empty_title => '还没有照片';

  @override
  String get gallery_empty_message => '将媒体添加到您的旅行中，它们将显示在此处。';

  @override
  String get trips_title => '行程';

  @override
  String get trip_detail_timeline => '时间轴';

  @override
  String get trip_detail_empty_steps_message => '还没有步骤。从第一个音符开始你的旅行故事。';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count 步骤';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天',
      one: '$count 天',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => '时间轴';

  @override
  String get trip_detail_section_photos_trip => '照片';

  @override
  String get trip_edit_title_new => '新旅程';

  @override
  String get trip_edit_title_edit => '编辑行程';

  @override
  String get trip_edit_button_save => '节省';

  @override
  String get trip_edit_button_create => '创造';

  @override
  String get trip_edit_field_country_iso_label => '国家 ISO 代码';

  @override
  String get trip_edit_field_country_iso_help => '例如：JP, US, IT';

  @override
  String get trip_edit_field_name_label => '行程名称';

  @override
  String get trip_edit_field_notes_label => '注释（可选）';

  @override
  String get trip_edit_button_start_date => '开始日期';

  @override
  String get trip_edit_button_end_date => '结束日期';

  @override
  String get trip_editor_new_title => '新旅程';

  @override
  String get trip_editor_edit_title => '编辑行程';

  @override
  String get trip_editor_field_country_label => '国家ISO';

  @override
  String get trip_editor_field_country_helper => '例如：JP, US, IT';

  @override
  String get trip_editor_field_name_label => '行程名称';

  @override
  String get trip_editor_field_description_label => '注释（可选）';

  @override
  String get trip_editor_field_start_date_label => '开始日期';

  @override
  String get trip_editor_field_end_date_label => '结束日期';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days 天';
  }

  @override
  String get trip_editor_error_country_required => '请输入国家/地区 ISO 代码。';

  @override
  String get trip_editor_error_name_required => '请输入行程名称。';

  @override
  String get trip_editor_error_dates_required => '请选择开始日期和结束日期。';

  @override
  String get trip_editor_error_date_order => '结束日期不能早于开始日期。';

  @override
  String get trip_editor_save_button => '保存行程';

  @override
  String get step_menu_edit => '编辑步骤';

  @override
  String get step_menu_delete => '删除步骤';

  @override
  String get step_delete_confirm_title => '删除步骤？';

  @override
  String get step_delete_confirm_body => '该注释将从行程时间表中删除。';

  @override
  String get step_editor_add_title => '新的一步';

  @override
  String get step_editor_edit_title => '编辑步骤';

  @override
  String get step_editor_field_description_label => '步骤说明';

  @override
  String get step_editor_field_place_label => '地名（可选）';

  @override
  String step_editor_field_date_time_label(Object value) {
    return '日期和时间：$value';
  }

  @override
  String get step_editor_hint_diary => '写下这一刻...';

  @override
  String get step_editor_header_add_place_hint => '添加您所在位置';

  @override
  String get step_editor_place_hint => '城市、地点或地标';

  @override
  String get step_editor_button_add_photos => '添加照片';

  @override
  String step_editor_photos_selected(Object count) {
    return '已选择 $count 照片';
  }

  @override
  String get step_editor_error_pick_images => '选择图像时出错。';

  @override
  String get step_editor_error_empty_description => '请为此步骤添加简短说明。';

  @override
  String get step_media_add_web_unsupported => '仅支持在移动设备和桌面设备上添加照片。';

  @override
  String get generic_error_saving_step => '无法保存该步骤。请再试一次。';

  @override
  String get fab_add_step_tooltip => '添加步骤';

  @override
  String get fab_add_step_upgrade_tooltip => '升级到Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return '您已达到免费计划每次行程 $steps 步的限制。升级到 Pro 以继续写日记。';
  }

  @override
  String get plan_limit_steps_reached_generic => '您已达到此计划的步数限制。升级到 Pro 以继续写日记。';

  @override
  String get btn_add_step => '添加步骤';

  @override
  String get btn_save => '节省';

  @override
  String get btn_cancel => '取消';

  @override
  String get btn_delete => '删除';

  @override
  String get on_this_day_title => '在这一天';

  @override
  String get on_this_day_empty => '这一天尚未记录任何行程。';

  @override
  String get stats_title => '全球仪表板';

  @override
  String get stats_sign_in_prompt => '请登录查看统计数据。';

  @override
  String get stats_highlights_title => '亮点';

  @override
  String get stats_metric_trips_logged => '记录的行程';

  @override
  String get stats_metric_travel_heavy_year => '旅行频繁的一年';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days 天';
  }

  @override
  String get stats_value_not_available => '无法使用';

  @override
  String get stats_empty_message => '添加您的第一次旅行以解锁统计数据。';

  @override
  String get stats_highlight_average_days => '每次出行平均天数';

  @override
  String get stats_highlight_longest_trip => '最长的行程';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days 天 - $destination';
  }

  @override
  String get stats_highlight_recent_trip => '最近的旅行';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => '旅行目标';

  @override
  String get goals_new_goal_button => '新目标';

  @override
  String get goals_dialog_title => '创建目标';

  @override
  String get goals_field_title_label => '标题';

  @override
  String get goals_field_year_label => '年';

  @override
  String get goals_field_target_label => '目标国家';

  @override
  String get goals_delete_tooltip => '删除目标';

  @override
  String goals_card_year_label(Object year) {
    return '年 $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target 访问过的国家';
  }

  @override
  String get goals_empty_title => '还没有目标';

  @override
  String get goals_empty_description => '设置您的年度国家/地区目标，我们将自动跟踪您的进度。';

  @override
  String get goals_empty_cta => '创建一个目标';

  @override
  String get account_title => '帐户';

  @override
  String get plan_free => '__品牌__ 免费';

  @override
  String get plan_upgrade => '升级到Pro';

  @override
  String get year_in_review_title => '年度回顾';

  @override
  String get trip_story_title => '旅行故事';

  @override
  String get home_sign_in_prompt => '请登录或继续以访客身份开始跟踪您的行程。';

  @override
  String generic_error(Object error) {
    return '错误：$error';
  }

  @override
  String get no_trips_yet => '还没有旅行。';

  @override
  String get stat_countries_visited => '访问过的国家';

  @override
  String get stat_days_abroad => '国外的日子';

  @override
  String get stat_last_trip => '最后一次旅行';

  @override
  String on_this_day_label(Object date) {
    return '这一天：$date';
  }

  @override
  String get btn_open_trip => '开启行程';

  @override
  String country_sheet_days(Object count) {
    return '天数：$count';
  }

  @override
  String country_sheet_trips(Object count) {
    return '行程：$count';
  }

  @override
  String get country_sheet_view_trips => '查看这个国家的旅行';

  @override
  String get country_sheet_add_trip => '添加行程';

  @override
  String get country_sheet_no_photos_title => '这里还没有照片';

  @override
  String get country_sheet_no_photos_message => '将媒体添加到您的旅行中，它们将显示在此处。';

  @override
  String get country_overview_subtitle => '国家概况';

  @override
  String get country_overview_label_trips => '行程';

  @override
  String get country_overview_label_days => '天';

  @override
  String get country_overview_label_steps => '步骤';

  @override
  String get country_overview_label_photos => '照片';

  @override
  String get country_overview_label_last_visited => '上次访问';

  @override
  String get country_overview_last_visited_never => '从未访问过';

  @override
  String get country_overview_empty_trips_message => '添加您在这个国家的第一次旅行以解锁见解。';

  @override
  String get country_overview_action_view_trips => '查看行程';

  @override
  String get country_overview_action_add_trip => '添加行程';

  @override
  String get country_overview_action_close => '关闭';

  @override
  String get guest_user => '访客用户';

  @override
  String get plan_active => '主动计划';

  @override
  String get auth_welcome => '欢迎来到__品牌__';

  @override
  String get auth_login => '登录';

  @override
  String get auth_signup => '报名';

  @override
  String get auth_continue_guest => '继续以访客身份';

  @override
  String get trip_deleted => '行程已删除。';

  @override
  String get trip_menu_delete => '删除行程';

  @override
  String get trip_delete_confirm_title => '删除此行程？';

  @override
  String get trip_delete_confirm_body => '该行程及其所有步骤将被永久删除。';

  @override
  String get trip_delete_missing_id_error => '无法删除没有 ID 的行程。';

  @override
  String get menu_open_details => '打开详情';

  @override
  String get menu_delete_trip => '删除行程';

  @override
  String get tooltip_add_trip => '添加行程';

  @override
  String get drawer_achievements => '成就';

  @override
  String get achievements_sign_in_prompt => '登录查看您的成就。';

  @override
  String get year_in_review_share_tooltip => '分享当年的故事';

  @override
  String get year_in_review_sign_in_prompt => '登录查看您的年度回顾。';

  @override
  String get year_in_review_no_trips => '添加一些旅行来解锁您的评论。';

  @override
  String get year_in_review_no_data_for_year => '今年无法进行审查。';

  @override
  String year_in_review_map_title(Object year) {
    return '旅游地图$year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return '您在旅行中的 $year';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days 天 - $trips 次行程 - $countries 个国家/地区';
  }

  @override
  String get year_in_review_longest_trip => '最长的行程';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days 天';
  }

  @override
  String get year_in_review_top_country => '顶级国家';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days 天';
  }

  @override
  String get year_in_review_no_photo_highlights => '还没有照片亮点';

  @override
  String get year_in_review_no_achievements => '尚未解锁任何成就。';

  @override
  String get year_in_review_unlocked_achievements => '解锁成就';

  @override
  String get year_in_review_render_error => '无法生成图像。';

  @override
  String get year_in_review_encode_error => '创建图像时出错。';

  @override
  String year_in_review_share_message(Object year) {
    return '我的 $year 与 WorldTrace 一起旅行';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return '共享失败：$error';
  }

  @override
  String get trip_story_share_tooltip => '分享故事';

  @override
  String get trip_story_share_render_error => '无法生成故事。';

  @override
  String get trip_story_share_image_error => '创建图像时出错。';

  @override
  String trip_story_share_message(Object country) {
    return '我与 WorldTrace 一起在 $country 旅行';
  }

  @override
  String trip_story_share_failed(Object error) {
    return '共享失败：$error';
  }

  @override
  String get trip_story_stat_steps => '步骤';

  @override
  String get trip_story_stat_photos => '照片';

  @override
  String get trip_story_stat_days => '天';

  @override
  String get settings_profile_section_title => '轮廓';

  @override
  String get settings_plan_section_title => '__品牌__计划';

  @override
  String get settings_logout_button => '退出';

  @override
  String get plan_pro => '__品牌__ __专业__';

  @override
  String get settings_plan_description_pro => '无限的时间安排和优质的旅行工具。';

  @override
  String settings_plan_description_free(Object steps) {
    return '每次行程最多 $steps 步。升级到 Pro 以解锁无限的时间线和高级统计数据。';
  }

  @override
  String profile_birthdate_label(Object date) {
    return '出生于 $date';
  }

  @override
  String get profile_birthdate_not_set => '未设置';

  @override
  String get profile_edit_button => '编辑个人资料';

  @override
  String get profile_edit_title => '编辑个人资料';

  @override
  String get profile_photo_change => '更改照片';

  @override
  String get profile_photo_remove => '删除照片';

  @override
  String get profile_first_name_label => '名';

  @override
  String get profile_last_name_label => '姓';

  @override
  String get profile_birthdate_title => '出生日期';

  @override
  String get profile_birthdate_pick => '选择';

  @override
  String get plan_support_thanks => '感谢您对WorldTrace的支持！';

  @override
  String get profile_plan_section_title => '计划';

  @override
  String get profile_plan_current_pro => '当前计划：Pro - 每次行程不限步数。';

  @override
  String profile_plan_current_free(Object steps) {
    return '当前计划：免费 - 每次行程最多 $steps 步。';
  }

  @override
  String get profile_sign_in_prompt => '登录以查看您的旅行资料。';

  @override
  String get profile_no_data => '无可用数据。';

  @override
  String get profile_travel_summary_title => '旅行总结';

  @override
  String get profile_stat_trips => '行程';

  @override
  String get profile_stat_countries => '国家';

  @override
  String get profile_stat_days => '天';

  @override
  String profile_top_year_text(Object year, Object days) {
    return '最激烈的年份：$year - $days 天';
  }

  @override
  String get profile_top_year_empty => '开始记录您的旅行以解锁年度统计数据。';

  @override
  String get profile_achievements_title => '成就';

  @override
  String get profile_see_all => '查看全部';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return '已解锁成就：$unlocked（共 $total）';
  }

  @override
  String get profile_goals_title => '目标';

  @override
  String get profile_goals_manage => '管理';

  @override
  String get profile_goals_empty => '在这里设定年度国家目标来跟踪您的进展。';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return '年份 $year - $current/$target 国家/地区';
  }

  @override
  String get profile_view_year_button => '查看您的年份';

  @override
  String get profile_share_button => '分享我的个人资料';

  @override
  String get profile_share_no_trips => '我开始使用 WorldTrace 跟踪我的行程。跟随我进行下一次冒险！';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return '我已经记录了 $trips 次旅行，访问了 $countries 个国家，并与 WorldTrace 一起旅行了 $days 天。';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return '我最紧张的一年是 $year，其中 $days 天在路上。';
  }

  @override
  String get step_detail_section_story => '故事';

  @override
  String get step_detail_story_empty => '这一步没有添加任何故事。';

  @override
  String get step_detail_section_photos => '照片';

  @override
  String get step_detail_action_share => '分享';

  @override
  String get step_media_web_unsupported => '网络上不支持图像共享。';

  @override
  String get step_media_image_missing => '在此设备上找不到图像。';

  @override
  String get step_media_share_text => '我与 WorldTrace 一起旅行的快照';

  @override
  String get step_media_share_failed => '无法分享此图片。';

  @override
  String step_media_title(Object current, Object total) {
    return '照片$current/$total';
  }

  @override
  String get step_media_share_tooltip => '分享';

  @override
  String get upgrade_title => '解锁 WorldTrace Pro';

  @override
  String get upgrade_headline => '升级无限制';

  @override
  String get upgrade_description => '前往Pro，通过无限的时间线和以旅行者为中心的工具继续讲述您的故事。';

  @override
  String get upgrade_benefit_unlimited_steps => '每次行程没有步数限制';

  @override
  String get upgrade_benefit_advanced_stats => '高级统计数据和目标（即将推出）';

  @override
  String get upgrade_benefit_heavy_users => '专为重度旅行者打造';

  @override
  String get upgrade_benefit_early_access => '尽早使用实验性功能';

  @override
  String get upgrade_success_message => 'WorldTrace Pro 已激活！';

  @override
  String get upgrade_maybe_later => '也许稍后';

  @override
  String get home_welcome_title => '欢迎';

  @override
  String get home_next_trip_prompt => '准备好记录您的下一次旅行了吗？';

  @override
  String get world_map_sign_in_prompt => '登录或继续以访客身份查看您的旅行地图。';

  @override
  String get world_map_empty_message => '添加您的第一次行程以查看地图。';

  @override
  String trip_story_open_failed(Object error) {
    return '无法打开旅行故事：$error';
  }

  @override
  String get photo_viewer_web_unsupported => '仅在移动设备和桌面设备上支持全屏照片查看。';

  @override
  String get onboarding_track_countries_title => '追踪国家';

  @override
  String get onboarding_track_countries_subtitle => '添加旅行、回忆和统计数据';

  @override
  String get onboarding_set_goals_title => '设定目标';

  @override
  String get onboarding_set_goals_subtitle => '制定“到 2030 年覆盖 30 个国家”等目标';

  @override
  String get onboarding_share_remember_title => '分享并记住';

  @override
  String get onboarding_share_remember_subtitle => '创建可共享的旅行卡片';

  @override
  String get achievement_first_trip_title => '记录的第一次旅行';

  @override
  String get achievement_first_trip_description => '在 WorldTrace 中记录您的第一次旅行。';

  @override
  String get achievement_five_trips_title => '五次旅行俱乐部';

  @override
  String get achievement_five_trips_description => '达到日记中记录的五次旅行。';

  @override
  String get achievement_ten_trips_title => '十次旅行里程碑';

  @override
  String get achievement_ten_trips_description => '计划并记录至少十次冒险。';

  @override
  String get achievement_five_countries_title => '环球旅行者一号';

  @override
  String get achievement_five_countries_description => '访问五个不同的国家。';

  @override
  String get achievement_ten_countries_title => '环球旅行者II';

  @override
  String get achievement_ten_countries_description => '到达十个独特的国家。';

  @override
  String get achievement_thirty_days_title => '一年有30天';

  @override
  String get achievement_thirty_days_description => '一年内有 30 天以上的旅行时间。';

  @override
  String get achievement_hundred_days_title => '在路上的100天';

  @override
  String get achievement_hundred_days_description => '累计旅行天数一百。';

  @override
  String get auth_continue_email => '继续使用 email';

  @override
  String get auth_continue_google => '继续使用 Google';

  @override
  String get auth_continue_facebook => '继续Facebook';
}
