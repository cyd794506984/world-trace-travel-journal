// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_title => 'WorldTrace';

  @override
  String get home_title => 'WorldTrace';

  @override
  String get drawer_home => 'Inicio / Panel de control';

  @override
  String get drawer_world_map => 'mapa mundial';

  @override
  String get drawer_trips => 'Viajes';

  @override
  String get drawer_stats => 'Estadísticas';

  @override
  String get drawer_goals => 'Objetivos';

  @override
  String get drawer_profile => 'Perfil de viaje';

  @override
  String get drawer_account => 'Configuraciones de la cuenta';

  @override
  String get gallery_title => 'Galería';

  @override
  String get gallery_nav_label => 'Galería';

  @override
  String get gallery_profile_cta => 'Ver todas las fotos';

  @override
  String get gallery_empty_title => 'Aún no hay fotos';

  @override
  String get gallery_empty_message =>
      'Añade medios a tus viajes y aparecerán aquí.';

  @override
  String get trips_title => 'Viajes';

  @override
  String get trip_detail_timeline => 'Línea de tiempo';

  @override
  String get trip_detail_empty_steps_message =>
      'Aún no hay pasos. Comienza tu historia de viaje con la primera nota.';

  @override
  String trip_detail_day_header_steps(Object count) {
    return '$count pasos';
  }

  @override
  String trip_detail_days_chip(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '$count día',
    );
    return '$_temp0';
  }

  @override
  String get trip_detail_section_timeline => 'Línea de tiempo';

  @override
  String get trip_detail_section_photos_trip => 'Fotos';

  @override
  String get trip_edit_title_new => 'Nuevo viaje';

  @override
  String get trip_edit_title_edit => 'Editar viaje';

  @override
  String get trip_edit_button_save => 'Ahorrar';

  @override
  String get trip_edit_button_create => 'Crear';

  @override
  String get trip_edit_field_country_iso_label => 'Código ISO del país';

  @override
  String get trip_edit_field_country_iso_help => 'Ej. JP, US, IT';

  @override
  String get trip_edit_field_name_label => 'Nombre del viaje';

  @override
  String get trip_edit_field_notes_label => 'Notas (opcional)';

  @override
  String get trip_edit_button_start_date => 'Fecha de inicio';

  @override
  String get trip_edit_button_end_date => 'Fecha de finalización';

  @override
  String get trip_editor_new_title => 'Nuevo viaje';

  @override
  String get trip_editor_edit_title => 'Editar viaje';

  @override
  String get trip_editor_field_country_label => 'País ISO';

  @override
  String get trip_editor_field_country_helper => 'Ej. JP, US, IT';

  @override
  String get trip_editor_field_name_label => 'Nombre del viaje';

  @override
  String get trip_editor_field_description_label => 'Notas (opcional)';

  @override
  String get trip_editor_field_start_date_label => 'Fecha de inicio';

  @override
  String get trip_editor_field_end_date_label => 'Fecha de finalización';

  @override
  String trip_editor_date_range_days(Object days) {
    return '$days días';
  }

  @override
  String get trip_editor_error_country_required =>
      'Introduzca el código ISO de un país.';

  @override
  String get trip_editor_error_name_required =>
      'Por favor ingresa un nombre de viaje.';

  @override
  String get trip_editor_error_dates_required =>
      'Seleccione una fecha de inicio y de finalización.';

  @override
  String get trip_editor_error_date_order =>
      'La fecha de finalización no puede ser anterior a la fecha de inicio.';

  @override
  String get trip_editor_save_button => 'Guardar viaje';

  @override
  String get step_menu_edit => 'Editar paso';

  @override
  String get step_menu_delete => 'Eliminar paso';

  @override
  String get step_delete_confirm_title => '¿Eliminar paso?';

  @override
  String get step_delete_confirm_body =>
      'Esta nota se eliminará del cronograma del viaje.';

  @override
  String get step_editor_add_title => 'Nuevo paso';

  @override
  String get step_editor_edit_title => 'Editar paso';

  @override
  String get step_editor_field_description_label => 'Descripción del paso';

  @override
  String get step_editor_field_place_label => 'Nombre del lugar (opcional)';

  @override
  String step_editor_field_date_time_label(Object value) {
    return 'Fecha y hora: $value';
  }

  @override
  String get step_editor_hint_diary => 'Escribe sobre este momento...';

  @override
  String get step_editor_header_add_place_hint => 'Añade dónde estás';

  @override
  String get step_editor_place_hint => 'Ciudad, lugar o punto de referencia';

  @override
  String get step_editor_button_add_photos => 'Agregar fotos';

  @override
  String step_editor_photos_selected(Object count) {
    return '$count fotos seleccionadas';
  }

  @override
  String get step_editor_error_pick_images => 'Error al seleccionar imágenes.';

  @override
  String get step_editor_error_empty_description =>
      'Agregue una breve descripción para este paso.';

  @override
  String get step_media_add_web_unsupported =>
      'Agregar fotos solo se admite en dispositivos móviles y de escritorio.';

  @override
  String get generic_error_saving_step =>
      'No se puede guardar el paso. Por favor inténtalo de nuevo.';

  @override
  String get fab_add_step_tooltip => 'Agregar paso';

  @override
  String get fab_add_step_upgrade_tooltip => 'Actualizar a Pro';

  @override
  String plan_limit_steps_reached_message(Object steps) {
    return 'Has alcanzado el límite de $steps pasos por viaje en el plan gratuito. Actualice a Pro para seguir escribiendo en el diario.';
  }

  @override
  String get plan_limit_steps_reached_generic =>
      'Has alcanzado el límite de pasos para este plan. Actualice a Pro para seguir escribiendo en el diario.';

  @override
  String get btn_add_step => 'Agregar paso';

  @override
  String get btn_save => 'Ahorrar';

  @override
  String get btn_cancel => 'Cancelar';

  @override
  String get btn_delete => 'Borrar';

  @override
  String get on_this_day_title => 'en este dia';

  @override
  String get on_this_day_empty =>
      'Ningún viaje registrado en este día todavía.';

  @override
  String get stats_title => 'Panel global';

  @override
  String get stats_sign_in_prompt =>
      'Por favor inicia sesión para ver estadísticas.';

  @override
  String get stats_highlights_title => 'Reflejos';

  @override
  String get stats_metric_trips_logged => 'Viajes registrados';

  @override
  String get stats_metric_travel_heavy_year => 'Año de muchos viajes';

  @override
  String stats_metric_travel_heavy_year_value(Object year, Object days) {
    return '$year - $days días';
  }

  @override
  String get stats_value_not_available => 'No disponible';

  @override
  String get stats_empty_message =>
      'Agrega tu primer viaje para desbloquear estadísticas.';

  @override
  String get stats_highlight_average_days => 'Promedio de días por viaje';

  @override
  String get stats_highlight_longest_trip => 'viaje más largo';

  @override
  String stats_highlight_longest_trip_value(Object days, Object destination) {
    return '$days días - $destination';
  }

  @override
  String get stats_highlight_recent_trip => 'viaje más reciente';

  @override
  String stats_highlight_recent_trip_value(Object destination, Object date) {
    return '$destination - $date';
  }

  @override
  String get goals_title => 'Objetivos de viaje';

  @override
  String get goals_new_goal_button => 'Nuevo objetivo';

  @override
  String get goals_dialog_title => 'Crear objetivo';

  @override
  String get goals_field_title_label => 'Título';

  @override
  String get goals_field_year_label => 'Año';

  @override
  String get goals_field_target_label => 'Países objetivo';

  @override
  String get goals_delete_tooltip => 'Eliminar objetivo';

  @override
  String goals_card_year_label(Object year) {
    return 'Año $year';
  }

  @override
  String goals_card_progress_label(Object current, Object target) {
    return '$current / $target países visitados';
  }

  @override
  String get goals_empty_title => 'Aún no hay goles';

  @override
  String get goals_empty_description =>
      'Establezca su objetivo nacional anual y realizaremos un seguimiento de su progreso automáticamente.';

  @override
  String get goals_empty_cta => 'Crea una meta';

  @override
  String get account_title => 'Cuenta';

  @override
  String get plan_free => '__MARCA__ Gratis';

  @override
  String get plan_upgrade => 'Actualizar a Pro';

  @override
  String get year_in_review_title => 'Resumen del año';

  @override
  String get trip_story_title => 'Historia del viaje';

  @override
  String get home_sign_in_prompt =>
      'Inicie sesión o continúe como invitado para comenzar a realizar un seguimiento de sus viajes.';

  @override
  String generic_error(Object error) {
    return 'Error: $error';
  }

  @override
  String get no_trips_yet => 'Aún no hay viajes.';

  @override
  String get stat_countries_visited => 'Países visitados';

  @override
  String get stat_days_abroad => 'dias en el extranjero';

  @override
  String get stat_last_trip => 'último viaje';

  @override
  String on_this_day_label(Object date) {
    return 'En este día: $date';
  }

  @override
  String get btn_open_trip => 'viaje abierto';

  @override
  String country_sheet_days(Object count) {
    return 'Días: $count';
  }

  @override
  String country_sheet_trips(Object count) {
    return 'Viajes: $count';
  }

  @override
  String get country_sheet_view_trips => 'Ver viajes en este país';

  @override
  String get country_sheet_add_trip => 'Añadir viaje';

  @override
  String get country_sheet_no_photos_title => 'Aún no hay fotos aquí';

  @override
  String get country_sheet_no_photos_message =>
      'Añade medios a tus viajes y aparecerán aquí.';

  @override
  String get country_overview_subtitle => 'Resumen del país';

  @override
  String get country_overview_label_trips => 'Viajes';

  @override
  String get country_overview_label_days => 'Días';

  @override
  String get country_overview_label_steps => 'Pasos';

  @override
  String get country_overview_label_photos => 'Fotos';

  @override
  String get country_overview_label_last_visited => 'Última visita';

  @override
  String get country_overview_last_visited_never => 'Nunca visitado';

  @override
  String get country_overview_empty_trips_message =>
      'Agregue su primer viaje a este país para desbloquear información.';

  @override
  String get country_overview_action_view_trips => 'Ver viajes';

  @override
  String get country_overview_action_add_trip => 'Añadir un viaje';

  @override
  String get country_overview_action_close => 'Cerca';

  @override
  String get guest_user => 'Usuario invitado';

  @override
  String get plan_active => 'plan activo';

  @override
  String get auth_welcome => 'Bienvenido a __MARCA__';

  @override
  String get auth_login => 'Acceso';

  @override
  String get auth_signup => 'Inscribirse';

  @override
  String get auth_continue_guest => 'Continuar como invitado';

  @override
  String get trip_deleted => 'Viaje eliminado.';

  @override
  String get trip_menu_delete => 'Eliminar viaje';

  @override
  String get trip_delete_confirm_title => '¿Eliminar este viaje?';

  @override
  String get trip_delete_confirm_body =>
      'El viaje y todos sus pasos serán eliminados permanentemente.';

  @override
  String get trip_delete_missing_id_error =>
      'No se puede eliminar un viaje sin una identificación.';

  @override
  String get menu_open_details => 'Abrir detalles';

  @override
  String get menu_delete_trip => 'Eliminar viaje';

  @override
  String get tooltip_add_trip => 'Añadir viaje';

  @override
  String get drawer_achievements => 'Logros';

  @override
  String get achievements_sign_in_prompt =>
      'Inicia sesión para ver tus logros.';

  @override
  String get year_in_review_share_tooltip => 'Compartir historia del año';

  @override
  String get year_in_review_sign_in_prompt =>
      'Inicie sesión para ver el resumen del año.';

  @override
  String get year_in_review_no_trips =>
      'Agregue algunos viajes para desbloquear su reseña.';

  @override
  String get year_in_review_no_data_for_year =>
      'Revisión no disponible para este año.';

  @override
  String year_in_review_map_title(Object year) {
    return 'Mapa de viaje $year';
  }

  @override
  String year_in_review_story_title(Object year) {
    return 'Tu $year en viaje';
  }

  @override
  String year_in_review_story_summary(
    Object days,
    Object trips,
    Object countries,
  ) {
    return '$days días - $trips viajes - $countries países';
  }

  @override
  String get year_in_review_longest_trip => 'viaje más largo';

  @override
  String year_in_review_longest_trip_value(Object title, Object days) {
    return '$title - $days días';
  }

  @override
  String get year_in_review_top_country => 'País superior';

  @override
  String year_in_review_top_country_value(Object country, Object days) {
    return '$country - $days días';
  }

  @override
  String get year_in_review_no_photo_highlights =>
      'Aún no hay fotos destacadas';

  @override
  String get year_in_review_no_achievements =>
      'No hay logros desbloqueados (aún).';

  @override
  String get year_in_review_unlocked_achievements => 'Logros desbloqueados';

  @override
  String get year_in_review_render_error => 'No se puede generar la imagen.';

  @override
  String get year_in_review_encode_error => 'Error al crear la imagen.';

  @override
  String year_in_review_share_message(Object year) {
    return 'Mi $year en viaje con WorldTrace';
  }

  @override
  String year_in_review_share_failed(Object error) {
    return 'Error al compartir: $error';
  }

  @override
  String get trip_story_share_tooltip => 'Compartir historia';

  @override
  String get trip_story_share_render_error =>
      'No se puede generar la historia.';

  @override
  String get trip_story_share_image_error => 'Error al crear la imagen.';

  @override
  String trip_story_share_message(Object country) {
    return 'Mi viaje en $country con WorldTrace';
  }

  @override
  String trip_story_share_failed(Object error) {
    return 'Error al compartir: $error';
  }

  @override
  String get trip_story_stat_steps => 'Pasos';

  @override
  String get trip_story_stat_photos => 'Fotos';

  @override
  String get trip_story_stat_days => 'Días';

  @override
  String get settings_profile_section_title => 'Perfil';

  @override
  String get settings_plan_section_title => 'Plan __MARCA__';

  @override
  String get settings_logout_button => 'Finalizar la sesión';

  @override
  String get plan_pro => '__MARCA__ Pro';

  @override
  String get settings_plan_description_pro =>
      'Cronogramas ilimitados y herramientas de viaje premium.';

  @override
  String settings_plan_description_free(Object steps) {
    return 'Hasta $steps pasos por viaje. Actualice a Pro para desbloquear líneas de tiempo ilimitadas y estadísticas avanzadas.';
  }

  @override
  String profile_birthdate_label(Object date) {
    return 'Nacido el $date';
  }

  @override
  String get profile_birthdate_not_set => 'No establecido';

  @override
  String get profile_edit_button => 'Editar perfil';

  @override
  String get profile_edit_title => 'Editar perfil';

  @override
  String get profile_photo_change => 'Cambiar foto';

  @override
  String get profile_photo_remove => 'Quitar foto';

  @override
  String get profile_first_name_label => 'Nombre de pila';

  @override
  String get profile_last_name_label => 'Apellido';

  @override
  String get profile_birthdate_title => 'Fecha de nacimiento';

  @override
  String get profile_birthdate_pick => 'Elegir';

  @override
  String get plan_support_thanks => '¡Gracias por apoyar a WorldTrace!';

  @override
  String get profile_plan_section_title => 'Plan';

  @override
  String get profile_plan_current_pro =>
      'Plan actual: Pro - pasos ilimitados por viaje.';

  @override
  String profile_plan_current_free(Object steps) {
    return 'Plan actual: Gratis: hasta $steps pasos por viaje.';
  }

  @override
  String get profile_sign_in_prompt =>
      'Inicia sesión para ver tu perfil de viaje.';

  @override
  String get profile_no_data => 'No hay datos disponibles.';

  @override
  String get profile_travel_summary_title => 'Resumen de viaje';

  @override
  String get profile_stat_trips => 'Viajes';

  @override
  String get profile_stat_countries => 'Países';

  @override
  String get profile_stat_days => 'Días';

  @override
  String profile_top_year_text(Object year, Object days) {
    return 'Año más intenso: $year - $days días';
  }

  @override
  String get profile_top_year_empty =>
      'Comience a registrar sus viajes para desbloquear estadísticas anuales.';

  @override
  String get profile_achievements_title => 'Logros';

  @override
  String get profile_see_all => 'Ver todo';

  @override
  String profile_achievements_progress(Object unlocked, Object total) {
    return 'Logros desbloqueados: $unlocked de $total';
  }

  @override
  String get profile_goals_title => 'Objetivos';

  @override
  String get profile_goals_manage => 'Administrar';

  @override
  String get profile_goals_empty =>
      'Establezca aquí un objetivo nacional anual para realizar un seguimiento de su progreso.';

  @override
  String profile_goal_progress_label(
    Object year,
    Object current,
    Object target,
  ) {
    return 'Año $year - $current/$target países';
  }

  @override
  String get profile_view_year_button => 'ver tu año';

  @override
  String get profile_share_button => 'compartir mi perfil';

  @override
  String get profile_share_no_trips =>
      'Estoy empezando a realizar un seguimiento de mis viajes con WorldTrace. ¡Sígueme en mi próxima aventura!';

  @override
  String profile_share_stats(Object trips, Object countries, Object days) {
    return 'Registré $trips viajes, visité $countries países y pasé $days días viajando con WorldTrace.';
  }

  @override
  String profile_share_top_year(Object year, Object days) {
    return 'Mi año más intenso fue $year con $days días de viaje.';
  }

  @override
  String get step_detail_section_story => 'Historia';

  @override
  String get step_detail_story_empty =>
      'No se agregó ninguna historia para este paso.';

  @override
  String get step_detail_section_photos => 'Fotos';

  @override
  String get step_detail_action_share => 'Compartir';

  @override
  String get step_media_web_unsupported =>
      'No se permite compartir imágenes en la web.';

  @override
  String get step_media_image_missing =>
      'Imagen no encontrada en este dispositivo.';

  @override
  String get step_media_share_text =>
      'Una instantánea de mi viaje con WorldTrace';

  @override
  String get step_media_share_failed => 'No se puede compartir esta imagen.';

  @override
  String step_media_title(Object current, Object total) {
    return 'Foto $current/$total';
  }

  @override
  String get step_media_share_tooltip => 'Compartir';

  @override
  String get upgrade_title => 'Desbloquear WorldTrace Pro';

  @override
  String get upgrade_headline => 'Actualiza sin límites';

  @override
  String get upgrade_description =>
      'Vaya Pro para seguir contando sus historias con líneas de tiempo ilimitadas y herramientas centradas en los viajeros.';

  @override
  String get upgrade_benefit_unlimited_steps =>
      'Sin límites de pasos por viaje';

  @override
  String get upgrade_benefit_advanced_stats =>
      'Estadísticas y objetivos avanzados (próximamente)';

  @override
  String get upgrade_benefit_heavy_users => 'Diseñado para viajeros pesados';

  @override
  String get upgrade_benefit_early_access =>
      'Acceso temprano a funciones experimentales';

  @override
  String get upgrade_success_message => 'WorldTrace Pro activado!';

  @override
  String get upgrade_maybe_later => 'tal vez más tarde';

  @override
  String get home_welcome_title => 'Bienvenido';

  @override
  String get home_next_trip_prompt => '¿Listo para registrar tu próximo viaje?';

  @override
  String get world_map_sign_in_prompt =>
      'Inicia sesión o continúa como invitado para ver tu mapa de viaje.';

  @override
  String get world_map_empty_message =>
      'Añade tu primer viaje para ver el mapa.';

  @override
  String trip_story_open_failed(Object error) {
    return 'No se puede abrir la historia del viaje: $error';
  }

  @override
  String get photo_viewer_web_unsupported =>
      'La visualización de fotografías en pantalla completa solo se admite en dispositivos móviles y de escritorio.';

  @override
  String get onboarding_track_countries_title => 'Seguimiento de países';

  @override
  String get onboarding_track_countries_subtitle =>
      'Añade viajes, recuerdos y estadísticas';

  @override
  String get onboarding_set_goals_title => 'Establecer metas';

  @override
  String get onboarding_set_goals_subtitle =>
      'Crear objetivos como \"30 países para 2030\"';

  @override
  String get onboarding_share_remember_title => 'Comparte y recuerda';

  @override
  String get onboarding_share_remember_subtitle =>
      'Crea tarjetas compartibles de tus viajes.';

  @override
  String get achievement_first_trip_title => 'Primer viaje registrado';

  @override
  String get achievement_first_trip_description =>
      'Registre su primer viaje en WorldTrace.';

  @override
  String get achievement_five_trips_title => 'Club de los cinco viajes';

  @override
  String get achievement_five_trips_description =>
      'Llega a cinco viajes registrados en tu diario.';

  @override
  String get achievement_ten_trips_title => 'Hito de los diez viajes';

  @override
  String get achievement_ten_trips_description =>
      'Planifica y registra al menos diez aventuras.';

  @override
  String get achievement_five_countries_title => 'Trotamundos I';

  @override
  String get achievement_five_countries_description =>
      'Visita cinco países diferentes.';

  @override
  String get achievement_ten_countries_title => 'Trotamundos II';

  @override
  String get achievement_ten_countries_description =>
      'Llega a diez países únicos.';

  @override
  String get achievement_thirty_days_title => '30 días en un año';

  @override
  String get achievement_thirty_days_description =>
      'Pase más de 30 días viajando en el mismo año.';

  @override
  String get achievement_hundred_days_title => '100 días en el camino';

  @override
  String get achievement_hundred_days_description =>
      'Acumular cien días de viaje en total.';

  @override
  String get auth_continue_email => 'Continuar con email';

  @override
  String get auth_continue_google => 'Continuar con Google';

  @override
  String get auth_continue_facebook => 'Continuar con Facebook';
}
