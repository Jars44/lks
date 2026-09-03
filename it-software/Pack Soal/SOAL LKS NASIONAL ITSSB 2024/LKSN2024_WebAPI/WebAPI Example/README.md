# Sakura Sushi

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- ASP.NET Core (IIS in-process via `aspnetcorev2_inprocess.dll`)
- .NET Core self-contained publish
- JWT auth (`Jwt:Key`, `Issuer`, `Audience` in `appsettings.json`)
- `Microsoft.Data.SqlClient` shipped alongside runtime

## Database
SQL Server / SQL database expected. From `sakurasushi.sql` / `.tables` extraction:

- `dbo.CartItems`
- `dbo.Categories`
- `dbo.Items`
- `dbo.OrderItems`
- `dbo.Orders`
- `dbo.Tables`
- `dbo.Transactions`
- `dbo.Users`

No `ConnectionStrings` block is present in `appsettings.json` or `appsettings.Development.json`.

## API endpoints
| Method | Route | Controller / Action | Notes |
|---|---|---|---|
| POST (inferred) | `/api/auth/signin` | `AuthController.SignInAsync(SignInParam)` | Sign-in; JWT generation supported by `GenerateJwtToken` |
| GET (inferred) | `/api/auth/me` | `AuthController.GetCurrentUserAsync` | Current user from token |
| GET (inferred) | `/api/cart/{customerId}` | `CartController.GetAsync(customerId)` | Cart lookup |
| POST (inferred) | `/api/cart/{customerId}` | `CartController.AddItem(customerId, CartItemParam)` | Add cart item |
| DELETE (inferred) | `/api/cart/{customerId}/{itemId}` | `CartController.DeleteItem(customerId, itemId)` | Remove cart item |
| POST (inferred) | `/api/cart/{customerId}/order` | `CartController.Order(customerId)` | Checkout cart |
| GET (inferred) | `/api/items` | `ItemsController.GetItems(query)` | Menu/items search; `.ctor(RestaurantContext)` |
| GET (inferred) | `/api/transaction/{customerId}` | `TransactionController.GetAsync(customerId)` | Transaction history |
| GET (inferred) | `/api/transaction/{customerId}/orders` | `TransactionController.GetOrdersAsync(customerId)` | Order history |
| POST (inferred) | `/api/transaction/{customerId}/pay` | `TransactionController.PayAsync(customerId)` | Payment initiation |
| POST (inferred) | `/api/transaction/{customerId}/items/{orderItemId}/status` | `TransactionController.UpdateOrderItemStatusAsync(...)` | Order status update |
| GET (inferred) | `/` | `ErrorController.HandleError` | Global error fallback |

Source: `Sakura Sushi.xml` summaries + `it-software/.extraction-index/sakura-sushi.endpoints`. Route paths and HTTP verbs are inferred; only controller action signatures are extracted. Migrations/entity helpers and `ErrorController.Throw` are omitted from the public API surface.

## How to run
- [Windows] `Sakura Sushi.exe` (self-contained publish, extracted from `Sakura Sushi.rar`)
- [Windows / IIS] Place contents under IIS site; `web.config` already configures `aspnetcorev2_inprocess.dll` host
- [Linux] `mono Sakura Sushi.exe` (mono runtime required; `.exe` is a .NET Core self-contained publish)

## Caveats
- Prebuilt binary, no build instructions possible.
- `appsettings.json` and `appsettings.Development.json` contain no `ConnectionStrings` block. Database location / credentials are not bundled; a connection string must be supplied at runtime before the API can start successfully.
- `appsettings.json` configures the app to listen on `http://localhost:5555` via `"Urls"`.
- ERD is available at `ERD.pdf` as a supporting reference, but schema changes must be verified against `sakurasushi.sql`.
- Route paths and HTTP verbs are inferred from action names + XML doc summaries; not extracted from `[Route]` / `[Http*]` attributes (binary-only inspection).
