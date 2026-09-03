# EsemkaLibraryApi

## Status
Prebuilt backend binary provided. Android client source available separately at `../../../../EsemkaLibrary/`.

## Tech stack
- ASP.NET Core (IIS in-process via `aspnetcorev2_inprocess.dll`)
- .NET Core self-contained publish
- JWT auth (`Jwt:Key`, `Issuer` in `appsettings.json`)

## Database
From `.tables` extraction:

- `dbo.Book`
- `dbo.BookGenre`
- `dbo.Borrowing`
- `dbo.Genre`
- `dbo.Member`

No `ConnectionStrings` block is present in `appsettings.json` or `appsettings.Development.json`.

## API endpoints
| Method | Route | Controller / Action | Notes |
|---|---|---|---|
| POST (inferred) | `/api/login` | `G01LoginController.Login(LoginParam)` | JWT generation supported by `GenerateJSONWebToken` |
| POST (inferred) | `/api/signup` | `G02SignUpController.SignUp(SignUpParam)` | Email / password regex validation |
| GET (inferred) | `/api/home` | `G03HomeController.Get(query)` | Home page / listing |
| GET (inferred) | `/api/home/photo/{id:guid}` | `G03HomeController.Photo(id)` | Book photo |
| GET (inferred) | `/api/book/{id:guid}` | `G04BookDetailController.GetProduct(id)` | Book detail |
| POST (inferred) | `/api/mycart/borrow` | `G05MyCartController.PostBorrowing(BorrowingParam)` | Borrow book |
| GET (inferred) | `/api/profile` | `G06MyProfileController.GetMe` | Current user |
| GET (inferred) | `/api/profile/photo` | `G06MyProfileController.GetMePhoto` | Current user photo |
| POST (inferred) | `/api/profile/photo` | `G06MyProfileController.PostMePhoto(IFormFile)` | Upload user photo |
| GET (inferred) | `/api/profile/transactions` | `G06MyProfileController.GetTransactions` | Borrowing history |
| GET (inferred) | `/api/borrowing/{id:guid}` | `G07BorrowingDetailController.GetTransactions(id)` | Borrowing detail |
| GET (inferred) | `/api/forum` | `G08ForumController.GetForums` | Forum thread list |
| DELETE (inferred) | `/api/forum/{id:guid}` | `G08ForumController.DeleteForumAsync(id)` | Delete own thread |
| POST (inferred) | `/api/forum` | `G09AddThreadController.PostForumAsync(AddThreadParam)` | Create forum thread |
| GET (inferred) | `/api/forum/{id:guid}` | `G10ThreadDetailController.GetForumAsync(id)` | Thread detail |
| POST (inferred) | `/api/forum/{id:guid}/reply` | `G10ThreadDetailController.PostForumReplyAsync(id, reply)` | Post thread reply |
| DELETE (inferred) | `/api/forum/{id:guid}/reply/{replyId:guid}` | `G10ThreadDetailController.DeleteForumReplyAsync(id, replyId)` | Delete thread reply |
| GET (inferred) | `/api/forum/photo/{user}` | `G10ThreadDetailController.GetMePhoto(user)` | Thread participant photo |

Source: `EsemkaLibrary.xml` summaries + `it-software/.extraction-index/esemka-library.endpoints`. Route paths and HTTP verbs are inferred; only controller action signatures are extracted.

## How to run
- [Windows] `EsemkaLibrary.exe` (self-contained publish, extracted from `EsemkaLibrary.rar`)
- [Windows / IIS] Place contents under IIS site; `web.config` already configures `aspnetcorev2_inprocess.dll` host
- [Linux] `mono EsemkaLibrary.exe` (mono runtime required; `.exe` is a .NET Core self-contained publish)

## Caveats
- Prebuilt binary, no build instructions possible.
- `appsettings.json` and `appsettings.Development.json` contain no `ConnectionStrings` block. Database location / credentials are not bundled; a connection string must be supplied at runtime before the API can start successfully.
- `LibraryDbContext.SeedData` is present; seed data is created at startup but table structure is not bundled in the artifact.
- `System.Text.RegularExpressions.Generated.*` methods found in the binary are source-generated regex internals, not API endpoints, and are excluded from the endpoint list.
- Route paths and HTTP verbs are inferred from action names + XML doc summaries; not extracted from `[Route]` / `[Http*]` attributes (binary-only inspection).
