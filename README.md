# Moria-Docker

This is a Docker container used to a Return to Moria dedicated server.

## Environment-Variables

### Start Up Options

These settings change how the game server behaves on on start.

| Variable           | Description                                                 | Default Values  | Allowed Values |
|--------------------|-------------------------------------------------------------|-----------------|----------------|
| UPDATE_ON_START    | Update the game server files on container start.            | false           | true/false     |

### Server Settings

These variables modify some of the game configuration options.

| Variable           | Description                                                 | Default Values  | Allowed Values |
|--------------------|-------------------------------------------------------------|-----------------|----------------|
| GAME_PORT          | Port number for the game.                                   | 7777            | 1024-65535     |
| LISTEN_PORT        | Port number for listener.                                   | 7777            | 1024-65535     |

## Examples

### Docker Run

```bash
docker run -d \
    --name moria \
    -p 7777:7777/udp \
    -p 7777:7777/tcp \
    -v ./moria:/data/moria \
    --restart unless-stopped \
    bubylou/moria:latest
```

### Docker Compose

```yml
services:
  moria:
    container_name: moria
    image: ghcr.io/bubylou/moria:latest
    restart: unless-stopped
    environment:
      - UPDATE_ON_START=false
      - GAME_PORT=7777
      - LISTEN_PORT=7777
    ports:
      - 7777:7777/udp
      - 7777:7777/tcp
    volumes:
      - moria-app:/app/moria # game server files
      - moria-config:/config/moria # moria config files
      - moria-data:/data/moria # game/world save
volumes:
  moria-app:
  moria-config:
  moria-data:
```
