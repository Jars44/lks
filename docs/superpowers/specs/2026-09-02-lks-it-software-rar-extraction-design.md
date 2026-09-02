# LKS IT Software — RAR Extraction + Documentation Design (2026-09-02)

## Goal
Extract, inventory, and document every sealed `.rar` backend in `it-software/` to turn the repo from "spec dump" into a browsable reference. Zero new code written.

## Inventory (confirmed)

### Sealed archives to extract (7)
| Archive | Location | Expected contents |
|---|---|---|
| `esemka-gym.rar` | `Android/EsemkaGym/` | Android client (Kotlin/Java) |
| `EsemkaReceipt.API.rar` | `Android/EsemkaRecipes/Backend/` | Receipt API source (.NET) |
| `EsemkaReceipt.API.rar` | `Android/EsemkaRecipes/MobileAndroid/Backend/` | Duplicate of above |
| `EduSpark.API.rar` | `Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 01/Backend API/` | Mobile01 API source |
| `Geegy.API.rar` | `Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 02/Backend API/` | Mobile02 API source |
| `Voto.API.rar` | `Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Mobile/Web API/` | Mobile API source |
| `Sakura Sushi.rar` | `Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_WebAPI/WebAPI Example/` | Web API source |
| `EsemkaLibrary.rar` | `Pack Soal/C1/Cases-2024-11-06_13_00_05/` | Android client (likely matches `C1/EsemkaLibrary` source) |

### Already-extracted prebuilt DLLs (3 — skip extraction, metadata-dump only)
| Project | Location | Type |
|---|---|---|
| EsemkaBakery | `Android/EsemkaBakery/Backend/` | ASP.NET Core (DLL/EXE, EF Sqlite) |
| EsemkaPetition | `Android/EsemkaPetition/Backend/` | ASP.NET Core (DLL/EXE, EF Sqlite) |
| EzemCoffie | `Android/EzemCoffie/Backend API/` | Single .exe (likely self-contained) |

### Spec-only (no rar, no source — document as-is)
- `Api/EsemkaRailways` — spec PDF + SQL only
- `Api/EsemkaStore` — spec PDF + SQL only
- 7 Desktop projects — spec PDFs + SQL only

## Design

### Phase 0 — Pre-flight (serial)
1. Verify `unrar` and `7z` available (`command -v`); install via `apt` if missing.
2. Test each rar: `unrar t <file>` → flag encrypted/corrupt. Abort and document if so.

### Phase 1 — Inventory (serial, fast)
For each rar, capture `unrar l <file>` output to `it-software/.extraction-index/<project>.txt`. These files are **committed** as lightweight, human-readable indexes.

### Phase 2 — Extraction (parallelizable, 7 independent dirs)
Extract into `it-software/.extracted/<project>/` — **gitignored**.
- Keeps original spec folders clean (no mixed source+assets).
- Each project gets its own sibling dir; no write conflicts.

### Phase 3 — Build / Sanity (per-project, parallelizable)
| Type | Commands |
|---|---|
| .NET (.csproj/.sln) | `dotnet restore && dotnet build` |
| Android (build.gradle.kts) | `./gradlew tasks` if `gradlew` exists; else document layout only |
| Prebuilt DLLs | `strings *.dll \| head -100` → infer EF entities + route patterns |

**Do not fix build failures.** Document blockers in per-project README.

### Phase 4 — Per-project Documentation (parallelizable, 12 files)
Write `README.md` next to each spec PDF containing:
- Tech stack / target framework (from csproj/build output)
- EF Core entities (from `OnModelCreating` or DLL strings dump)
- REST endpoints (from controller names + Postman collection if present)
- DB schema summary (from adjacent `.sql` where one exists; note absence otherwise)
- Build/run instructions (if build succeeds)
- Caveats: missing connection strings, deprecated packages, signed APK not source, etc.

### Phase 5 — Repo-level Index (single file)
- `it-software/README.md` (committed) — pointer index to each project sub-README.
- Root `README.md` Modul IT Software section updated to match reality (currently overstates: only 1/8 Desktop projects has source; 5/7 Android have no source; both API projects have no source).

### Phase 6 — Cleanup
- Delete duplicate `Android/EsemkaRecipes/MobileAndroid/Backend/` (identical to parent `Backend/`).
- Rename typo `LKSN2024_DesktopI` → `LKSN2024_Desktop1`.
- Add `it-software/.extracted/` to `.gitignore`.

## Deliverables (committed)
1. `it-software/.extraction-index/*.txt` — 7 inventories.
2. 12 per-project `README.md` files (7 from rars + 3 from already-extracted DLLs + 2 spec-only EsemkaRailways/EsemkaStore).
3. `it-software/README.md` — top-level index.
4. Root `README.md` Modul IT Software section — accuracy pass.
5. `.gitignore` — adds `it-software/.extracted/`.

## Deliverables (NOT committed)
- `it-software/.extracted/<project>/` — local inspection only.

## Verification
1. All 7 `unrar t` pass (or documented as encrypted/corrupt).
2. All 7 `.extraction-index/*.txt` exist and non-empty.
3. All 12 per-project `README.md` exist and contain: stack, entities, endpoints, DB summary, build status, caveats.
4. `it-software/README.md` links every project.
5. Root `README.md` no longer claims "EsemkaBakery has full login/register/search/checkout" etc. — states actual state.
6. `.gitignore` contains `it-software/.extracted/`.

## Out of scope
- Fixing broken NuGet restores / deprecated packages.
- Building unsigned APKs from extracted Android source (if it's source).
- Implementing missing backends for spec-only projects (EsemkaRailways, EsemkaStore, 7 Desktop projects).
- Decompiling the 3 prebuilt DLLs beyond metadata dump.

## Effort estimate
~3–4 hours wall time. Mechanical, zero new code.

## User confirmations locked
- Extraction into `it-software/.extracted/` (gitignored) — **yes**
- Skip rar for prebuilt DLLs, metadata-dump only — **yes**
- Document spec-only projects as "spec+SQL only, no backend" — **yes**