VERSION 0.8
FROM ghcr.io/bubylou/steamcmd:v1.5.1-wine
LABEL org.opencontainers.image.source="https://github.com/bubylou/moria"
LABEL org.opencontainers.image.authors="Nicholas Malcolm <bubylou@pm.me>"
LABEL org.opencontainers.image.licenses="MIT"
ARG --global name=bubylou/moria
ARG --global --required tag

build:
    ENV APP_ID=3349480
    ENV APP_NAME=moria
    ENV APP_DIR="/app/moria"
    ENV CONFIG_DIR="/config/moria"
    ENV DATA_DIR="/data/moria"
    ENV UPDATE_ON_START=true
    ENV RESET_SEED=false
    ENV STEAM_USERNAME=anonymous
    ENV LISTEN_PORT=7777
    ENV LISTEN_ADDRESS=""
    ENV SERVER_PASSWORD=""
    ENV SERVER_NAME="Dedicated Server"
    ENV OPTIONAL_WORLD_FILENAME=""
    ENV WORLD_TYPE="campaign"
    ENV WORLD_SEED="random"
    ENV SERVER_FPS="60"
    ENV LOADED_AREA_LIMIT="12"
    ENV CONSOLE_ENABLED="false"
    ENV DIFFICULTY_PRESET="normal"
    ENV COMBAT_DIFFICULTY="default"
    ENV ENEMY_AGGRESSION="high"
    ENV SURVIVAL_DIFFICULTY="default"
    ENV MINING_DROPS="default"
    ENV WORLD_DROPS="default"
    ENV HORDE_FREQUENCY="default"
    ENV SIEGE_FREQUENCY="default"
    ENV PATROL_FREQUENCY="default"
    ENV ADVERTISE_ADDRESS="auto"
    ENV ADVERTISE_PORT="-1"
    ENV INITIAL_CONNECTION_RETRY_TIME="120"
    ENV AFTER_DISCONNECTION_RETRY_TIME="600"

    COPY ./MoriaServerConfig.ini.tmpl /MoriaServerConfig.ini.tmpl
    RUN mkdir -p "$APP_DIR" "$CONFIG_DIR" "$DATA_DIR" \
        && steamcmd +login anonymous +quit \
        && xvfb-run winetricks -q vcrun2022

    VOLUME [ "$APP_DIR", "$CONFIG_DIR", "$DATA_DIR" ]

    COPY entrypoint.sh /entrypoint.sh
    ENTRYPOINT ["/entrypoint.sh"]

    SAVE IMAGE --cache-from=docker.io/$name:main --push \
        docker.io/$name:$tag docker.io/$name:latest
    SAVE IMAGE --cache-from=ghcr.io/$name:main --push \
        ghcr.io/$name:$tag ghcr.io/$name:latest
    SAVE IMAGE ghcr.io/bubylou/moria:latest

full:
    FROM +build
    RUN steamcmd +force_install_dir "$APP_DIR" \
        +@sSteamCmdForcePlatformType windows \
        +login "$STEAM_USERNAME" "$STEAM_PASSWORD" "$STEAM_GUARD" \
        +app_update "$APP_ID" validate +quit

    SAVE IMAGE --cache-from=docker.io/$name:main-full --push \
        docker.io/$name:$tag-full docker.io/$name:latest-full
    SAVE IMAGE --cache-from=ghcr.io/$name:main-full --push \
        ghcr.io/$name:$tag-full ghcr.io/$name:latest-full

all:
    BUILD +build
    BUILD +full
