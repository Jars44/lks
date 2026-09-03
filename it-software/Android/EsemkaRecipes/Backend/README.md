# EsemkaRecipes

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- .NET
- ASP.NET Core MVC
- Entity Framework Core

## Database
No schema dump extracted.

## API endpoints
7 endpoints extracted from `esemka-receipt.endpoints`:
- AuthController.AuthPost(AuthModel)
- CategoriesController.CategoryGet
- MeController.MeGet
- MeController.LikedRecipesGet
- RecipesController.RecipeGet(Int32, String)
- RecipesController.RecipeDetailGet(Int32)
- RecipesController.LikeRecipeGet(Int32)

## How to run
- [Windows] `dotnet EsemkaReceipt.API.dll` (or double-click `EsemkaReceipt.API.exe`)
- [Linux] `mono EsemkaReceipt.API.exe` (mono runtime required; .exe is a .NET Core self-contained publish)

## Caveats
- `appsettings.json` has no `ConnectionStrings` section.
- Prebuilt binary; no build instructions possible.
