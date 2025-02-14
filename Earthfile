VERSION 0.8
FROM ghcr.io/bubylou/steamcmd:v1.5.1-wine
LABEL org.opencontainers.image.source="https://github.com/bubylou/moria"
LABEL org.opencontainers.image.authors="Nicholas Malcolm <bubylou@pm.me>"
LABEL org.opencontainers.image.licenses="MIT"
ARG --global --required tag

build:
    ENV APP_ID=3349480
    ENV APP_NAME=moria
    ENV APP_DIR="/app/moria"
    ENV CONFIG_DIR="/config/moria"
    ENV DATA_DIR="/data/moria"
    ENV UPDATE_ON_START=false
    ENV RESET_SEED=false
    ENV STEAM_USERNAME=anonymous
    ENV LISTEN_PORT=7777

    COPY ./MoriaServerConfig.ini "$CONFIG_DIR/MoriaServerConfig.ini"
    RUN mkdir -p "$APP_DIR" "$CONFIG_DIR" "$DATA_DIR" \
        && steamcmd +login anonymous +quit \
        && xvfb-run winetricks -q vcrun2022

    VOLUME [ "$APP_DIR", "$CONFIG_DIR", "$DATA_DIR" ]

    COPY entrypoint.sh /entrypoint.sh
    ENTRYPOINT ["/entrypoint.sh"]

    SAVE IMAGE --push docker.io/bubylou/moria:$tag docker.io/bubylou/moria:latest
    SAVE IMAGE --push ghcr.io/bubylou/moria:$tag ghcr.io/bubylou/moria:latest

full:
    FROM +build
    RUN steamcmd +force_install_dir "$APP_DIR" \
        +@sSteamCmdForcePlatformType windows \
        +login "$STEAM_USERNAME" "$STEAM_PASSWORD" "$STEAM_GUARD" \
        +app_update "$APP_ID" validate +quit

    SAVE IMAGE --push docker.io/bubylou/moria:$tag-full docker.io/bubylou/moria:latest-full
    SAVE IMAGE --push ghcr.io/bubylou/moria:$tag-full ghcr.io/bubylou/moria:latest-full

all:
    BUILD +build
    BUILD +full
