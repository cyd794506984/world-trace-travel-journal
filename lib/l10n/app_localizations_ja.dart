// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'ホーム / ダッシュボード';

  @override
  String get drawer_world_map => '世界地図';

  @override
  String get drawer_trips => '旅行';

  @override
  String get drawer_stats => '統計';

  @override
  String get drawer_goals => '目標';

  @override
  String get drawer_profile => '旅行プロフィール';

  @override
  String get drawer_account => 'アカウント設定';

  @override
  String get gallery_title => 'ギャラリー';

  @override
  String get gallery_nav_label => 'ギャラリー';

  @override
  String get gallery_profile_cta => 'すべての写真を見る';

  @override
  String get gallery_empty_title => '写真はまだありません';

  @override
  String get gallery_empty_message => '旅行にメディアを追加すると、ここに表示されます。';

  @override
  String get trips_title => '旅行';

  @override
  String get trip_detail_timeline => 'タイムライン';

  @override
  String get trip_detail_empty_steps_message =>
      'まだ手順はありません。最初のメモから旅行のストーリーを始めましょう。';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count ステップ';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 日',
      one: '$count 日',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'タイムライン';

  @override
  String get trip_detail_section_photos_trip => '写真';

  @override
  String get trip_edit_title_new => '新しい旅';

  @override
  String get trip_edit_title_edit => '旅行を編集する';

  @override
  String get trip_edit_button_save => '保存';

  @override
  String get trip_edit_button_create => '作成する';

  @override
  String get trip_edit_field_country_iso_label => '国別 ISO コード';

  @override
  String get trip_edit_field_country_iso_help => '例: JP, US, IT';

  @override
  String get trip_edit_field_name_label => '旅行名';

  @override
  String get trip_edit_field_notes_label => '注記 (オプション)';

  @override
  String get trip_edit_button_start_date => '開始日';

  @override
  String get trip_edit_button_end_date => '終了日';

  @override
  String get trip_editor_new_title => '新しい旅';

  @override
  String get trip_editor_edit_title => '旅行を編集する';

  @override
  String get trip_editor_field_country_label => '国 ISO';

  @override
  String get trip_editor_field_country_helper => '例: JP, US, IT';

  @override
  String get trip_editor_field_name_label => '旅行名';

  @override
  String get trip_editor_field_description_label => '注記 (オプション)';

  @override
  String get trip_editor_field_start_date_label => '開始日';

  @override
  String get trip_editor_field_end_date_label => '終了日';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days日';
  }

  @override
  String get trip_editor_error_country_required => '国の ISO コードを入力してください。';

  @override
  String get trip_editor_error_name_required => '旅行名を入力してください。';

  @override
  String get trip_editor_error_dates_required => '開始日と終了日の両方を選択してください。';

  @override
  String get trip_editor_error_date_order => '終了日を開始日より前にすることはできません。';

  @override
  String get trip_editor_save_button => '旅行を保存する';

  @override
  String get step_menu_edit => 'ステップの編集';

  @override
  String get step_menu_delete => 'ステップの削除';

  @override
  String get step_delete_confirm_title => 'ステップを削除しますか?';

  @override
  String get step_delete_confirm_body => 'このメモは旅行タイムラインから削除されます。';

  @override
  String get step_editor_add_title => '新たな一歩';

  @override
  String get step_editor_edit_title => 'ステップの編集';

  @override
  String get step_editor_field_description_label => 'ステップの説明';

  @override
  String get step_editor_field_place_label => '地名（任意）';

  @override
  String step_editor_field_date_time_label(Object value) {
    return '日付と時刻: $value';
  }

  @override
  String get step_editor_hint_diary => 'この瞬間について書きます...';

  @override
  String get step_editor_header_add_place_hint => '現在地を追加';

  @override
  String get step_editor_place_hint => '都市、場所、ランドマーク';

  @override
  String get step_editor_button_add_photos => '写真を追加する';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count 枚の写真が選択されました';
  }

  @override
  String get step_editor_error_pick_images => '画像の選択中にエラーが発生しました。';

  @override
  String get step_editor_error_empty_description => 'このステップの簡単な説明を追加してください。';

  @override
  String get step_media_add_web_unsupported =>
      '写真の追加はモバイルとデスクトップでのみサポートされています。';

  @override
  String get generic_error_saving_step => 'ステップを保存できません。もう一度試してください。';

  @override
  String get fab_add_step_tooltip => 'ステップの追加';

  @override
  String get fab_add_step_upgrade_tooltip => 'Pro にアップグレードする';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return '無料プランでは 1 回の旅行あたりの制限 $steps 歩に達しました。ジャーナリングを続けるには、Pro にアップグレードしてください。';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'このプランのステップ数の制限に達しました。ジャーナリングを続けるには、Pro にアップグレードしてください。';

  @override
  String get btn_add_step => 'ステップの追加';

  @override
  String get btn_save => '保存';

  @override
  String get btn_cancel => 'キャンセル';

  @override
  String get btn_delete => '消去';

  @override
  String get on_this_day_title => 'この日は';

  @override
  String get on_this_day_empty => 'この日の旅行はまだ記録されていません。';

  @override
  String get stats_title => 'グローバルダッシュボード';

  @override
  String get stats_sign_in_prompt => '統計を確認するにはサインインしてください。';

  @override
  String get stats_highlights_title => 'ハイライト';

  @override
  String get stats_metric_trips_logged => '記録された旅行';

  @override
  String get stats_metric_travel_heavy_year => '旅行の多い年';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year ～ $days 日';
  }

  @override
  String get stats_value_not_available => '利用不可';

  @override
  String get stats_empty_message => '最初の旅行を追加して統計のロックを解除します。';

  @override
  String get stats_highlight_average_days => '1 回の旅行あたりの平均日数';

  @override
  String get stats_highlight_longest_trip => '最長の旅行';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days 日 - $destination';
  }

  @override
  String get stats_highlight_recent_trip => '最近の旅行';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => '旅行の目標';

  @override
  String get goals_new_goal_button => '新しい目標';

  @override
  String get goals_dialog_title => '目標を作成する';

  @override
  String get goals_field_title_label => 'タイトル';

  @override
  String get goals_field_year_label => '年';

  @override
  String get goals_field_target_label => '対象国';

  @override
  String get goals_delete_tooltip => '目標の削除';

  @override
  String goals_card_year_label(Object year) {
    return '$year年';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target か国を訪問しました';
  }

  @override
  String get goals_empty_title => 'まだ目標はありません';

  @override
  String get goals_empty_description => '年間の国別目標を設定すると、進捗状況が自動的に追跡されます。';

  @override
  String get goals_empty_cta => '目標を作成する';

  @override
  String get account_title => 'アカウント';

  @override
  String get plan_free => '__ブランド__ 無料';

  @override
  String get plan_upgrade => 'Pro にアップグレードする';

  @override
  String get year_in_review_title => '一年の振り返り';

  @override
  String get trip_story_title => 'トリップストーリー';

  @override
  String get home_sign_in_prompt => '旅行の追跡を開始するには、サインインするか、ゲストとして続行してください。';

  @override
  String generic_error(Object error) {
    return 'エラー: $error';
  }

  @override
  String get no_trips_yet => 'まだ旅行はありません。';

  @override
  String get stat_countries_visited => '訪問国';

  @override
  String get stat_days_abroad => '海外での日々';

  @override
  String get stat_last_trip => '最後の旅行';

  @override
  String on_this_day_label(Object date) {
    return 'この日: $date';
  }

  @override
  String get btn_open_trip => 'オープントリップ';

  @override
  String country_sheet_days(Object count) {
    return '曜日: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return '旅行: $count';
  }

  @override
  String get country_sheet_view_trips => 'この国の旅行を見る';

  @override
  String get country_sheet_add_trip => '旅行を追加';

  @override
  String get country_sheet_no_photos_title => 'ここにはまだ写真がありません';

  @override
  String get country_sheet_no_photos_message => '旅行にメディアを追加すると、ここに表示されます。';

  @override
  String get country_overview_subtitle => '国の概要';

  @override
  String get country_overview_label_trips => '旅行';

  @override
  String get country_overview_label_days => '日数';

  @override
  String get country_overview_label_steps => 'ステップ';

  @override
  String get country_overview_label_photos => '写真';

  @override
  String get country_overview_label_last_visited => '最後に訪問した';

  @override
  String get country_overview_last_visited_never => '訪れたことがない';

  @override
  String get country_overview_empty_trips_message =>
      'この国への最初の旅行を追加して、洞察を解き明かしましょう。';

  @override
  String get country_overview_action_view_trips => '旅行を見る';

  @override
  String get country_overview_action_add_trip => '旅行を追加する';

  @override
  String get country_overview_action_close => '近い';

  @override
  String get guest_user => 'ゲストユーザー';

  @override
  String get plan_active => 'アクティブプラン';

  @override
  String get auth_welcome => '__ブランド__へようこそ';

  @override
  String get auth_login => 'ログイン';

  @override
  String get auth_signup => 'サインアップ';

  @override
  String get auth_continue_guest => 'ゲストとして続行';

  @override
  String get trip_deleted => '旅行が削除されました。';

  @override
  String get trip_menu_delete => '旅行の削除';

  @override
  String get trip_delete_confirm_title => 'この旅行を削除しますか?';

  @override
  String get trip_delete_confirm_body => '旅行とそのすべてのステップは完全に削除されます。';

  @override
  String get trip_delete_missing_id_error => 'ID がないと旅行を削除できません。';

  @override
  String get menu_open_details => '詳細を開く';

  @override
  String get menu_delete_trip => '旅行の削除';

  @override
  String get tooltip_add_trip => '旅行を追加';

  @override
  String get drawer_achievements => '業績';

  @override
  String get achievements_sign_in_prompt => 'サインインして実績を表示します。';

  @override
  String get year_in_review_share_tooltip => '年のストーリーを共有する';

  @override
  String get year_in_review_sign_in_prompt => 'サインインして、今年の振り返りを確認してください。';

  @override
  String get year_in_review_no_trips => 'レビューをロック解除するには、いくつかの旅行を追加します。';

  @override
  String get year_in_review_no_data_for_year => '今年のレビューはありません。';

  @override
  String year_in_review_map_title(Object year) {
    return 'トラベルマップ $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return '旅行中のあなたの$year';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days 日 - $trips 旅行 - $countries か国';
  }

  @override
  String get year_in_review_longest_trip => '最長の旅行';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title ～ $days 日';
  }

  @override
  String get year_in_review_top_country => 'トップカントリー';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country ～ $days 日';
  }

  @override
  String get year_in_review_no_photo_highlights => 'ハイライト写真はまだありません';

  @override
  String get year_in_review_no_achievements => '(まだ) ロック解除された実績はありません。';

  @override
  String get year_in_review_unlocked_achievements => 'ロック解除された実績';

  @override
  String get year_in_review_render_error => '画像を生成できません。';

  @override
  String get year_in_review_encode_error => 'イメージの作成中にエラーが発生しました。';

  @override
  String year_in_review_share_message(Object year) {
    return '私の$yearはWorldTraceと旅行中';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return '共有に失敗しました: $error';
  }

  @override
  String get trip_story_share_tooltip => 'ストーリーを共有する';

  @override
  String get trip_story_share_render_error => 'ストーリーを生成できません。';

  @override
  String get trip_story_share_image_error => 'イメージの作成中にエラーが発生しました。';

  @override
  String trip_story_share_message(Object country) {
    return 'WorldTrace との $country 旅行';
  }

  @override
  String trip_story_share_failed(Object error) {
    return '共有に失敗しました: $error';
  }

  @override
  String get trip_story_stat_steps => 'ステップ';

  @override
  String get trip_story_stat_photos => '写真';

  @override
  String get trip_story_stat_days => '日数';

  @override
  String get settings_profile_section_title => 'プロフィール';

  @override
  String get settings_plan_section_title => '__ブランド__プラン';

  @override
  String get settings_logout_button => 'ログアウト';

  @override
  String get plan_pro => '__ブランド__ __プロ__';

  @override
  String get settings_plan_description_pro => '無制限のタイムラインとプレミアムな旅行ツール。';

  @override
  String settings_plan_description_free(Object steps) {
    return '1 回の旅行につき最大 $steps 歩。 Pro にアップグレードすると、無制限のタイムラインと高度な統計のロックが解除されます。';
  }

  @override
  String profile_birthdate_label(Object date) {
    return '$date生まれ';
  }

  @override
  String get profile_birthdate_not_set => '未設定';

  @override
  String get profile_edit_button => 'プロフィールの編集';

  @override
  String get profile_edit_title => 'プロフィールの編集';

  @override
  String get profile_photo_change => '写真を変更する';

  @override
  String get profile_photo_remove => '写真を削除';

  @override
  String get profile_first_name_label => 'ファーストネーム';

  @override
  String get profile_last_name_label => '苗字';

  @override
  String get profile_birthdate_title => '生年月日';

  @override
  String get profile_birthdate_pick => '選ぶ';

  @override
  String get plan_support_thanks => 'WorldTrace をサポートしていただきありがとうございます!';

  @override
  String get profile_plan_section_title => 'プラン';

  @override
  String get profile_plan_current_pro => '現在のプラン: Pro - 旅行ごとに無制限の歩数。';

  @override
  String profile_plan_current_free(Object steps) {
    return '現在のプラン: 無料 - 1 回の旅行につき最大 $steps 歩。';
  }

  @override
  String get profile_sign_in_prompt => 'サインインして旅行プロフィールを表示します。';

  @override
  String get profile_no_data => '利用可能なデータはありません。';

  @override
  String get profile_travel_summary_title => '旅のまとめ';

  @override
  String get profile_stat_trips => '旅行';

  @override
  String get profile_stat_countries => '国';

  @override
  String get profile_stat_days => '日数';

  @override
  String profile_top_year_text(Object year, Object days) {
    return '最も激しかった年: $year ～ $days 日';
  }

  @override
  String get profile_top_year_empty => '旅行の記録を開始して、年間統計を取得しましょう。';

  @override
  String get profile_achievements_title => '業績';

  @override
  String get profile_see_all => '全て見る';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'ロック解除された実績: $unlocked/$total';
  }

  @override
  String get profile_goals_title => '目標';

  @override
  String get profile_goals_manage => '管理';

  @override
  String get profile_goals_empty => 'ここで年間の国別目標を設定して進捗状況を追跡します。';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return '年 $year ～ $current/$target の国';
  }

  @override
  String get profile_view_year_button => 'あなたの年を見てください';

  @override
  String get profile_share_button => '私のプロフィールを共有する';

  @override
  String get profile_share_no_trips =>
      'WorldTrace で旅行を記録し始めています。次の冒険に私について来てください!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return '私は$trips件の旅行を記録し、$countriesか国を訪問し、WorldTraceと旅行して$days日間を過ごしました。';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return '私が最も熱中した年は$year日で、$days日は出張でした。';
  }

  @override
  String get step_detail_section_story => '話';

  @override
  String get step_detail_story_empty => 'このステップにはストーリーは追加されませんでした。';

  @override
  String get step_detail_section_photos => '写真';

  @override
  String get step_detail_action_share => '共有';

  @override
  String get step_media_web_unsupported => 'Web では画像の共有はサポートされていません。';

  @override
  String get step_media_image_missing => 'このデバイスに画像が見つかりません。';

  @override
  String get step_media_share_text => 'WorldTrace との旅行のスナップ';

  @override
  String get step_media_share_failed => 'この画像は共有できません。';

  @override
  String step_media_title(Object current, Object total) {
    return '写真 $current/$total';
  }

  @override
  String get step_media_share_tooltip => '共有';

  @override
  String get upgrade_title => 'WorldTrace Pro のロックを解除する';

  @override
  String get upgrade_headline => '無制限にアップグレード';

  @override
  String get upgrade_description =>
      'Pro に移行して、無制限のタイムラインと旅行者に特化したツールを使用してストーリーを伝え続けます。';

  @override
  String get upgrade_benefit_unlimited_steps => '旅行ごとの歩数制限なし';

  @override
  String get upgrade_benefit_advanced_stats => '高度な統計と目標 (近日公開予定)';

  @override
  String get upgrade_benefit_heavy_users => '頻繁に旅行する人向けに作られています';

  @override
  String get upgrade_benefit_early_access => '実験的機能への早期アクセス';

  @override
  String get upgrade_success_message => 'WorldTrace Pro が有効になりました!';

  @override
  String get upgrade_maybe_later => 'たぶん後で';

  @override
  String get home_welcome_title => 'いらっしゃいませ';

  @override
  String get home_next_trip_prompt => '次の旅行を記録する準備はできましたか?';

  @override
  String get world_map_sign_in_prompt => 'サインインするか、ゲストとして続行して旅行マップを表示します。';

  @override
  String get world_map_empty_message => '最初の旅行を追加して地図を表示します。';

  @override
  String trip_story_open_failed(Object error) {
    return 'トリップ ストーリーを開けません: $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      '全画面での写真の表示は、モバイルとデスクトップでのみサポートされています。';

  @override
  String get onboarding_track_countries_title => '国を追跡する';

  @override
  String get onboarding_track_countries_subtitle => '旅行、思い出、統計情報を追加する';

  @override
  String get onboarding_set_goals_title => '目標を設定する';

  @override
  String get onboarding_set_goals_subtitle => '「2030年までに30か国」などの目標を立てる';

  @override
  String get onboarding_share_remember_title => '共有して覚えておいてください';

  @override
  String get onboarding_share_remember_subtitle => '旅行の共有可能なカードを作成する';

  @override
  String get achievement_first_trip_title => '最初の旅行が記録されました';

  @override
  String get achievement_first_trip_description => '初めての旅行を WorldTrace に記録します。';

  @override
  String get achievement_five_trips_title => 'ファイブトリップクラブ';

  @override
  String get achievement_five_trips_description => '日記に記録された旅行を 5 回達成します。';

  @override
  String get achievement_ten_trips_title => '10 回の旅行のマイルストーン';

  @override
  String get achievement_ten_trips_description => '少なくとも 10 件の冒険を計画し、記録します。';

  @override
  String get achievement_five_countries_title => 'グローブトロッター I';

  @override
  String get achievement_five_countries_description => '5 つの異なる国を訪問します。';

  @override
  String get achievement_ten_countries_title => 'グローブトロッター II';

  @override
  String get achievement_ten_countries_description => 'ユニークな 10 か国にアクセスしましょう。';

  @override
  String get achievement_thirty_days_title => '一年のうち30日';

  @override
  String get achievement_thirty_days_description => '同じ年に 30 日以上の旅行をする。';

  @override
  String get achievement_hundred_days_title => '旅の100日間';

  @override
  String get achievement_hundred_days_description => '累計旅行日数が 100 日になります。';

  @override
  String get auth_continue_email => 'email に進む';

  @override
  String get auth_continue_google => 'Google を続行する';

  @override
  String get auth_continue_facebook => 'Facebook を続ける';
}
