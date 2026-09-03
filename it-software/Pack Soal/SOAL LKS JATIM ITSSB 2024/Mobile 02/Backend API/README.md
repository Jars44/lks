# Geegy.API

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- ASP.NET Core (Windows-hosted, IIS in-process via `aspnetcorev2_inprocess.dll`)
- .NET (version not recorded; inferred from assembly)
- `Microsoft.Data.SqlClient` shipped alongside runtime

## Database
Unknown. No SQL dump, `.tables` extraction, or `ConnectionStrings` block present in `appsettings.json` / `appsettings.Development.json`. Table names not discoverable from supplied artifacts.

## API endpoints
| Method | Route | Controller / Action | Notes |
|---|---|---|---|
| GET | (inferred) `?date={DateTime}&search={String}` | `AppointmentsController.GetAppointments` | "Get appointments log"; 200 on success |
| GET | (inferred) `/{id:int}` | `AppointmentsController.GetAppointmentDetail` | "Get appointment detail"; 200 / 404 |

Source: `Geegy.API.xml` summaries + `it-software/.extraction-index/geegy.endpoints`. Route paths are inferred; only controller action signatures are extracted.

## How to run
- [Windows] `Geegy.API.exe` (self-contained publish, 54,157,667 bytes from `Geegy.API.rar`)
- [Windows / IIS] Place contents under IIS site; `web.config` already configures `aspnetcorev2_inprocess.dll` host
- [Linux] `mono Geegy.API.exe` (mono runtime required; `.exe` is a .NET Core self-contained publish)

## Caveats
- Prebuilt binary, no build instructions possible.
- `appsettings.json` and `appsettings.Development.json` contain no `ConnectionStrings` block. Database location / credentials not bundled. Required connection string must be supplied at runtime (e.g. environment variable, user secrets) before the API can start successfully.
- No SQL schema or seed data in the artifact. Table list cannot be enumerated.
- Route paths and HTTP verbs are inferred from action names + XML doc summaries; not extracted from `[Route]` / `[Http*]` attributes (binary-only inspection).
