# Voto.API

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- ASP.NET Core (IIS in-process via `aspnetcorev2_inprocess.dll`)
- .NET Core self-contained publish
- `Microsoft.Data.SqlClient` shipped alongside runtime

## Database
Unknown. No SQL dump or `.tables` extraction present. `appsettings.json` has no `ConnectionStrings` block. Table names are not bundled with the case artifact.

## API endpoints
| Method | Route | Controller / Action | Notes |
|---|---|---|---|
| POST (inferred) | `/api/auth` | `AuthController.Auth(AuthDTO)` | "User login endpoint"; 200 / 404 |
| GET (inferred) | `/api/camera` | `CameraController.GetCamera` | "Camera data endpoint"; 200 |
| GET (inferred) | `/api/camera/{id:int}` | `CameraController.GetCameraDetail` | "Camera information endpoint"; 200 / 404 |
| GET (inferred) | `/api/category` | `CategoryController.GetCategory` | "Category data endpoint"; 200 |
| POST (inferred) | `/api/transaction` | `TransactionController.AddNewTransaction(TransactionDTO)` | "Add new transaction endpoint"; 200 / 400 / 401 |
| GET (inferred) | `/api/user/me` | `UserController.GetMyInformation` | "User information endpoint"; 200 / 401 |
| GET (inferred) | `/api/user/transactions` | `UserController.GetMyTransaction` | "User transaction endpoint"; 200 / 401 |
| POST (inferred) | `/api/user/votoken` | `UserController.UpdateVotoken(id)` | "Update user votoken endpoint"; 200 / 401 / 400 |

Source: `Voto.API.xml` summaries + `it-software/.extraction-index/voto.endpoints`. Route paths and HTTP verbs are inferred; only controller action signatures are extracted.

## How to run
- [Windows] `Voto.API.exe` (self-contained publish, extracted from `Voto.API.rar`)
- [Windows / IIS] Place contents under IIS site; `web.config` already configures `aspnetcorev2_inprocess.dll` host
- [Linux] `mono Voto.API.exe` (mono runtime required; `.exe` is a .NET Core self-contained publish)

## Caveats
- Prebuilt binary, no build instructions possible.
- `appsettings.json` contains no `ConnectionStrings` block. Database location / credentials are not bundled; a connection string must be supplied at runtime before the API can start successfully.
- Kestrel bindings in `appsettings.json` are configured for `0.0.0.0:5000` and `0.0.0.0:5001`, so the published API listens on all interfaces by default if no IIS override is used.
- Route paths and HTTP verbs are inferred from action names + XML doc summaries; not extracted from `[Route]` / `[Http*]` attributes (binary-only inspection).
