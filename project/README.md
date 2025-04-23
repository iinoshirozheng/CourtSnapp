# Court Snapp

A modern, responsive Flutter application for booking and managing court reservations.

## Architecture

This project follows a Clean Architecture approach with BLoC pattern for state management.

### Project Structure

```
lib/
  ├── core/                    # Core functionality used across the app
  │   ├── constants/           # App-wide constants
  │   ├── di/                  # Dependency injection
  │   ├── error/               # Error handling
  │   ├── navigation/          # Routing
  │   ├── network/             # Network services
  │   ├── theme/               # App theming
  │   ├── utils/               # Utility functions
  │   └── widgets/             # Core UI components
  │
  ├── shared/                  # Shared resources across features
  │   ├── bloc/                # Shared blocs
  │   └── components/          # Reusable UI components
  │       ├── buttons/         # Button components
  │       ├── cards/           # Card components
  │       ├── inputs/          # Input field components
  │       ├── layouts/         # Layout components
  │       ├── loaders/         # Loading components
  │       └── indicators/      # Progress indicators
  │
  ├── features/                # App features (domains)
  │   ├── auth/                # Authentication feature
  │   │   ├── data/            # Data layer
  │   │   │   ├── datasources/ # Data sources
  │   │   │   ├── models/      # Data models
  │   │   │   └── repositories/# Repository implementations
  │   │   ├── domain/          # Domain layer
  │   │   │   ├── entities/    # Business entities
  │   │   │   ├── repositories/# Repository interfaces
  │   │   │   └── usecases/    # Business use cases
  │   │   └── presentation/    # Presentation layer
  │   │       ├── bloc/        # Feature-specific blocs
  │   │       ├── pages/       # UI pages
  │   │       └── widgets/     # Feature-specific widgets
  │   └── [other_features]/    # Other app features
  │
  └── main.dart                # App entry point
```

### Key Architectural Components

- **Clean Architecture**: Separate data, domain, and presentation layers
- **BLoC Pattern**: Reactive state management with events and states
- **Dependency Injection**: Using get_it and injectable
- **Repository Pattern**: Abstract data access
- **Use Cases**: Encapsulate business logic

### Key Packages Used

- flutter_bloc: State management
- get_it & injectable: Dependency injection
- freezed: Immutable state models
- go_router: Navigation
- dartz: Functional programming constructs

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate code
4. Run `flutter run` to start the app

## Development Process

- Code generation: `flutter pub run build_runner build --delete-conflicting-outputs`
- Tests: `flutter test`
- Building: `flutter build apk` (Android) or `flutter build ios` (iOS)
