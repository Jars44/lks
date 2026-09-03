# Esemka Foodcourt

## Status
Spec + SQL provided. No source, no implementation.

## Tech stack (per spec)
Desktop application (C# WinForms / .NET + MSSQL or MySQL). Two roles:
- **Admin** — manage members, menus, menu ingredients, view reservations by date with table layout
- **Member** — login/register, reserve table (full-day, fixed layout, max 4 people), order menu, view reservation history
Project name format: `Desktop_[XX]` (PC number). Connection: `.\SQLEXPRESS`, Windows Authentication. Date format DD/MM/YYYY, time HH:mm. Price format "Rp.X.XXX.YY". Fixed reservation fee Rp.50.000.00. Database schema changes prohibited.

## Database
SQL Server (MSSQL) and MySQL scripts provided. Both `Database-MSSQL.sql` and `Database-MySQL.sql` create `EsemkaFoodcourt` database. The extraction-index `.tables` files are **identical** (10 tables, `dbo` schema normalized in index):

| Table |
|---|
| dbo.Categories |
| dbo.Ingredients |
| dbo.MenuIngredients |
| dbo.Menus |
| dbo.ReservationDetails |
| dbo.Reservations |
| dbo.Roles |
| dbo.Tables |
| dbo.Units |
| dbo.Users |

## Supporting assets
- `EsemkaFoodcourt_TP.pdf` (18 pages) — test project instructions, ERD, full UI flow specs (10 forms)
- `EsemkaFoodcourt_Style.pdf` (2 pages) — color palette: Esemka Red RGB(199,22,28) #C7161C, Esemka Dark Red RGB(177,1,0) #B10100, Esemka Yellow RGB(230,146,10) #E6920A, Esemka Dark Yellow RGB(255,188,13) #FFBC0D, Esemka Dark Gray RGB(70,70,70) #464646, Esemka Light Gray RGB(160,160,160) #A0A0A0, Esemka Black RGB(0,0,0) #000000, Esemka White RGB(255,255,255) #FFFFFF
- `Database-MSSQL.sql` (ISO-8859) — MSSQL schema + seed
- `Database-MySQL.sql` (ISO-8859) — MySQL schema + seed
- `DataDictionary.xlsx` — data dictionary
- `Resources/` — 4 PNGs: `Esemka Foodcourt.png`, `Icon Small.png`, `table_free.png`, `table_reserved.png`

## How to implement
Build a WinForms desktop app (C# / .NET) from the spec: login/register, admin CRUD for members/menus/ingredients, reservation view with table layout (red=reserved, gray=free), member reserve table + order menu + history. Import either `Database-MSSQL.sql` or `Database-MySQL.sql` into respective DB, wire connection string to `EsemkaFoodcourt`. Apply style guide colors, enforce validations (email format, phone digits, password ≥8, price ≥1, people 1-4, quantity ≥1, no duplicate ingredients per menu). Features > design per spec.