// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'Início / Painel';

  @override
  String get drawer_world_map => 'Mapa mundial';

  @override
  String get drawer_trips => 'Viagens';

  @override
  String get drawer_stats => 'Estatísticas';

  @override
  String get drawer_goals => 'Metas';

  @override
  String get drawer_profile => 'Perfil de viagem';

  @override
  String get drawer_account => 'Configurações de Conta';

  @override
  String get gallery_title => 'Galeria';

  @override
  String get gallery_nav_label => 'Galeria';

  @override
  String get gallery_profile_cta => 'Ver todas as fotos';

  @override
  String get gallery_empty_title => 'Ainda não há fotos';

  @override
  String get gallery_empty_message =>
      'Adicione mídia às suas viagens e elas aparecerão aqui.';

  @override
  String get trips_title => 'Viagens';

  @override
  String get trip_detail_timeline => 'Linha do tempo';

  @override
  String get trip_detail_empty_steps_message =>
      'Nenhuma etapa ainda. Comece sua história de viagem com a primeira nota.';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count passos';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '$count dia',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'Linha do tempo';

  @override
  String get trip_detail_section_photos_trip => 'Fotos';

  @override
  String get trip_edit_title_new => 'Nova viagem';

  @override
  String get trip_edit_title_edit => 'Editar viagem';

  @override
  String get trip_edit_button_save => 'Salvar';

  @override
  String get trip_edit_button_create => 'Criar';

  @override
  String get trip_edit_field_country_iso_label => 'Código ISO do país';

  @override
  String get trip_edit_field_country_iso_help => 'Ex.: JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'Nome da viagem';

  @override
  String get trip_edit_field_notes_label => 'Notas (opcional)';

  @override
  String get trip_edit_button_start_date => 'Data de início';

  @override
  String get trip_edit_button_end_date => 'Data de término';

  @override
  String get trip_editor_new_title => 'Nova viagem';

  @override
  String get trip_editor_edit_title => 'Editar viagem';

  @override
  String get trip_editor_field_country_label => 'ISO do país';

  @override
  String get trip_editor_field_country_helper => 'Ex.: JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'Nome da viagem';

  @override
  String get trip_editor_field_description_label => 'Notas (opcional)';

  @override
  String get trip_editor_field_start_date_label => 'Data de início';

  @override
  String get trip_editor_field_end_date_label => 'Data de término';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days dias';
  }

  @override
  String get trip_editor_error_country_required =>
      'Insira o código ISO do país.';

  @override
  String get trip_editor_error_name_required => 'Insira um nome de viagem.';

  @override
  String get trip_editor_error_dates_required =>
      'Selecione uma data de início e de término.';

  @override
  String get trip_editor_error_date_order =>
      'A data de término não pode ser anterior à data de início.';

  @override
  String get trip_editor_save_button => 'Salvar viagem';

  @override
  String get step_menu_edit => 'Editar etapa';

  @override
  String get step_menu_delete => 'Excluir etapa';

  @override
  String get step_delete_confirm_title => 'Excluir etapa?';

  @override
  String get step_delete_confirm_body =>
      'Esta nota será removida da linha do tempo da viagem.';

  @override
  String get step_editor_add_title => 'Nova etapa';

  @override
  String get step_editor_edit_title => 'Editar etapa';

  @override
  String get step_editor_field_description_label => 'Descrição da etapa';

  @override
  String get step_editor_field_place_label => 'Nome do local (opcional)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'Data e hora: $value';
  }

  @override
  String get step_editor_hint_diary => 'Escreva sobre esse momento...';

  @override
  String get step_editor_header_add_place_hint => 'Adicione onde você está';

  @override
  String get step_editor_place_hint => 'Cidade, lugar ou ponto de referência';

  @override
  String get step_editor_button_add_photos => 'Adicionar fotos';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count fotos selecionadas';
  }

  @override
  String get step_editor_error_pick_images => 'Erro ao escolher imagens.';

  @override
  String get step_editor_error_empty_description =>
      'Adicione uma breve descrição para esta etapa.';

  @override
  String get step_media_add_web_unsupported =>
      'A adição de fotos só é compatível com dispositivos móveis e computadores.';

  @override
  String get generic_error_saving_step =>
      'Não foi possível salvar a etapa. Por favor, tente novamente.';

  @override
  String get fab_add_step_tooltip => 'Adicionar etapa';

  @override
  String get fab_add_step_upgrade_tooltip => 'Atualizar para Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'Você atingiu o limite de $steps passos por viagem no plano Gratuito. Atualize para Pro para continuar registrando no diário.';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'Você atingiu o limite de etapas deste plano. Atualize para Pro para continuar registrando no diário.';

  @override
  String get btn_add_step => 'Adicionar etapa';

  @override
  String get btn_save => 'Salvar';

  @override
  String get btn_cancel => 'Cancelar';

  @override
  String get btn_delete => 'Excluir';

  @override
  String get on_this_day_title => 'Neste dia';

  @override
  String get on_this_day_empty => 'Nenhuma viagem registrada neste dia ainda.';

  @override
  String get stats_title => 'Painel global';

  @override
  String get stats_sign_in_prompt => 'Faça login para ver as estatísticas.';

  @override
  String get stats_highlights_title => 'Destaques';

  @override
  String get stats_metric_trips_logged => 'Viagens registradas';

  @override
  String get stats_metric_travel_heavy_year => 'Ano de muitas viagens';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days dias';
  }

  @override
  String get stats_value_not_available => 'Não disponível';

  @override
  String get stats_empty_message =>
      'Adicione sua primeira viagem para desbloquear estatísticas.';

  @override
  String get stats_highlight_average_days => 'Média de dias por viagem';

  @override
  String get stats_highlight_longest_trip => 'Viagem mais longa';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days dias - $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'Viagem mais recente';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'Metas de viagem';

  @override
  String get goals_new_goal_button => 'Novo objetivo';

  @override
  String get goals_dialog_title => 'Criar meta';

  @override
  String get goals_field_title_label => 'Título';

  @override
  String get goals_field_year_label => 'Ano';

  @override
  String get goals_field_target_label => 'Países-alvo';

  @override
  String get goals_delete_tooltip => 'Excluir meta';

  @override
  String goals_card_year_label(Object year) {
    return 'Ano $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target países visitados';
  }

  @override
  String get goals_empty_title => 'Ainda não há metas';

  @override
  String get goals_empty_description =>
      'Defina a meta anual do seu país e acompanharemos seu progresso automaticamente.';

  @override
  String get goals_empty_cta => 'Crie uma meta';

  @override
  String get account_title => 'Conta';

  @override
  String get plan_free => 'WorldTrace Grátis';

  @override
  String get plan_upgrade => 'Atualizar para Pro';

  @override
  String get year_in_review_title => 'Revisão do ano';

  @override
  String get trip_story_title => 'História de viagem';

  @override
  String get home_sign_in_prompt =>
      'Faça login ou continue como convidado para começar a monitorar suas viagens.';

  @override
  String generic_error(Object error) {
    return 'Erro: $error';
  }

  @override
  String get no_trips_yet => 'Nenhuma viagem ainda.';

  @override
  String get stat_countries_visited => 'Países visitados';

  @override
  String get stat_days_abroad => 'Dias no exterior';

  @override
  String get stat_last_trip => 'Última viagem';

  @override
  String on_this_day_label(Object date) {
    return 'Neste dia: $date';
  }

  @override
  String get btn_open_trip => 'Viagem aberta';

  @override
  String country_sheet_days(Object count) {
    return 'Dias: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'Viagens: $count';
  }

  @override
  String get country_sheet_view_trips => 'Ver viagens neste país';

  @override
  String get country_sheet_add_trip => 'Adicionar viagem';

  @override
  String get country_sheet_no_photos_title => 'Ainda não há fotos aqui';

  @override
  String get country_sheet_no_photos_message =>
      'Adicione mídia às suas viagens e elas aparecerão aqui.';

  @override
  String get country_overview_subtitle => 'Visão geral do país';

  @override
  String get country_overview_label_trips => 'Viagens';

  @override
  String get country_overview_label_days => 'Dias';

  @override
  String get country_overview_label_steps => 'Passos';

  @override
  String get country_overview_label_photos => 'Fotos';

  @override
  String get country_overview_label_last_visited => 'Última visita';

  @override
  String get country_overview_last_visited_never => 'Nunca visitei';

  @override
  String get country_overview_empty_trips_message =>
      'Adicione sua primeira viagem neste país para desbloquear insights.';

  @override
  String get country_overview_action_view_trips => 'Ver viagens';

  @override
  String get country_overview_action_add_trip => 'Adicionar uma viagem';

  @override
  String get country_overview_action_close => 'Fechar';

  @override
  String get guest_user => 'Usuário convidado';

  @override
  String get plan_active => 'Plano ativo';

  @override
  String get auth_welcome => 'Bem-vindo ao WorldTrace';

  @override
  String get auth_login => 'Conecte-se';

  @override
  String get auth_signup => 'Inscrever-se';

  @override
  String get auth_continue_guest => 'Continuar como convidado';

  @override
  String get trip_deleted => 'Viagem excluída.';

  @override
  String get trip_menu_delete => 'Excluir viagem';

  @override
  String get trip_delete_confirm_title => 'Excluir esta viagem?';

  @override
  String get trip_delete_confirm_body =>
      'A viagem e todas as suas etapas serão removidas permanentemente.';

  @override
  String get trip_delete_missing_id_error =>
      'Não é possível excluir uma viagem sem ID.';

  @override
  String get menu_open_details => 'Abrir detalhes';

  @override
  String get menu_delete_trip => 'Excluir viagem';

  @override
  String get tooltip_add_trip => 'Adicionar viagem';

  @override
  String get drawer_achievements => 'Conquistas';

  @override
  String get achievements_sign_in_prompt =>
      'Faça login para ver suas conquistas.';

  @override
  String get year_in_review_share_tooltip => 'Compartilhe a história do ano';

  @override
  String get year_in_review_sign_in_prompt =>
      'Faça login para ver sua retrospectiva do ano.';

  @override
  String get year_in_review_no_trips =>
      'Adicione algumas viagens para desbloquear sua avaliação.';

  @override
  String get year_in_review_no_data_for_year =>
      'Revisão não disponível para este ano.';

  @override
  String year_in_review_map_title(Object year) {
    return 'Mapa de viagem $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'Seu $year em viagens';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days dias - $trips viagens - $countries países';
  }

  @override
  String get year_in_review_longest_trip => 'Viagem mais longa';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days dias';
  }

  @override
  String get year_in_review_top_country => 'País principal';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days dias';
  }

  @override
  String get year_in_review_no_photo_highlights =>
      'Ainda não há destaques de fotos';

  @override
  String get year_in_review_no_achievements =>
      'Nenhuma conquista desbloqueada (ainda).';

  @override
  String get year_in_review_unlocked_achievements => 'Conquistas desbloqueadas';

  @override
  String get year_in_review_render_error => 'Não foi possível gerar a imagem.';

  @override
  String get year_in_review_encode_error => 'Erro ao criar a imagem.';

  @override
  String year_in_review_share_message(Object year) {
    return 'Meu $year está viajando com WorldTrace';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'Falha no compartilhamento: $error';
  }

  @override
  String get trip_story_share_tooltip => 'Compartilhar história';

  @override
  String get trip_story_share_render_error =>
      'Não foi possível gerar a história.';

  @override
  String get trip_story_share_image_error => 'Erro ao criar a imagem.';

  @override
  String trip_story_share_message(Object country) {
    return 'Minha viagem em $country com WorldTrace';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'Falha no compartilhamento: $error';
  }

  @override
  String get trip_story_stat_steps => 'Passos';

  @override
  String get trip_story_stat_photos => 'Fotos';

  @override
  String get trip_story_stat_days => 'Dias';

  @override
  String get settings_profile_section_title => 'Perfil';

  @override
  String get settings_plan_section_title => 'Plano WorldTrace';

  @override
  String get settings_logout_button => 'Sair';

  @override
  String get plan_pro => '__MARCA__ Pro';

  @override
  String get settings_plan_description_pro =>
      'Prazos ilimitados e ferramentas de viagem premium.';

  @override
  String settings_plan_description_free(Object steps) {
    return 'Até $steps passos por viagem. Atualize para Pro para desbloquear cronogramas ilimitados e estatísticas avançadas.';
  }

  @override
  String profile_birthdate_label(Object date) {
    return 'Nascido em $date';
  }

  @override
  String get profile_birthdate_not_set => 'Não definido';

  @override
  String get profile_edit_button => 'Editar perfil';

  @override
  String get profile_edit_title => 'Editar perfil';

  @override
  String get profile_photo_change => 'Alterar foto';

  @override
  String get profile_photo_remove => 'Remover foto';

  @override
  String get profile_first_name_label => 'Primeiro nome';

  @override
  String get profile_last_name_label => 'Sobrenome';

  @override
  String get profile_birthdate_title => 'Data de nascimento';

  @override
  String get profile_birthdate_pick => 'Escolher';

  @override
  String get plan_support_thanks => 'Obrigado por apoiar WorldTrace!';

  @override
  String get profile_plan_section_title => 'Plano';

  @override
  String get profile_plan_current_pro =>
      'Plano atual: Pro - passos ilimitados por viagem.';

  @override
  String profile_plan_current_free(Object steps) {
    return 'Plano atual: Gratuito - até $steps passos por viagem.';
  }

  @override
  String get profile_sign_in_prompt =>
      'Faça login para visualizar seu perfil de viagem.';

  @override
  String get profile_no_data => 'Não há dados disponíveis.';

  @override
  String get profile_travel_summary_title => 'Resumo da viagem';

  @override
  String get profile_stat_trips => 'Viagens';

  @override
  String get profile_stat_countries => 'Países';

  @override
  String get profile_stat_days => 'Dias';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'Ano mais intenso: $year - $days dias';
  }

  @override
  String get profile_top_year_empty =>
      'Comece a registrar suas viagens para desbloquear estatísticas anuais.';

  @override
  String get profile_achievements_title => 'Conquistas';

  @override
  String get profile_see_all => 'Ver tudo';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'Conquistas desbloqueadas: $unlocked de $total';
  }

  @override
  String get profile_goals_title => 'Metas';

  @override
  String get profile_goals_manage => 'Gerenciar';

  @override
  String get profile_goals_empty =>
      'Defina uma meta anual por país para acompanhar seu progresso aqui.';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'Ano $year - países $current/$target';
  }

  @override
  String get profile_view_year_button => 'Veja seu ano';

  @override
  String get profile_share_button => 'Compartilhar meu perfil';

  @override
  String get profile_share_no_trips =>
      'Estou começando a monitorar minhas viagens com WorldTrace. Siga-me na minha próxima aventura!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'Registrei $trips viagens, visitei $countries países e passei $days dias viajando com WorldTrace.';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'Meu ano mais intenso foi $year com $days dias de estrada.';
  }

  @override
  String get step_detail_section_story => 'História';

  @override
  String get step_detail_story_empty =>
      'Nenhuma história foi adicionada para esta etapa.';

  @override
  String get step_detail_section_photos => 'Fotos';

  @override
  String get step_detail_action_share => 'Compartilhar';

  @override
  String get step_media_web_unsupported =>
      'O compartilhamento de imagens não é compatível com a web.';

  @override
  String get step_media_image_missing =>
      'Imagem não encontrada neste dispositivo.';

  @override
  String get step_media_share_text =>
      'Um instantâneo da minha viagem com WorldTrace';

  @override
  String get step_media_share_failed =>
      'Não foi possível compartilhar esta imagem.';

  @override
  String step_media_title(Object current, Object total) {
    return 'Foto $current/$total';
  }

  @override
  String get step_media_share_tooltip => 'Compartilhar';

  @override
  String get upgrade_title => 'Desbloquear WorldTrace Pro';

  @override
  String get upgrade_headline => 'Atualize sem limites';

  @override
  String get upgrade_description =>
      'Acesse Pro para continuar contando suas histórias com cronogramas ilimitados e ferramentas voltadas para o viajante.';

  @override
  String get upgrade_benefit_unlimited_steps =>
      'Sem limites de passos por viagem';

  @override
  String get upgrade_benefit_advanced_stats =>
      'Estatísticas e metas avançadas (em breve)';

  @override
  String get upgrade_benefit_heavy_users => 'Construído para viajantes pesados';

  @override
  String get upgrade_benefit_early_access =>
      'Acesso antecipado a recursos experimentais';

  @override
  String get upgrade_success_message => 'WorldTrace Pro ativado!';

  @override
  String get upgrade_maybe_later => 'Talvez mais tarde';

  @override
  String get home_welcome_title => 'Bem-vindo';

  @override
  String get home_next_trip_prompt =>
      'Pronto para registrar sua próxima viagem?';

  @override
  String get world_map_sign_in_prompt =>
      'Faça login ou continue como convidado para visualizar seu mapa de viagem.';

  @override
  String get world_map_empty_message =>
      'Adicione sua primeira viagem para ver o mapa.';

  @override
  String trip_story_open_failed(Object error) {
    return 'Não foi possível abrir a história da viagem: $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'A visualização de fotos em tela cheia só é compatível com dispositivos móveis e computadores.';

  @override
  String get onboarding_track_countries_title => 'Rastrear países';

  @override
  String get onboarding_track_countries_subtitle =>
      'Adicione viagens, memórias e estatísticas';

  @override
  String get onboarding_set_goals_title => 'Estabeleça metas';

  @override
  String get onboarding_set_goals_subtitle =>
      'Crie metas como “30 países até 2030”';

  @override
  String get onboarding_share_remember_title => 'Compartilhe e lembre-se';

  @override
  String get onboarding_share_remember_subtitle =>
      'Crie cartões compartilháveis ​​de suas viagens';

  @override
  String get achievement_first_trip_title => 'Primeira viagem registrada';

  @override
  String get achievement_first_trip_description =>
      'Registre sua primeira viagem em WorldTrace.';

  @override
  String get achievement_five_trips_title => 'Clube das Cinco Viagens';

  @override
  String get achievement_five_trips_description =>
      'Alcance cinco viagens registradas em seu diário.';

  @override
  String get achievement_ten_trips_title => 'Marco de dez viagens';

  @override
  String get achievement_ten_trips_description =>
      'Planeje e registre pelo menos dez aventuras.';

  @override
  String get achievement_five_countries_title => 'Globetrotter I';

  @override
  String get achievement_five_countries_description =>
      'Visite cinco países diferentes.';

  @override
  String get achievement_ten_countries_title => 'Globetrotter II';

  @override
  String get achievement_ten_countries_description =>
      'Alcance dez países únicos.';

  @override
  String get achievement_thirty_days_title => '30 dias em um ano';

  @override
  String get achievement_thirty_days_description =>
      'Passe mais de 30 dias viajando no mesmo ano.';

  @override
  String get achievement_hundred_days_title => '100 dias na estrada';

  @override
  String get achievement_hundred_days_description =>
      'Acumule cem dias de viagem no total.';

  @override
  String get auth_continue_email => 'Continuar com email';

  @override
  String get auth_continue_google => 'Continuar com Google';

  @override
  String get auth_continue_facebook => 'Continuar com Facebook';
}
