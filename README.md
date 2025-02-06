# Moria

This container is used to run a [Return to Moria](https://store.steampowered.com/app/2933130) dedicated server.

## Environment-Variables

### Start Up Options

The following environment variables are made available to alter how the game server behaves on start.

| Variable           | Description                                                 | Default Values  | Allowed Values |
|--------------------|-------------------------------------------------------------|-----------------|----------------|
| UPDATE_ON_START    | Update the game server files on container start.            | false           | true/false     |
| RESET_SEED         | Remove server seed which will reset the join code.          | false           | true/false     |
| STEAM_USERNAME     | Reguires steam account with server key added.               | anonymous       | string         |
| STEAM_PASSWORD     | Reguired unless login is already cached.                    | ""              | string         |
| STEAM_GUARD        | Reguired if Steam Guard is enabled.                         | ""              | string         |

### Server Settings

These variables modify some of the game configuration options and storage locations.

| Variable           | Description                                                 | Default Values  | Allowed Values |
|--------------------|-------------------------------------------------------------|-----------------|----------------|
| APP_DIR            | Application files directory                                 | /app/moria      | directory      |
| CONFIG_DIR         | Configuration file directory                                | /config/moria   | directory      |
| DATA_DIR           | Save data directory                                         | /data/moria     | directory      |
| GAME_PORT          | Port number for the game.                                   | 7777            | 1024-65535     |
| LISTEN_PORT        | Port number for listener.                                   | 7777            | 1024-65535     |

## Examples

### Podman Run

```bash
podman run --name moria \
    -p 7777:7777/udp \
    -p 7777:7777/tcp \
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
      - UPDATE_ON_START=false
      - RESET_SEED=false
      - GAME_PORT=7777
      - LISTEN_PORT=7777
    ports:
      - 7777:7777/udp
      - 7777:7777/tcp
    volumes:
      - ./moria:/app/moria # game server files
      - moria-config:/config/moria # moria config files
      - moria-data:/data/moria # game/world save
volumes:
  moria-config:
  moria-data:
```
