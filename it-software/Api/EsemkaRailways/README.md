# Esemka Railways API

## Status
Spec + SQL provided. No backend, no source.

## Tech stack (per spec)
REST API with `/api` prefix on every endpoint. Request bodies use JSON. Method
names and endpoint routes must not be modified. Typical implementation: ASP.NET
Core WebAPI + Entity Framework + MSSQL.

## Resources and rules
- `Passenger` — unique email and phone number on create/update.
- `Train` — `Type` must be `Express` or `Local`.
- `Station` — CRUD only.
- `Schedule` — `DepartureTime` must be before `ArriveTime` and on the same day.
- `Ticket` — listed in the SQL schema; resource rules live in the spec PDF.

Full endpoint list and request/response shapes: see `EsemkaRailways.pdf`.

## Database
SQL Server, schema `dbo`. Tables (from `it-software/.extraction-index/esemka-railways.tables`):

| Table |
|---|
| dbo.Passenger |
| dbo.Schedule |
| dbo.Station |
| dbo.Ticket |
| dbo.Train |

Schema DDL: `EsemkaRailways.sql` (UTF-16 LE). Create the database, then run
the script to seed the schema.

## How to implement
Build an ASP.NET Core WebAPI with Entity Framework + MSSQL using the spec as
the endpoint contract and the SQL file as the schema. Mark all endpoints in
the spec PDF; this README does not enumerate them.
