# EsemkaBakery

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- .NET (assembly `EsemkaBakery.dll`)
- ASP.NET Core MVC (AddControllers, ApiControllerAttribute)
- Entity Framework Core (Migrations, __EFMigrationsHistory)
- SQLite

## Database
Tables (from `.tables-sqlite` dump):
- Cakes
- OrderItems
- Orders
- PromoCodes
- Users
- __EFMigrationsHistory
- sqlite_sequence

## API endpoints
Inferred from DLL strings. Controller verbs inferred, not confirmed by route map:
- AuthController: Login, Register (UsernameOrEmail, Password, PasswordConfirmation)
- CakeController: All, Find (CakeID, CakeName)
- OrderController: Order, Detail, GetCode (OrderCode, Qty, PromoCode, DiscountTotal, Subtotal)

## How to run
- [Windows] `dotnet EsemkaBakery.dll` (or double-click `EsemkaBakery.exe`)
- [Linux] `mono EsemkaBakery.exe` (mono runtime required; .exe is a .NET Core self-contained publish)

## Caveats
- No `ConnectionStrings` in `appsettings.json`; DB defaults to bundled `sqlite.db` next to binary.
- Prebuilt binary; no build instructions possible.
