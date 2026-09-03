# EzemCoffie

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- .NET (self-contained publish `EzemKofi.API.exe`)
- ASP.NET Core (AddControllers, ApiControllerAttribute)
- Entity Framework Core

## Database
No schema dump extracted. EF Core model inferred from DTOs: CheckoutItem, AuthDTO, RegisterDTO; entities Coffee, CoffeeType, Cart, Transaction.

## API endpoints
9 endpoints extracted from `esemka-coffie.endpoints`:
- CheckoutController.DoCheckout(List{CheckoutItemDTO})
- CoffeeController.GetCoffeeByFilter(Nullable{Int32}, String)
- CoffeeController.GetCoffee(Int32)
- CoffeeController.GetTopPicksCoffee
- CoffeeTypeController.GetCoffeeCategory
- UserController.Auth(AuthDTO)
- UserController.Register(RegisterDTO)
- UserController.GetMyInformation
- UserController.GetMyTransaction

## How to run
- [Windows] `dotnet EzemKofi.API.dll` (or double-click `EzemKofi.API.exe`)
- [Linux] `mono EzemKofi.API.exe` (mono runtime required; .exe is a .NET Core self-contained publish)

## Caveats
- `appsettings.json` has no `ConnectionStrings` section; connection string not found.
- Single self-contained `.exe` publish.
- Prebuilt binary; no build instructions possible.
