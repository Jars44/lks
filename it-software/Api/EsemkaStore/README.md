# Esemka Store API

## Status
Spec + SQL provided. No backend, no source.

## Tech stack (per spec)
REST API. Request bodies use JSON. Method names and endpoint routes must not
be modified. Typical implementation: ASP.NET Core WebAPI + Entity Framework
+ MSSQL.

## Resources and rules
- `Category` — CRUD.
- `Product` — CRUD. `GET /Product` accepts `orderID` (filter by order id) and
  `search` (filter by name) query parameters.
- `Transaction` — CRUD. `GET /Transaction` accepts `minDate` and `maxDate`
  query parameters to filter by `TransactionDate`. `POST /Transaction` body
  contains `CustomerName`, `TransactionDate`, and `Orders` (each entry has
  `ProductID` and `Qty`).

Full endpoint list and request/response shapes: see `EsemkaStore.pdf`.

## Database
SQL Server, schema `dbo`. Tables (from `it-software/.extraction-index/esemka-store.tables`):

| Table |
|---|
| dbo.Category |
| dbo.Order |
| dbo.Product |
| dbo.Transaction |

Schema DDL: `EsemkaStore.sql`. Create the database, then run the script to
seed the schema.

## How to implement
Build an ASP.NET Core WebAPI with Entity Framework + MSSQL using the spec as
the endpoint contract and the SQL file as the schema. Mark all endpoints in
the spec PDF; this README does not enumerate them.
