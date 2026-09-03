# Esemka Polling

## Status
No spec PDF provided — only `EsemkaPolling.txt` (Indonesian, plain-text spec) + `EsemkaPolling.sql`. No style guide, no UI mockups, no data dictionary. No source, no implementation.

## Tech stack (per spec)
The `.txt` spec states no tech stack. MSSQL is confirmed by `EsemkaPolling.sql` (T-SQL, `CREATE DATABASE [EsemkaPolling]`); C# WinForms / .NET is inferred from sibling projects in `it-software/Desktop/`. Two roles:
- **Admin** — poll CRUD, user CRUD, per-poll report (respondent count, per-option stats, pie chart)
- **Regular user** — join polls (once each), view report for polls joined

Rules from spec: polls with no respondents yet may be edited or deleted; once a poll has started it is locked. Admin may close an ongoing poll. Only a user's name is editable. Deleting a user cascades — remove all their participation records across every poll. Identity code is 5 numeric characters. Landing page is public: shows ongoing polls and interim results before login.

## Database
SQL Server, schema `dbo`. Script: `EsemkaPolling.sql` (UTF-16 LE, CRLF). Tables (from `it-software/.extraction-index/esemka-polling.tables`):

| Table |
|---|
| dbo.Admins |
| dbo.PollOptions |
| dbo.PollResponses |
| dbo.Polls |
| dbo.Users |

## Supporting assets
- `EsemkaPolling.txt` — the full spec, 9 screens: Halaman Awal (landing), Halaman Masuk (login), Halaman Utama admin, Halaman Pemungutan Suara, Halaman Pengguna, Halaman Laporan admin, Halaman Utama user, Halaman Ikuti Pemungutan Suara, Halaman Laporan user.
- `EsemkaPolling.sql` — MSSQL schema + seed.

## How to implement
Build a WinForms desktop app (C# / .NET) from the `.txt` spec: public landing page with interim results, login dialog branching admin (username + password) vs user (5-digit identity code), admin poll/user CRUD plus report with pie chart, user vote flow with one-vote-per-poll enforcement and own-participation report. Import `EsemkaPolling.sql` into MSSQL and wire the connection string to `EsemkaPolling`. Convert the script from UTF-16 LE first if the tooling chokes on it. Since no style guide is provided, styling is at the developer's discretion.
