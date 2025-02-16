#!/bin/bash
set -e

if [[ "$UPDATE_ON_START" == "true" || ! -d "$APP_DIR/Moria/Binaries" ]]; then
    steamcmd +force_install_dir "$APP_DIR" +@sSteamCmdForcePlatformType windows \
        +login "$STEAM_USERNAME" "$STEAM_PASSWORD" "$STEAM_GUARD" \
        +app_update "$APP_ID" validate +quit
fi

if [[ "$RESET_SEED" == "true" ]]; then
    rm -f "$APP_DIR/Moria/Saved/Config/InviteSeed.cfg"
fi

SETTINGS_FILE="$APP_DIR/MoriaServerConfig.ini"
if [[ -f $SETTINGS_FILE ]]; then
    echo "Existing configuration file found, moving to $CONFIG_DIR"
    mv $SETTINGS_FILE "$CONFIG_DIR/MoriaServerConfig.ini"
fi

SAVE_DIR="$APP_DIR/Moria/Saved"
if [[ -d $SAVE_DIR ]]; then
    echo "Moving existing save to $DATA_DIR"
    mv "$APP_DIR/Moria" "$DATA_DIR"
else
    echo "No existing save file found"
    mkdir -p "$APP_DIR/Moria"
fi

envsubst < /MoriaServerConfig.ini.tmpl > "$CONFIG_DIR/MoriaServerConfig.ini"
ln -s "$DATA_DIR" $SAVE_DIR
ln -s "$CONFIG_DIR/MoriaServerConfig.ini" $SETTINGS_FILE

echo "Starting fake screen"
rm -f /tmp/.X0-lock 2>&1
Xvfb :0 -screen 0 1024x768x24 -nolisten tcp &

echo "Starting Moria"
DISPLAY=:0.0 wine "$APP_DIR/Moria/Binaries/Win64/MoriaServer-Win64-Shipping.exe"
