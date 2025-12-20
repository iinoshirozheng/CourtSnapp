#!/bin/bash

# This script rebuilds the dependency injection configuration

echo "Rebuilding dependency injection..."
cd project
flutter pub run build_runner build --delete-conflicting-outputs

echo "Dependency injection rebuilt successfully."
echo "You may need to update your imports if you were using any viewmodels." 