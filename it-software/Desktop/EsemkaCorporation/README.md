# Esemka Corporation

## Status
Spec + SQL provided. No source, no implementation.

## Tech stack (per spec)
Desktop application in C# (WinForms / .NET) + MSSQL. Employee data management for
a five-department IT services corporation (Information Technology, Operations,
Finance and Accounting, Procurement, Human Capital). Job positions ascend Staff,
Officer, Supervisor, Manager, Director. Features: login authentication, employee
profile viewing, job mutation and promotion applications. Project name format
`DESKTOP_I_[XX]` where XX is the PC number.

## Database
SQL Server, schema `dbo`. Script: `EsemkaCorporation_DB.sql` (ASCII). Tables (from
`it-software/.extraction-index/esemka-corporation.tables`):

| Table |
|---|
| dbo.department |
| dbo.employee |
| dbo.job |
| dbo.job_level |
| dbo.mutation |
| dbo.position |
| dbo.promotion |

Soft delete: records are not removed; a `deleted_at` timestamp is set instead. All
tables carry `created_at` / `deleted_at` columns — filter `deleted_at IS NULL` on
reads.

## Supporting assets
- `EsemkaCorporation_TP.pdf` — test project instructions, ERD, and UI wireframes
  (embedded in the PDF; no separate style guide or resource folder).
- `EsemkaCorporation_DB.sql` — MSSQL schema + seed script.

## How to implement
Build a WinForms desktop app (C# / .NET) from the spec: login, employee profile,
mutation and promotion flows. Import `EsemkaCorporation_DB.sql` into MSSQL and wire
the connection string to `EsemkaCorporation`. Wireframes may be adjusted as long as
business and application flow stay intact; scoring targets features and validation,
so add validation with useful error messages and respect the soft-delete convention.
