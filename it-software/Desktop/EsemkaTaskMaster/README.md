# Esemka Task Master

## Status
Spec + SQL provided. No source, no implementation.

## Tech stack (per spec)
Desktop application per spec (C# / .NET + MSSQL inferred from sibling `it-software/Desktop/` projects and `EsemkaTaskMaster.sql`). Two roles:
- **Leader** — team overview, member history, task CRUD, assign tasks.
- **Member** — own profile, own task list, work on assigned tasks.

Date format: `12 Januari 2022 12:50:34`. Time estimate units: Menit, Jam, Hari (display as e.g. `20 menit` / `5 jam` / `12 hari`). Single-window rule: opening a new form from the leader/member dashboard must return to that dashboard on close; closing the dashboard triggers logout; no two forms open concurrently.

Task lifecycle status: `Dibuat` -> `Ditugaskan` -> `Sedang Dikerjakan` -> `Selesai`. Leader/member "Tambah Tugas" and "Ubah Tugas" forms each exist twice in the spec — treated as the same form, accessible from both dashboards.

## Database
SQL Server, schema `dbo`. Script: `EsemkaTaskMaster.sql` (UTF-16 LE — convert before executing if tooling cannot read it). Tables (from `it-software/.extraction-index/esemka-taskmaster.tables`):

| Table |
|---|
| dbo.Position |
| dbo.Task |
| dbo.Team |
| dbo.TeamDetail |
| dbo.User |

## Supporting assets
- `EsemkaTaskMaster.pdf` — the full spec, 9 screens: Halaman Login, Halaman Leader, Halaman Riwayat Anggota Tim, Halaman Tambah Tugas, Halaman Ubah Tugas, Halaman Member, Halaman Detail Member, Halaman Tambah Tugas (member), Halaman Ubah Tugas (member).
- `EsemkaTaskMaster.sql` — MSSQL schema + seed (UTF-16 LE).

## How to implement
Build a WinForms desktop app (C# / .NET) from the PDF spec: email/password login that resolves to either a leader or member dashboard, per-role task CRUD with assignment and status transitions, member history filter, and a single-form lifecycle that logs out on dashboard close. Import `EsemkaTaskMaster.sql` into MSSQL, convert from UTF-16 LE first if needed, and wire the connection string to `EsemkaTaskMaster`. No style guide is provided — styling is at the developer's discretion.
