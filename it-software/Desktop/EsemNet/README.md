# EsemNet

## Status
Spec + SQL provided. No source, no implementation.

## Tech stack (per spec)
Desktop application (C# WinForms / .NET + MSSQL). Admin-only app for an internet
cafe / computer rental: login, dashboard, transaction management. Date format
`01 Januari 1999`, time `12:00:00`, prices `Rp100.000,00`, duration `00 Jam`. Any
record used by other data shows a "data sedang dipakai" dialog on delete.

## Database
SQL Server, schema `dbo`. Script: `EsemNet.sql` is **UTF-16 LE** (convert before
importing, e.g. `iconv -f UTF-16LE -t UTF-8 EsemNet.sql`). Tables (from
`it-software/.extraction-index/esemnet.tables`):

| Table |
|---|
| dbo.Jenis |
| dbo.KodePotonganHarga |
| dbo.Komputer |
| dbo.Member |
| dbo.Paket |
| dbo.Pengguna |
| dbo.Transaksi |

## Supporting assets
- `EsemNet.pdf` — test project instructions (login, dashboard, add transaction).
- `EsemNet.sql` — MSSQL schema (UTF-16 LE).
- `Resources/` — `Colors.txt` (Orange `rgb(254,122,54)`, Blue `rgb(54,82,173)`,
  Navy `rgb(40,2,116)`, Milk White `rgb(233,246,255)`; font Segoe UI SemiBold 10pt),
  and 3 UI PNGs (`hacker.png`, `online-test.png`, `settings.png`).

## How to implement
Build a WinForms desktop app (C# / .NET) from the spec: login -> dashboard showing
today's active computers, add-transaction dialog. Import `EsemNet.sql` (after UTF-16
conversion) into MSSQL and wire the connection string to `EsemNet`. Apply the
required date/time/price/duration formatting and the in-use validation dialog.
