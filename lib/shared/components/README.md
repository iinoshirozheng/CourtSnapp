# Shared Components

This directory contains all reusable UI components that can be shared across different features in the application.

## Component Organization

The components are organized by type:

- **buttons/** - Button components (primary, secondary, social login, etc.)
  - **advanced/** - More complex button implementations with animations and effects
- **text/** - Text-related components
- **inputs/** - Form input components (text fields, dropdowns, etc.)
- **layouts/** - Layout components (cards, containers, etc.)
- **indicators/** - Indicators and feedback components (progress, loaders, etc.)
- **icons/** - Custom icon components

## Usage

Import components directly from their specific path:

```dart
import 'package:project/shared/components/buttons/primary_button.dart';
```

Or use the barrel file for multiple components:

```dart
import 'package:project/shared/components/index.dart';
```

## Component Guidelines

1. Keep components focused on a single responsibility
2. Make components configurable with proper parameters
3. Document properties and usage with proper comments
4. Follow the established design system for consistent styling
5. Use composition over inheritance
6. Consider both light and dark mode when designing components

## Migration Note

Previously, some components were located in `core/widgets/`. All these components have been migrated to `shared/components/` to have a consistent location for all reusable UI components. 