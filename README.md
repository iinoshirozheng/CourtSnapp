<div align="center">

# Court Snapp

**A Flutter court-discovery and reservation app built with feature-first Clean Architecture.**

</div>

---

## Overview

Court Snapp is a responsive Flutter application for discovering courts, viewing court details, and building out reservation workflows. The current `main` branch includes authentication flows plus a dedicated court-finder experience with court cards and detail pages.

## Highlights

- **Court finder** with dedicated discovery and court-detail screens.
- **Authentication flows** with welcome/login routing and social-login UI assets.
- **Feature-first Clean Architecture** separating data, domain, and presentation concerns.
- **BLoC state management** with typed events/states.
- **Dependency injection** through `get_it` and `injectable`.
- **Declarative navigation** with `go_router`.
- **Supabase integration**, Dio networking, local preferences, and responsive UI support.

## Quick Start

Requirements: Flutter `>=3.27.0` and Dart SDK compatible with `^3.8.0`.

```bash
git clone https://github.com/iinoshirozheng/CourtSnapp.git
cd CourtSnapp
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

Run the test suite with:

```bash
flutter test
```

Build platform packages with Flutter's standard commands, for example:

```bash
flutter build apk
flutter build ios
```

## Current Product Surface

The app is organized around independent feature modules. On `main`, the visible product work includes:

- onboarding / welcome and login flows;
- court discovery through `court_finder`;
- reusable court cards;
- a dedicated court details view;
- shared navigation, theming, networking, error handling, and reusable UI components.

Dependency-update branches exist in the repository, but their changes are not described here as shipped behavior until they are merged into `main`.

## Architecture

```text
lib/
├── core/
│   ├── constants/
│   ├── di/
│   ├── error/
│   ├── navigation/
│   ├── network/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── shared/
│   ├── bloc/
│   └── components/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── court_finder/
│       └── presentation/
└── main.dart
```

The project follows these boundaries:

- **Data** — data sources, transport models, and repository implementations.
- **Domain** — entities, repository contracts, and use cases.
- **Presentation** — pages, widgets, and BLoC-driven UI state.
- **Core / shared** — cross-cutting navigation, DI, networking, themes, and reusable UI.

## Key Dependencies

| Purpose | Packages |
|---|---|
| State management | `flutter_bloc`, `bloc`, `equatable` |
| Dependency injection | `get_it`, `injectable` |
| Models / codegen | `freezed`, `json_serializable`, `build_runner` |
| Navigation | `go_router` |
| Backend / auth | `supabase_flutter` |
| Networking | `dio` |
| Local state | `shared_preferences` |
| UI | `google_fonts`, `flutter_svg`, `responsive_builder` |

## Development

After changing generated models or injectable registrations, regenerate code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Before committing, run:

```bash
flutter test
```

## Project Status

Court Snapp is under active development. This README documents the default `main` branch only; experimental and dependency-update branches are treated as work in progress until merged.
