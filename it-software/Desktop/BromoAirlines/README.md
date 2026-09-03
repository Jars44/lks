# Bromo Airlines

## Status
Spec + SQL provided. No source, no implementation.

## Tech stack (per spec)
Desktop application (C# WinForms / .NET + MSSQL per `Database.sql`). Two roles:
- Admin — manage master data: maskapai, bandara, jadwal penerbangan, kode promo, status penerbangan.
- Customer — search and buy flight tickets, view own tickets.
All flights share the same departure and arrival day (no date difference between them).

## Database
SQL Server, schema `dbo`. Script: `Database.sql` (ISO-8859 text). Tables (from `it-software/.extraction-index/bromo-airlines.tables`):

| Table |
|---|
| dbo.Akun |
| dbo.Bandara |
| dbo.JadwalPenerbangan |
| dbo.KodePromo |
| dbo.Maskapai |
| dbo.Negara |
| dbo.PerubahanStatusJadwalPenerbangan |
| dbo.StatusPenerbangan |
| dbo.TransaksiDetail |
| dbo.TransaksiHeader |

## Supporting assets
- `BromoAirlines_TP.pdf` — test project instructions.
- `BromoAirlines_Style.pdf` — style guide.
- `DataDictionary.xlsx` — data dictionary.
- `Database.sql` — MSSQL schema + seed script.
- `Resources/` — logos, icons (28), 11 UI mockup PNGs under `Resources/User Interface/` (Login, Daftar Akun, Admin masters, Customer flow), and `Simbol Kurang Lebih.txt`.

## How to implement
Build a WinForms desktop app (C# / .NET) over the spec: Admin masters + customer search/buy flow, import `Database.sql` into MSSQL, and wire the connection string to `BromoAirlines`. Match the UI mockups and style guide; apply the same-day departure/arrival rule.
