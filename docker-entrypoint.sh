#!/bin/bash
set -e

if [[ $UPDATE_ON_START == "true" ]]; then
    steamcmd +force_install_dir "$APP_DIR" +@sSteamCmdForcePlatformType windows \
        +login "$STEAM_USERNAME" "$STEAM_PASSWORD" "$STEAM_GUARD_CODE" \
        +app_update $APP_ID validate +quit
fi

echo "Starting Moria"
xvfb-run wine $APP_DIR/MoriaServer.exe
