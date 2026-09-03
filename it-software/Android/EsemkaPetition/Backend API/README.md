# EsemkaPetition

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- .NET (assembly `EsemkaPetition.dll`)
- ASP.NET Core MVC (AddControllers, ApiControllerAttribute)
- Entity Framework Core (Migrations, __EFMigrationsHistory)
- SQLite

## Database
Tables (from `.tables-sqlite` dump):
- Petitions
- Signatures
- Users
- __EFMigrationsHistory
- sqlite_sequence

## API endpoints
Inferred from DLL strings. Controller verbs inferred, not confirmed by route map:
- AuthController: Login, Register (Email, Password, FirstName, LastName, UserID)
- PetitionController: (Title, Description, Target, Creator, PetitionID, TotalSigners, IsCompleted, IsSigned)
- UserController: (MyProfile / UserID, SignedPetitions, CreatedPetitions)

## How to run
- [Windows] `dotnet EsemkaPetition.dll` (or double-click `EsemkaPetition.exe`)
- [Linux] `mono EsemkaPetition.exe` (mono runtime required; .exe is a .NET Core self-contained publish)

## Caveats
- `appsettings.json` sets `ConnectionStrings.DefaultConnection = Data Source=sqlite.db` and Kestrel `http://0.0.0.0:5000`.
- Prebuilt binary; no build instructions possible.
