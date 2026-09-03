# Esemka Gym

## Status
Spec + Java Spring Boot publish (`esemka-gym.rar`) provided. No Android client
source. Spec PDF lives at `LKS2023_Test Project_Module 2.pdf` (filename does
not match project folder name).

## Tech stack (per spec)
- Backend: Java Spring Boot (prebuilt fat JAR).
- Mobile: native Android client (not provided) consuming the API.
- Auth: JWT.

## Server
- API listens on port `8081`.
- Health: `GET http://localhost:8081/api/ping` returns `pong`.
- API docs: `http://localhost:8081/swagger-ui/`.
- Mobile reach: `http://10.0.2.2:8081/...` (emulator loopback to host).

## Pre-populated data
| Email | Password | User type |
|---|---|---|
| admin@gmail.com | admin | admin |
| ada.lovelace@gmail.com | ada.lovelace | active member |
| mark.hopper@gmail.com | mark.hopper | inactive member |
| margaret.hamilton@gmail.com | margaret.hamilton | pending approval |

## Style guide
| Token | Hex |
|---|---|
| Primary | `#B33805` |
| Surface | `#F8ECE7` |

## Archive contents
- See `it-software/.extraction-index/esemka-gym.txt` for the `unrar l` listing
  of the archive.
- Spring Boot fat JAR structure: `BOOT-INF/classes/`, `BOOT-INF/lib/`,
  `META-INF/maven/com.lks2023/`.
- Package: `com.lks2023.esemkagym` (auth, controller, model, repository,
  security, service, view).

## How to run (locally, no build)
- Requires Java runtime (JRE 8+).
- Extract `esemka-gym.rar`; the JAR lives at `esemka-gym/esemka-gym.jar`.
- `java -jar esemka-gym.jar`.

## Caveats
- No source code included; only the prebuilt publish artifact.
- Spec PDF filename (`LKS2023_Test Project_Module 2.pdf`) does not match the
  project folder name.
- The companion `Revisi Soal.pdf` and `run-api-server.bat` are part of the
  spec and unchanged.
