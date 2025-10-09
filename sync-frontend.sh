#!/bin/bash
#
# Frontend Sync Script for CliniqueDigitaleJEE (v2)
#
# This script copies your local frontend files (JSP, CSS, JS, etc.)
# into the running Tomcat container, allowing you to see changes
# without rebuilding or restarting.
#

# --- Configuration ---
CONTAINER_NAME="clinique_tomcat"
WEBAPP_PATH="/usr/local/tomee/webapps/CliniqueDigitaleJEE"
SOURCE_PATH="./src/main/webapp"

# --- Script Start ---
echo "🚀 Starting frontend sync to container '$CONTAINER_NAME'..."

# Check if container is running
if [ ! "$(docker ps -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "❌ Error: Container '$CONTAINER_NAME' is not running. Please start it with 'docker-compose up -d'."
    exit 1
fi

echo "   Container found. Proceeding with file copy."

# Function to sync a directory
sync_dir() {
    local_dir=$1
    target_dir=$2

    if [ -d "$SOURCE_PATH/$local_dir" ]; then
        # Ensure the target directory exists in the container
        docker exec "$CONTAINER_NAME" mkdir -p "$target_dir"
        
        # Copy the contents of the local directory to the target directory
        # The '/.' at the end of the source path is crucial: it copies the *contents*
        # of the directory, not the directory itself.
        echo "   -> Syncing contents of '$local_dir' to '$target_dir'"
        docker cp "$SOURCE_PATH/$local_dir/." "$CONTAINER_NAME:$target_dir"
        
        # Optional: Verify by listing contents in container
        echo "      Verifying contents in container:"
        docker exec "$CONTAINER_NAME" ls -lA "$target_dir" | sed 's/^/      | /'
    else
        echo "   ⚠️ Warning: Directory '$SOURCE_PATH/$local_dir' not found. Skipping."
    fi
}

# --- Sync Top-Level Directories ---
sync_dir "css" "$WEBAPP_PATH/css"
sync_dir "js" "$WEBAPP_PATH/js"
sync_dir "images" "$WEBAPP_PATH/images"
sync_dir "components" "$WEBAPP_PATH/components"

# --- Sync Nested Directories (like those in WEB-INF) ---
# Note: We are careful NOT to sync WEB-INF/classes or WEB-INF/lib
sync_dir "admin" "$WEBAPP_PATH/admin"
sync_dir "auth" "$WEBAPP_PATH/auth"
sync_dir "doctor" "$WEBAPP_PATH/doctor"
sync_dir "patient" "$WEBAPP_PATH/patient"
sync_dir "staff" "$WEBAPP_PATH/staff"

# --- Sync JSPs inside WEB-INF ---
sync_dir "WEB-INF/admin" "$WEBAPP_PATH/WEB-INF/admin"
sync_dir "WEB-INF/auth" "$WEBAPP_PATH/WEB-INF/auth"
sync_dir "WEB-INF/components" "$WEBAPP_PATH/WEB-INF/components"
sync_dir "WEB-INF/doctor" "$WEBAPP_PATH/WEB-INF/doctor"
sync_dir "WEB-INF/patient" "$WEBAPP_PATH/WEB-INF/patient"
sync_dir "WEB-INF/staff" "$WEBAPP_PATH/WEB-INF/staff"


# --- Sync Individual Root Files ---
if [ -f "$SOURCE_PATH/index.jsp" ]; then
    echo "   -> Syncing file: index.jsp"
    docker cp "$SOURCE_PATH/index.jsp" "$CONTAINER_NAME:$WEBAPP_PATH/"
fi
if [ -f "$SOURCE_PATH/profile.jsp" ]; then
    echo "   -> Syncing file: profile.jsp"
    docker cp "$SOURCE_PATH/profile.jsp" "$CONTAINER_NAME:$WEBAPP_PATH/"
fi
if [ -f "$SOURCE_PATH/error.jsp" ]; then
    echo "   -> Syncing file: error.jsp"
    docker cp "$SOURCE_PATH/error.jsp" "$CONTAINER_NAME:$WEBAPP_PATH/"
fi


echo "✅ Frontend sync complete! You can now refresh your browser."
echo "   If changes don't appear, try a hard refresh (Ctrl+Shift+R or Cmd+Shift+R)."

