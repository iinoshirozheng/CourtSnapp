#!/bin/bash

# This script helps clean up the core/widgets directory after migration to shared/components

echo "Checking for any remaining imports of core/widgets..."
grep_result=$(grep -r "import.*core/widgets" lib/ --include="*.dart")

if [ -n "$grep_result" ]; then
  echo "Warning: Found imports that still reference core/widgets:"
  echo "$grep_result"
  echo ""
  echo "Please update these imports to use shared/components before proceeding."
  exit 1
else
  echo "No imports of core/widgets found. Safe to remove the directory."
  
  read -p "Do you want to remove the core/widgets directory? (y/n): " confirm
  if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
    rm -rf lib/core/widgets
    echo "lib/core/widgets directory has been removed."
    echo "Migration complete!"
  else
    echo "Cleanup cancelled. You can manually remove the directory when ready."
  fi
fi 