#!/bin/bash
set -e

if [[ $UPDATE_ON_START == "true" ]]; then
    steamcmd +force_install_dir "$APP_DIR" +@sSteamCmdForcePlatformType windows \
        +login "$STEAM_USERNAME" "$STEAM_PASSWORD" "$STEAM_GUARD_CODE" \
        +app_update $APP_ID validate +quit
fi

SETTINGS_FILE="$APP_DIR/MoriaServerConfig.ini"
if [[ ! -f $SETTINGS_FILE ]]; then
    echo "No configuration file found, linking default"
    ln -s $SETTINGS_FILE $CONFIG_DIR/MoriaServerConfig.ini
fi

SAVE_DIR="$APP_DIR/Moria/Saved"
if [[ ! -d $SAVE_DIR ]]; then
    echo "No save file found, linking directory"
    mkdir -p "$APP_DIR/Moria"
    ln -s $SAVE_DIR $DATA_DIR
fi

echo "Starting Moria"
xvfb-run wine $APP_DIR/MoriaServer.exe
