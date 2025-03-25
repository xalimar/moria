FROM ghcr.io/bubylou/steamcmd:v1.5.1-wine

LABEL org.opencontainers.image.source="https://github.com/xalimar/moria"
LABEL org.opencontainers.image.authors="xalimar <xalimar@gmail.com>"
LABEL org.opencontainers.image.licenses="MIT"

ENV APP_ID=3349480
ENV APP_NAME=moria
ENV APP_DIR="/app/moria"
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

USER root
RUN apt-get install gettext-base \
    && apt-get clean
USER steam


RUN mkdir -p "$APP_DIR" \
&& steamcmd +login anonymous +quit \
&& xvfb-run winetricks -q vcrun2022

COPY ./MoriaServerConfig.ini.tmpl /MoriaServerConfig.ini.tmpl
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
