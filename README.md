# Moria

This container is used to run a [Return to Moria](https://store.steampowered.com/app/2933130) dedicated server.
An additional container tag "-full" is available which already has the dedicated server files downloaded at the cost increases the intial container download size.

## Environment-Variables

### Start Up Options

The following environment variables are made available to alter how the game server behaves on start.

| Variable           | Description                                                 | Default Values  | Allowed Values |
|--------------------|-------------------------------------------------------------|-----------------|----------------|
| UPDATE_ON_START    | Update the game server files on container start.            | true            | true/false     |
| RESET_SEED         | Remove server seed file which will reset the join code.     | false           | true/false     |

### Server Settings

These variables modify some of the game configuration options and storage locations.

| Variable                       | Description                                                 | Default Values   | Allowed Values  |
|--------------------------------|-------------------------------------------------------------|------------------|-----------------|
| APP_DIR                        | Application files directory                                 | /app/moria       | directory       |
| CONFIG_DIR                     | Configuration file directory                                | /config/moria    | directory       |
| DATA_DIR                       | Save data directory                                         | /data/moria      | directory       |
| LISTEN_PORT                    | Port number for listener.                                   | 7777             | 1024-65535      |
| LISTEN_ADDRESS                 | Server interface for listener                               | ""               |                 |
| SERVER_PASSWORD                | Password required to connect                                | ""               |                 |
| SERVER_NAME                    | Server Name                                                 | Dedicated Server |                 |
| OPTIONAL_WORLD_FILENAME        | Select which save file to load                              | ""               |                 |
| WORLD_TYPE                     | Campaign or sandbox mode                                    | campaign         | campaign/sanbox |
| WORLD_SEED                     | World seed                                                  | random           |                 |
| SERVER_FPS                     | Server FPS, reduce to lower CPU                             | 60               |                 |
| LOADED_AREA_LIMIT              | Maximum areas to keep in memory. Affects performance        | 12               | 4-32            |
| CONSOLE_ENABLED                | Set for the server to launch the console window             | false            |                 |
| DIFFICULTY_PRESET              |                                                             | normal           |                 |
| COMBAT_DIFFICULTY              |                                                             | default          |                 |
| ENEMY_AGGRESSION               |                                                             | high             |                 |
| SURVIVAL_DIFFICULTY            |                                                             | default          |                 |
| MINING_DROPS                   |                                                             | default          |                 |
| WORLD_DROPS                    |                                                             | default          |                 |
| HORDE_FREQUENCY                |                                                             | default          |                 |
| SIEGE_FREQUENCY                |                                                             | default          |                 |
| PATROL_FREQUENCY               |                                                             | default          |                 |
| ADVERTISE_ADDRESS              |                                                             | auto             |                 |
| ADVERTISE_PORT                 |                                                             | -1               |                 |
| INITIAL_CONNECTION_RETRY_TIME  |                                                             | 120              |                 |
| AFTER_DISCONNECTION_RETRY_TIME |                                                             | 600              |                 |

## Examples

### Podman Run

```bash
podman run --name moria \
    -p 7777:7777/udp \
    -v ./moria:/data/moria \
    --restart unless-stopped \
    ghcr.io/bubylou/moria:latest
```

### Podman Compose

```yml
services:
  moria:
    container_name: moria
    image: ghcr.io/bubylou/moria:latest
    restart: unless-stopped
    environment:
      - UPDATE_ON_START=true
      - RESET_SEED=false
      - LISTEN_PORT=7777
    ports:
      - 7777:7777/udp
    volumes:
      - moria-app:/app/moria # game server files
      - moria-config:/config/moria # moria config files
      - moria-data:/data/moria # game/world save
volumes:
  moria-app:
  moria-config:
  moria-data:
```
