![WorldTrace cover](https://i.ibb.co/C51XnqSM/World-Trace.png)

# WorldTrace

WorldTrace is a cross-platform Flutter travel journal designed to feel like a personal travel atlas. It combines an interactive world map, diary-style trip timelines, stats and goals, achievements, and shareable recaps. The app is offline-first: data is stored locally on the device (SQLite + shared_preferences), and guest mode is the default. The codebase is structured to allow a future remote database/backend and real auth providers, but those are not implemented yet.

This README is a complete developer reference for what is implemented today, what is stubbed, and what is still in progress.

## Table of contents
- Overview
- Quick start
- Emulator testing
- Project structure
- Architecture and data flow
- Database schema
- Models
- Repositories
- Services
- Widgets
- Screens and navigation
- Maps and geo
- Media and sharing
- Localization
- Tests
- In progress and TODO
- Known limitations
- License and collaboration

## Overview
Implemented today (high-level):
- Trip journal with steps, notes, dates, and local media.
- Interactive world map with visited-country highlighting and a country detail sheet.
- Stats dashboard, goals, achievements, and travel profile summary.
- Trip Story and Year in Review shareable cards.
- Media gallery and full-screen photo viewer on mobile/desktop.
- Guest-only auth (local only) with profile editing in Settings. The email/Google/Facebook buttons are UI placeholders only.
- Free vs Pro plan mock with step limits and upgrade screen.

Implemented today (feature depth):
- Trips
  - Create, edit, delete trips with date range, country ISO, title, notes.
  - Timeline grouped by day with step cards.
  - Trip-level gallery and shareable story.
- Steps
  - Diary-style text entries with optional place name and timestamp.
  - Attach photos from device storage.
  - View and share step details.
- Map
  - GeoJSON-driven world map with tap-to-select country.
  - Country sheet showing stats and recent trips.
  - Visited-country set and intensity calculations (currently not applied to fill color).
- Stats and goals
  - Totals (trips, countries, days), per-year summaries.
  - Longest trip, average days per trip.
  - Goal creation and progress tracking (countries per year).
- Achievements
  - Unlocks based on trip count, countries, and travel days.
- Recaps and sharing
  - Trip Story share card (image capture via RepaintBoundary).
  - Year in Review with highlights, map, and shareable card.
  - "On this day" memory surface.
- Media and profiles
  - Media gallery by trip, full-screen viewer, share for photos.
  - Guest profile with name, birthdate, avatar stored locally.

Not implemented yet (see In progress and TODO):
- Firebase auth integration and real provider sign-in flows (buttons are placeholders only).
- Billing and real Pro entitlements.
- Guest to account migration.
- Step geolocation input and true map-based step capture.

Testing status:
- Tested only on Android devices/emulators to date.

## Quick start
Prerequisites:
- Flutter SDK installed.
- `flutter doctor` has no critical errors for your target platform.

Install deps and run:
```bash
flutter pub get
flutter run -d <device_id>
```

## Emulator testing
Android emulator (Windows/macOS/Linux):
1. Install Android Studio and the Android SDK.
2. Open Android Studio -> Device Manager -> Create a new virtual device (AVD).
3. From the terminal, list emulators:
   ```bash
   flutter emulators
   ```
4. Launch an emulator by id:
   ```bash
   flutter emulators --launch <emulator_id>
   ```
5. Run the app on that emulator:
   ```bash
   flutter run -d <emulator_id>
   ```

Web (not an emulator, but useful for quick UI checks):
```bash
flutter run -d chrome
```

Desktop (optional):
```bash
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

Note: Map tiles are loaded from online providers, so an internet connection is required to see base maps.

## Project structure
```text
lib/
  app.dart                 # MaterialApp, routes, localization setup
  main.dart                # bootstrap + Provider wiring
  firebase_init.dart       # Firebase init (currently disabled)
  theme/app_theme.dart     # theme, ColorScheme, GlassTheme
  models/                  # Trip, Step, Goal, Achievement, YearReview, etc.
  repositories/            # Trip, Step, Goal repositories
  services/                # DB, auth, stats, geo, plan, year review
  screens/                 # UI screens
  widgets/                 # shared UI components
  utils/                   # helpers for map intensity, flags, photo viewer
assets/geojson/            # world map polygons
test/                      # unit and widget tests
```

Platform folders are present for Android, iOS, macOS, Windows, Linux, and Web. The app is currently Android-first; iOS is not maintained or tested.

## Tech stack
Core:
- Flutter (Dart), Material 3
- Provider for state management
- SQLite via `sqflite`
- `shared_preferences` for lightweight local settings/profile

Maps and geo:
- `flutter_map` + `latlong2`
- GeoJSON assets (`assets/geojson/world_simplified.geojson`)

Media and sharing:
- `image_picker` for photos
- `share_plus` for text and image sharing

Localization and UI:
- `intl` + Flutter localizations
- `google_fonts` for typography
- `sign_in_button` for provider button styling (UI-only placeholders)

Backend placeholder:
- `firebase_core` is included but initialization is disabled.

## Architecture and data flow
- State management: Provider.
- Data flow:
  - UI screens call repositories/services.
  - Repositories read/write SQLite via `DbService`.
  - Services compute aggregates (stats, goals, achievements, year review).
  - Maps are rendered from GeoJSON via `GeoService` and `WorldMap`.

Bootstrap:
- `main.dart` initializes Flutter bindings, calls `FirebaseInit.init()`, initializes the DB, and registers Providers.
- `app.dart` defines the app theme, supported locales, and named routes.

## Database schema
SQLite database `worldtrace.db` is created in `DbService` (`lib/services/db_service.dart`). Current schema version is 2.

Tables:
- `trips`
  - `id` INTEGER PRIMARY KEY AUTOINCREMENT
  - `userId` TEXT
  - `countryIsoCode` TEXT
  - `startDate` TEXT (ISO 8601)
  - `endDate` TEXT (ISO 8601)
  - `tripType` TEXT
  - `title` TEXT
  - `notes` TEXT
- `trip_steps`
  - `id` TEXT PRIMARY KEY
  - `tripId` TEXT NOT NULL
  - `timestamp` TEXT NOT NULL (ISO 8601)
  - `latitude` REAL NULL
  - `longitude` REAL NULL
  - `placeName` TEXT NULL
  - `text` TEXT NOT NULL
  - `mediaPaths` TEXT NULL (comma-separated file paths)
- `memories` (not currently used in UI)
  - `id` INTEGER PRIMARY KEY AUTOINCREMENT
  - `tripId` INTEGER
  - `type` TEXT
  - `path` TEXT
  - `caption` TEXT
  - `createdAt` TEXT (ISO 8601)
- `goals`
  - `id` TEXT PRIMARY KEY
  - `userId` TEXT NOT NULL
  - `title` TEXT NOT NULL
  - `type` TEXT NOT NULL
  - `targetValue` INTEGER NOT NULL
  - `year` INTEGER NOT NULL
  - `createdAt` TEXT NOT NULL
  - `updatedAt` TEXT NOT NULL

Migration behavior:
- Version 2 drops and recreates `goals` if upgrading from older versions.

## Models
Active models:
- `TripModel`: id, userId, countryIsoCode, startDate, endDate, tripType, title, notes.
- `StepModel`: id (String), tripId, timestamp, latitude, longitude, placeName, text, mediaPaths.
- `GoalModel`: id, userId, title, type, targetValue, year, createdAt, updatedAt.
- `Achievement`: id, title, description, unlocked.
- `YearReview`: year, tripsCount, countriesCount, totalDays, longestTrip, topCountry, achievements, highlightSteps.
- `UserProfile`: firstName, lastName, birthDate, photoPath.
- `OnThisDayMemory`: trip, step, year, countryName, flagEmoji, photoPath.

Present but not currently wired into UI flows:
- `MemoryModel` (memories table exists but no repository or screen usage).
- `CountryModel`
- `AppUserModel`
- `UserModel`

## Repositories
- `TripRepository` / `LocalTripRepository`
  - Add/update/delete trips
  - Get trips by user
  - Compute days per country
  - Delete trip with cascading step deletion
- `StepRepository`
  - Add/update/delete steps
  - Get steps for a trip or multiple trips
- `GoalRepository`
  - Add/update/delete goals
  - Fetch goals by user

## Services
- `DbService`: database init, schema, CRUD helpers, trip deletion with steps.
- `AuthService`: guest-only auth; stores guest id in `shared_preferences`.
  - Email/Google/Apple sign-in methods throw UnsupportedError (stubbed); UI buttons are placeholders.
- `PlanService`: Free vs Pro (mocked). Free limit is 10 steps per trip. `upgradeToProMock()` toggles Pro.
- `StatsService`: totals and highlights:
  - total trips, countries, travel days
  - days by year
  - average days per trip
  - longest and most recent trip
  - goal progress for countries-per-year
- `AchievementsService`: unlocks based on stats (first trip, 5 trips, 10 trips, 5 countries, 10 countries, 30 days in a year, 100 total days).
- `GeoService`: loads GeoJSON, caches country geometry, hit-testing for taps.
- `YearReviewService`: builds year recap data with top country, longest trip, highlights, and achievements.
- `OnThisDayService`: builds memories for today based on step timestamps.
- `UserProfileService`: stores profile data in `shared_preferences` per user id.
- `FirebaseInit`: currently disabled, prints a debug message.

## Widgets
- `WorldMap`: renders polygons via `flutter_map`, supports tap to select countries and display labels. Uses GeoJSON data and online tile layers.
- `CountryOverviewSheet`: bottom sheet with country stats, last visit, and photo strip.
- `GlassPanel`: reusable glassmorphism container with blur and gradient.
- `StatsCard`: small stat cards used on Home and Stats screens.

## Screens and navigation
Routes are declared in `lib/app.dart`:
- `/home` -> HomeScreen
- `/trips` -> TripsListScreen
- `/stats` -> StatsScreen
- `/goals` -> GoalsScreen
- `/settings` -> SettingsScreen
- `/profile` -> TravelProfileScreen
- `/world-map` -> WorldMapScreen
- `/achievements` -> AchievementsScreen
- `/year-review` -> YearInReviewScreen

Other screens are pushed via `MaterialPageRoute` in the UI:
- TripDetailScreen, TripEditScreen, StepEditScreen, StepDetailScreen,
  StepMediaViewerScreen, TripStoryScreen, MediaGalleryScreen, UpgradeScreen.

Screen details:
- `AuthScreen`: guest-only login; email/Google/Facebook buttons are UI placeholders.
- `OnboardingScreen`: static 3-page intro with "Continue as guest"; not wired to routes.
- `HomeScreen`:
  - Gradient background, map hero, stats rail, "On this day" memory.
  - Drawer with navigation.
  - Uses `WorldMap` and `CountryOverviewSheet` for tap details.
  - Pull-to-refresh reloads trips, steps, and map geometries.
- `TripsListScreen`:
  - Lists all trips (or a filtered country).
  - Shows country flag, title, date range, day count.
  - Allows delete with confirmation dialog.
- `TripEditScreen`:
  - Form for trip title, country ISO, notes, date range.
  - Validates required fields and date order.
- `TripDetailScreen`:
  - Header with date range, country, notes.
  - Optional map with step markers (requires step lat/lon).
  - Trip-level photo gallery.
  - Timeline grouped by day with step cards.
  - Step actions: view, edit, delete, share story.
  - Free/Pro gating: step limit with upgrade flow.
- `StepEditScreen`:
  - Diary-style editor for text, date/time, place name.
  - Adds photos with `image_picker` (disabled on web).
  - Does not capture coordinates (lat/lon remain null).
- `StepDetailScreen`:
  - Read-only diary view, share text via Share Plus.
  - Photo strip with full-screen viewer.
- `StepMediaViewerScreen`:
  - Full-screen photo viewer with paging and share action.
  - Only works with local files; web shows placeholders.
- `WorldMapScreen`:
  - Full-screen world map with visited countries.
  - Country tap opens `CountryOverviewSheet`.
  - FAB creates new trip.
- `MediaGalleryScreen`:
  - Grid of trips with a cover photo (first media found per trip).
  - Empty state when no media exists.
- `StatsScreen`:
  - Summary stats cards and highlights panel.
  - Signed-out state shows CTA to auth.
- `GoalsScreen`:
  - Create goals (countries per year).
  - Progress computed via StatsService.
  - Delete goal action.
- `AchievementsScreen`:
  - List of achievement tiles (locked/unlocked).
- `TravelProfileScreen`:
  - Summary card with totals and top year.
  - Achievements count, goals overview, plan status.
  - Link to Year in Review and Gallery.
  - Share button shares text stats (not image).
- `YearInReviewScreen`:
  - Year selection chips.
  - Map with travel path and country markers.
  - Story card built via RepaintBoundary and shared as image.
  - Achievements list and photo mosaic.
- `SettingsScreen`:
  - Profile edit dialog (name, birthdate, avatar photo).
  - Plan status card, logout.
  - Copyright notice at bottom.
- `UpgradeScreen`:
  - Mock upgrade flow; toggles Pro plan in PlanService.

## Maps and geo
Map stack:
- Polygons from `assets/geojson/world_simplified.geojson`.
- GeoJSON parsing in `GeoService`.
- Map UI in `WorldMap` widget.

Tile providers:
- Home map and Year in Review map use ArcGIS tiles:
  - World Imagery and World Street Map endpoints.
- Trip story map uses OpenStreetMap tiles.
- Network connection is required for tiles.

Country selection:
- `WorldMap` uses a hit-test on cached polygons and calls a tap callback.
- `CountryOverviewSheet` shows stats and photo previews.

Intensity:
- `IntensityUtils` normalizes days by country and provides discrete levels.
- `WorldMap` currently does not use intensity to vary fill color; visited countries are filled with a single style.

Map integration notes:
- See `MAP_INTEGRATION_V2.md` for the current GeoJSON parsing and map rendering pipeline.

## Media and sharing
Media:
- Photos are selected via `image_picker`.
- Paths are stored in DB as comma-separated strings.
- The app does not copy files; it relies on original device paths.
- Web: full-screen viewing and image picking are disabled; placeholders are shown.

Sharing:
- Text share in `StepDetailScreen` and `TravelProfileScreen`.
- Image share in `TripStoryScreen` and `YearInReviewScreen` via RepaintBoundary.
- Desktop/mobile use temporary files; web uses in-memory bytes.

## Localization
- ARB files under `lib/l10n/` with generated Dart in `lib/l10n/app_localizations.dart`.
- Supported locales declared in `lib/app.dart`:
  - en, it, fr, es, de, pt, ja, ru, zh, hi
- Regenerate localizations after editing ARB:
```bash
flutter gen-l10n
```
## Tests
Run tests:
```bash
flutter test
```

Tests included:
- `test/days_calc_test.dart`: TripModel day count.
- `test/stats_service_test.dart`: StatsService aggregates and per-year split.
- `test/intensity_utils_test.dart`: normalization and level mapping.
- `test/goal_progress_test.dart`: simple goal progress check (standalone).
- `test/widget_test.dart`: smoke test for app build with fake repositories.

## In progress and TODO
Explicitly stubbed or disabled:
- Firebase auth initialization is disabled (`lib/firebase_init.dart`).
- Email/Google/Apple sign-in methods are stubbed in `AuthService`.
- Pro upgrade is mocked in `PlanService`.

Planned or incomplete flows:
- Guest to account migration flow.
- Real billing and entitlements.
- Step coordinate capture (lat/lon) in the Step editor.
- Map intensity shading based on days (data is computed but not applied).
- Onboarding screen is not wired into navigation.
- Memories table and `MemoryModel` are not wired to any UI.
- Several models (`CountryModel`, `UserModel`, `AppUserModel`) are unused.

## Known limitations
- No cloud sync, no backend, local-only data.
- Web build cannot access local file paths for photo viewer.
- Map tiles require network access and may fail offline.
- Login provider buttons are UI-only; only guest access works.
- Goal migration drops goals when upgrading from DB version < 2.
- iOS is not actively supported or tested.

## License and collaboration
This repository uses a proprietary collaboration license. You may use it only to collaborate on the WorldTrace app with the copyright holder. Reproduction or monetization without explicit permission is prohibited. See `LICENSE` for full terms.
