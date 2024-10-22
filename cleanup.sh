#!/bin/bash

# Define the base directory to search in (you can change this to your specific path)
BASE_DIR="/var/lib/jenkins/workspace/"

# Find and delete directories with "tom-cat-build_ws-cleanup" in their name
find "$BASE_DIR" -type d -name "*tom-cat-build_ws-cleanup*" -exec rm -rf {} + 2>/dev/null

echo "Cleanup completed: All directories containing 'tom-cat-build_ws-cleanup' have been deleted."
