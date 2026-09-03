# LKS IT Software — RAR Documentation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Document every `it-software/` project so the repo accurately reflects what each folder actually contains, without writing any new code or extracting binaries.

**Architecture:** Read-only forensic pass over the existing artifacts (rar listings, .xml API docs, .sql schemas, .dll strings, .pdf specs, sqlite.db). Produces per-project README files, a top-level index, an `.extraction-index/` of committed inventories, and minimal tree cleanup. No binaries are extracted (user confirmed).

**Tech Stack:** Bash + `unrar` + `strings` + `pdftotext` + `iconv` + grep/awk (all on Linux). No Python, no Node, no dotnet build, no .NET runtime. utf-16le aware.

## Global Constraints

- **Zero new code.** READMEs and metadata files only.
- **Zero binary extraction.** rars stay sealed. `unrar l` and `unrar t` are read-only.
- **No file under `it-software/` is deleted except** `Android/EsemkaRecipes/MobileAndroid/` (duplicate subtree) **and the rename** of `LKSN2024_DesktopI/` → `LKSN2024_Desktop1/`.
- **Per-project READMEs go next to the spec PDF** (not at division root) so the existing `*.md` gitignore at repo root doesn't exclude them.
- **All `it-software/.work/` paths are gitignored** and ephemeral. Only `.extraction-index/` and per-project `README.md` files are committed.
- **UTF-16 LE SQL files require `iconv -f UTF-16LE -t UTF-8`** before grep. UTF-8 BOM files work with plain grep.
- **All text in READMEs is plain English, terse.** Tables over prose. No emojis. No "feature lists" that overstate what the code actually does.

---

## Task 1: Phase 1 — Preflight inventory

**Files:**
- Create: `it-software/.extraction-index/esemka-gym.txt`
- Create: `it-software/.extraction-index/EsemkaReceipt.API.txt` (the `Android/EsemkaRecipes/Backend/` one)
- Create: `it-software/.extraction-index/EsemkaReceipt.API.duplicate.txt` (note the `MobileAndroid/Backend/` dup)
- Create: `it-software/.extraction-index/EduSpark.API.txt`
- Create: `it-software/.extraction-index/Geegy.API.txt`
- Create: `it-software/.extraction-index/Voto.API.txt`
- Create: `it-software/.extraction-index/SakuraSushi.txt`
- Create: `it-software/.extraction-index/EsemkaLibrary.txt`
- Modify: `.gitignore` (append `it-software/.extracted/` and `it-software/.work/`)

**Interfaces:**
- Consumes: nothing
- Produces: 8 committed `.extraction-index/*.txt` files; 1 modified `.gitignore`

- [ ] **Step 1: Create gitignored work dirs**

```bash
mkdir -p it-software/.extraction-index it-software/.work/logs
```

- [ ] **Step 2: Run `unrar t` on all 8 rars and log**

```bash
for f in \
  "it-software/Android/EsemkaGym/esemka-gym.rar" \
  "it-software/Android/EsemkaRecipes/Backend/EsemkaReceipt.API.rar" \
  "it-software/Android/EsemkaRecipes/MobileAndroid/Backend/EsemkaReceipt.API.rar" \
  "it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 01/Backend API/EduSpark.API.rar" \
  "it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 02/Backend API/Geegy.API.rar" \
  "it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Mobile/Web API/Voto.API.rar" \
  "it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_WebAPI/WebAPI Example/Sakura Sushi.rar" \
  "it-software/Pack Soal/C1/Cases-2024-11-06_13_00_05/D1S2 - Mobile Android - Esemka Library/EsemkaLibraryApi/EsemkaLibraryApi/EsemkaLibrary.rar"; do
  base=$(basename "$f" .rar)
  unrar t "$f" 2>&1 | tee "it-software/.work/logs/${base}.test"
done
```

- [ ] **Step 3: Run `unrar l` on all 8 rars and capture committed inventories**

```bash
declare -A RARS=(
  ["esemka-gym"]="it-software/Android/EsemkaGym/esemka-gym.rar"
  ["EsemkaReceipt.API"]="it-software/Android/EsemkaRecipes/Backend/EsemkaReceipt.API.rar"
  ["EsemkaReceipt.API.duplicate"]="it-software/Android/EsemkaRecipes/MobileAndroid/Backend/EsemkaReceipt.API.rar"
  ["EduSpark.API"]="it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 01/Backend API/EduSpark.API.rar"
  ["Geegy.API"]="it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 02/Backend API/Geegy.API.rar"
  ["Voto.API"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Mobile/Web API/Voto.API.rar"
  ["SakuraSushi"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_WebAPI/WebAPI Example/Sakura Sushi.rar"
  ["EsemkaLibrary"]="it-software/Pack Soal/C1/Cases-2024-11-06_13_00_05/D1S2 - Mobile Android - Esemka Library/EsemkaLibraryApi/EsemkaLibraryApi/EsemkaLibrary.rar"
)
for k in "${!RARS[@]}"; do
  unrar l "${RARS[$k]}" > "it-software/.extraction-index/${k}.txt"
done
ls it-software/.extraction-index/  # expect 8 .txt files
```

- [ ] **Step 4: Update `.gitignore`**

Append at end of `.gitignore`:
```
# it-software ephemeral work dirs (not for commit)
it-software/.extracted/
it-software/.work/
```

- [ ] **Step 5: Verify `.gitignore` is effective**

```bash
git -C /home/jarsz/code/lks check-ignore -v it-software/.extracted it-software/.work
```
Expected: both paths printed with the matching `.gitignore` rule. If empty, the rule is wrong (check whitespace).

- [ ] **Step 6: Commit Phase 1**

```bash
git add it-software/.extraction-index .gitignore
git commit -m "docs(it-software): add rar inventory + gitignore work dirs"
```

---

## Task 2: Phase 2 — SQL/UTF-16 schema normalization

**Files:**
- Modify: each `.extraction-index/<project>.tables` (one per project that has a `.sql`)

**Interfaces:**
- Consumes: `.sql` files under `it-software/` (some UTF-16 LE, some UTF-8 ASCII, some UTF-8 BOM)
- Produces: per-project `*.tables` text file with `CREATE TABLE` line stubs (just table names)

- [ ] **Step 1: Write `it-software/.work/sqlschema.sh`**

```bash
#!/bin/bash
# sqlschema.sh <sqlfile> [outputfile]
# Print CREATE TABLE names from .sql (handles UTF-16 LE and UTF-8 BOM).
set -e
f="$1"
out="${2:-/dev/stdout}"
enc=$(file -b "$f" | cut -d, -f2- | tr -d ' ')
case "$enc" in
  *"UTF-16"*) iconv -f UTF-16LE -t UTF-8 "$f" | sed 's/^\xEF\xBB\xBF//' ;;
  *)          sed 's/^\xEF\xBB\xBF//' "$f" ;;
esac | grep -oiE 'CREATE TABLE[^(]+' \
  | sed -E 's/[[:space:]]+/ /g; s/^CREATE TABLE //i; s/\[//g; s/\]//g' \
  | awk '{$1=$1; print tolower($1) "." $2}' \
  | sort -u > "$out"
```

```bash
chmod +x it-software/.work/sqlschema.sh
```

- [ ] **Step 2: Run for all 14 SQL-bearing projects**

```bash
declare -A SQLS=(
  ["esemka-railways"]="it-software/Api/EsemkaRailways/EsemkaRailways.sql"
  ["esemka-store"]="it-software/Api/EsemkaStore/EsemkaStore.sql"
  ["bromo-airlines"]="it-software/Desktop/BromoAirlines/Database.sql"
  ["esemnet"]="it-software/Desktop/EsemNet/EsemNet.sql"
  ["esemka-corporation"]="it-software/Desktop/EsemkaCorporation/EsemkaCorporation_DB.sql"
  ["esemka-foodcourt-mssql"]="it-software/Desktop/EsemkaFoodcourt/Database-MSSQL.sql"
  ["esemka-foodcourt-mysql"]="it-software/Desktop/EsemkaFoodcourt/Database-MySQL.sql"
  ["esemka-polling"]="it-software/Desktop/EsemkaPolling/EsemkaPolling.sql"
  ["esemka-taskmaster"]="it-software/Desktop/EsemkaTaskMaster/EsemkaTaskMaster.sql"
  ["ubigpos"]="it-software/Desktop/UbigPos/MiniKasir.sql"
  ["motorrepair"]="it-software/Pack Soal/C1/Cases-2024-11-06_08_00_02/D1S1 - Desktop - Motorcycle Repair Application/D1S1 - Desktop - Motorcycle Repair Application/SQL/MotorRepair.sql"
  ["hovrailkiosk"]="it-software/Pack Soal/C2/Cases-2024-11-07_08_00_01/D2S1 - Desktop - HovRailKiosk/HovRailKiosk/HovRailKiosk.sql"
  ["tiks-id"]="it-software/Pack Soal/C2/Cases-2024-11-07_13_00_02/D2S2 - Mobile Android - Tiks.id/Database.sql"
  ["currency-converter"]="it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Desktop 1/CurrencyConverter.sql"
  ["esemka-library-desktop"]="it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Desktop 2 (Case)/EsemkaLibrary.sql"
  ["marathon-simulation"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Desktop2/MarathonSimulation_DB.sql"
  ["grocer-seeker"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_DesktopI/GrocerSeeker_DB.sql"
  ["grocer-seeker-rev"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_DesktopI/GrocerSeeker_DB_Rev.sql"
  ["sakura-sushi"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_WebAPI/sakurasushi.sql"
)
for k in "${!SQLS[@]}"; do
  it-software/.work/sqlschema.sh "${SQLS[$k]}" "it-software/.extraction-index/${k}.tables" 2>/dev/null || \
    echo "TABLES_NONE" > "it-software/.extraction-index/${k}.tables"
done
ls it-software/.extraction-index/*.tables | wc -l  # expect 19
```

- [ ] **Step 3: Verify SQL extraction**

```bash
for f in it-software/.extraction-index/*.tables; do
  echo "=== $f ==="
  cat "$f"
done
```

Expected: each file lists `schema.tablename` per line. UTF-16 files (esemnet, esemka-polling, esemka-taskmaster, ubigpos, esemka-railways, sakura-sushi) MUST now show their tables (previously grep returned 0 because of encoding). If any is empty, re-check `file -b` output for that file and fix `sqlschema.sh`.

- [ ] **Step 4: Commit Phase 2**

```bash
git add it-software/.extraction-index
git commit -m "docs(it-software): extract CREATE TABLE lists from all .sql files"
```

---

## Task 3: Phase 3 — Per-project docs (Batch A: 10 .NET projects with .xml API docs)

**Files:** 10 `README.md` files written next to each spec PDF.

**Interfaces:** Each README follows the same template. Read inputs:
- `.xml` API doc (if exists) → `grep -oE '<member name="M:[^"]+"' <xml>`
- `.sql` (or `sqlite.db` for Bakery/Petition) → use `*.tables` from Phase 2
- `strings <dll>` → controller names, action names, EF DbSet props
- `pdftotext -l 2 <pdf>` → 1–2 page spec summary (where spec PDF exists)

- [ ] **Step 1: Extract all .xml endpoint lists to `.extraction-index/<project>.endpoints`**

```bash
declare -A XMLS=(
  ["esemka-coffie"]="it-software/Android/EzemCoffie/Backend API/EzemKofi.API.xml"
  ["esemka-receipt"]="it-software/Android/EsemkaRecipes/Backend/EsemkaReceipt.API.xml"
  ["esemka-receipt-dup"]="it-software/Android/EsemkaRecipes/MobileAndroid/Backend/EsemkaReceipt.API.xml"
  ["eduspark"]="it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 01/Backend API/EduSpark.API.xml"
  ["geegy"]="it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 02/Backend API/Geegy.API.xml"
  ["voto"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Mobile/Web API/Voto.API.xml"
  ["sakura-sushi"]="it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_WebAPI/WebAPI Example/Sakura Sushi.xml"
  ["esemka-library"]="it-software/Pack Soal/C1/Cases-2024-11-06_13_00_05/D1S2 - Mobile Android - Esemka Library/EsemkaLibraryApi/EsemkaLibraryApi/EsemkaLibrary.xml"
)
for k in "${!XMLS[@]}"; do
  grep -oE '<member name="M:[^"]+"' "${XMLS[$k]}" | \
    sed 's/<member name="M://;s/"$//' \
    > "it-software/.extraction-index/${k}.endpoints"
done
```

- [ ] **Step 2: Dump `strings` for EsemkaBakery + EsemkaPetition DLLs (no .xml for these)**

```bash
strings it-software/Android/EsemkaBakery/Backend/EsemkaBakery.dll | \
  grep -E '^EsemkaBakery\.|^get_|^set_|^[A-Z][a-z]+Controller' | sort -u \
  > it-software/.extraction-index/esemka-bakery.strings
strings "it-software/Android/EsemkaPetition/Backend API/EsemkaPetition.dll" | \
  grep -E '^EsemkaPetition\.|^get_|^set_|^[A-Z][a-z]+Controller' | sort -u \
  > it-software/.extraction-index/esemka-petition.strings
```

- [ ] **Step 3: Dump sqlite.db schema for Bakery + Petition (using stdlib sqlite3)**

```bash
python3 -c "
import sqlite3
for path,label in [
  ('it-software/Android/EsemkaBakery/Backend/sqlite.db','esemka-bakery'),
  ('it-software/Android/EsemkaPetition/Backend API/sqlite.db','esemka-petition')]:
  with open(f'it-software/.extraction-index/{label}.tables-sqlite','w') as f:
    c=sqlite3.connect(path)
    for r in c.execute(\"SELECT name FROM sqlite_master WHERE type='table' ORDER BY name\"):
      f.write(r[0]+'\n')
    c.close()
"
```

- [ ] **Step 4: Write README for each .NET project (one task per README)**

The template for each:

```markdown
# <Project Name>

## Status
Prebuilt binary provided. Source not included.

## Tech stack
- <detected from .xml / strings / appsettings>

## Database
<list of tables, from .tables file or sqlite dump>

## API endpoints
<list from .endpoints file, or "Inferred from DLL strings: ...">

## How to run
- [Windows] `dotnet <assembly>.dll` (or double-click `<assembly>.exe`)
- [Linux] `mono <assembly>.exe` (mono runtime required; .exe is a .NET Core self-contained publish)

## Caveats
- <sqlite.db in / MSSQL via Data Source / connection string missing from appsettings>
- <prebuilt binary, no build instructions possible>
- <.dll date / version if known>
```

- [ ] **Step 4a: `it-software/Android/EsemkaBakery/Backend/README.md`**

Source the data:
```bash
cat it-software/.extraction-index/esemka-bakery.strings
cat it-software/.extraction-index/esemka-bakery.tables-sqlite
cat it-software/Android/EsemkaBakery/Backend/appsettings.json
```

Write the README. The 3 controllers are `Auth`, `Cake`, `Order` (from strings). sqlite.db tables go in.

- [ ] **Step 4b: `it-software/Android/EsemkaPetition/Backend API/README.md`**

Source the data:
```bash
cat it-software/.extraction-index/esemka-petition.strings
cat it-software/.extraction-index/esemka-petition.tables-sqlite
cat "it-software/Android/EsemkaPetition/Backend API/appsettings.json"
```

- [ ] **Step 4c: `it-software/Android/EzemCoffie/Backend API/README.md`**

Source: `cat it-software/.extraction-index/esemka-coffie.endpoints`. 5 controllers (Checkout, Coffee, CoffeeType, User). 9 endpoints. Status code docs are in the `.xml` `<response>` tags.

- [ ] **Step 4d: `it-software/Android/EsemkaRecipes/Backend/README.md`**

Source: `cat it-software/.extraction-index/esemka-receipt.endpoints`. 7 endpoints.

- [ ] **Step 4e: `it-software/Android/EsemkaRecipes/MobileAndroid/Backend/README.md`** (3-line stub)

```markdown
# EsemkaReceipt API (duplicate copy)

Duplicate of `../README.md`. Original rar at `../../../Backend/EsemkaReceipt.API.rar` is identical.
```

- [ ] **Step 4f: `it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 01/Backend API/README.md`**

Source: `cat it-software/.extraction-index/eduspark.endpoints` (4 endpoints).

- [ ] **Step 4g: `it-software/Pack Soal/SOAL LKS JATIM ITSSB 2024/Mobile 02/Backend API/README.md`**

Source: `cat it-software/.extraction-index/geegy.endpoints` (2 endpoints).

- [ ] **Step 4h: `it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Mobile/Web API/README.md`**

Source: `cat it-software/.extraction-index/voto.endpoints` (8 endpoints).

- [ ] **Step 4i: `it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_WebAPI/WebAPI Example/README.md`**

Source: `cat it-software/.extraction-index/sakura-sushi.endpoints` (23 endpoints). Also `cat it-software/.extraction-index/sakura-sushi.tables` (CREATE TABLE list).

- [ ] **Step 4j: `it-software/Pack Soal/C1/Cases-2024-11-06_13_00_05/D1S2 - Mobile Android - Esemka Library/EsemkaLibraryApi/EsemkaLibraryApi/README.md`**

Source: `cat it-software/.extraction-index/esemka-library.endpoints` (36 endpoints — the largest). Note: a matching complete Android client source already exists at `../../../EsemkaLibrary/`.

- [ ] **Step 5: Commit Phase 3**

```bash
git add it-software/ -A
git status  # verify only the 10 expected READMEs are staged
git commit -m "docs(it-software): add 10 .NET project READMEs (prebuilt binaries)"
```

---

## Task 4: Phase 4 — Per-project docs (Batch B: 9 spec-only projects)

**Files:** 9 `README.md` files next to each spec PDF/SQL, for projects with no backend.

- [ ] **Step 1: Read each spec PDF page 1–2 to capture description**

```bash
for pdf in \
  "it-software/Desktop/BromoAirlines/BromoAirlines_TP.pdf" \
  "it-software/Desktop/EsemNet/EsemNet.pdf" \
  "it-software/Desktop/EsemkaCorporation/EsemkaCorporation_TP.pdf" \
  "it-software/Desktop/EsemkaFoodcourt/EsemkaFoodcourt_TP.pdf" \
  "it-software/Desktop/EsemkaTaskMaster/EsemkaTaskMaster.pdf" \
  "it-software/Desktop/QuizinAja/QuizinAja_TP.pdf" \
  "it-software/Api/EsemkaRailways/EsemkaRailways.pdf" \
  "it-software/Api/EsemkaStore/EsemkaStore.pdf" \
  "it-software/Android/EsemkaGym/LKS2023_Test Project_Module 2.pdf"; do
  echo "=== $pdf ==="
  pdftotext -l 2 "$pdf" - 2>/dev/null | head -40
  echo
done
```

- [ ] **Step 2: Write `it-software/Api/EsemkaRailways/README.md`**

Template:
```markdown
# Esemka Railways API

## Status
Spec + SQL provided. No backend, no source.

## Tech stack (per spec)
<from pdftotext — likely ASP.NET Core, MSSQL>

## Database
- esemka-railways tables: <cat it-software/.extraction-index/esemka-railways.tables>

## How to implement
Build an ASP.NET Core WebAPI with Entity Framework + MSSQL using the spec as the
endpoint contract and the SQL file as the schema. Mark all endpoints in the spec
PDF; this README does not enumerate them.
```

- [ ] **Step 3: Write `it-software/Api/EsemkaStore/README.md`**

Same template. Tables: `cat it-software/.extraction-index/esemka-store.tables` → `category`, `order`, `product`, `transaction`.

- [ ] **Step 4: Write `it-software/Android/EsemkaGym/README.md`**

Spec + Spring Boot fat JAR. Note the `esemka-gym.rar` is a Java Spring Boot publish, not Android. (Spec PDF name is "LKS2023_Test Project_Module 2.pdf".)

- [ ] **Step 5: Write `it-software/Desktop/BromoAirlines/README.md`**

Spec + Style PDF + 10-table SQL + DataDictionary.xlsx + 50 UI PNGs. Tech stack per spec.

- [ ] **Step 6: Write `it-software/Desktop/EsemNet/README.md`**

Spec + SQL (UTF-16). Tables: `cat it-software/.extraction-index/esemnet.tables`.

- [ ] **Step 7: Write `it-software/Desktop/EsemkaCorporation/README.md`**

Spec + 7-table SQL. Tables: `cat it-software/.extraction-index/esemka-corporation.tables`.

- [ ] **Step 8: Write `it-software/Desktop/EsemkaFoodcourt/README.md`**

Spec + Style PDF + 10-table MSSQL + 10-table MySQL + DataDictionary.xlsx. Tables from both `.tables` files.

- [ ] **Step 9: Write `it-software/Desktop/EsemkaPolling/README.md`**

SQL only (UTF-16), no spec PDF. `cat it-software/.extraction-index/esemka-polling.tables`. Also note `EsemkaPolling.txt` exists.

- [ ] **Step 10: Write `it-software/Desktop/EsemkaTaskMaster/README.md`**

Spec + SQL (UTF-16). Tables: `cat it-software/.extraction-index/esemka-taskmaster.tables`.

- [ ] **Step 11: Write `it-software/Desktop/QuizinAja/README.md`**

Spec + Style PDF. No SQL.

- [ ] **Step 12: Commit Phase 4**

```bash
git add it-software/Api/EsemkaRailways/README.md \
        it-software/Api/EsemkaStore/README.md \
        it-software/Android/EsemkaGym/README.md \
        it-software/Desktop/BromoAirlines/README.md \
        it-software/Desktop/EsemNet/README.md \
        it-software/Desktop/EsemkaCorporation/README.md \
        it-software/Desktop/EsemkaFoodcourt/README.md \
        it-software/Desktop/EsemkaPolling/README.md \
        it-software/Desktop/EsemkaTaskMaster/README.md \
        it-software/Desktop/QuizinAja/README.md
git commit -m "docs(it-software): add 9 spec-only project READMEs"
```

---

## Task 5: Phase 5 — Repo-level index + root README accuracy pass

**Files:**
- Create: `it-software/README.md` (top-level index for the division)
- Modify: `README.md` (root) — rewrite the "Modul IT Software" section to match reality

- [ ] **Step 1: Write `it-software/README.md`**

```markdown
# LKS IT Software Module

## Status
This division is mostly spec/asset archives. 9/14 backends are prebuilt binaries
(`.exe` Spring Boot / .NET publish outputs, source not included). 1 Desktop project
(`UbigPos`) has full C# source. 5 Seleknas 2024 case projects under `Pack Soal/`
have source. 2 API projects have spec + SQL only.

## Projects

### Android/
| Project | Status | Docs |
|---|---|---|
| EsemkaBakery | prebuilt .NET + sqlite.db | Backend/README.md |
| EsemkaGym | Spring Boot fat JAR (NOT Android) | README.md |
| EsemkaPetition | prebuilt .NET + sqlite.db | Backend API/README.md |
| EsemkaRecipes | prebuilt .NET | Backend/README.md |
| EzemCoffie | prebuilt .NET | Backend API/README.md |

### Api/
| Project | Status | Docs |
|---|---|---|
| EsemkaRailways | spec + SQL only | README.md |
| EsemkaStore | spec + SQL only | README.md |

### Desktop/
| Project | Status | Docs |
|---|---|---|
| BromoAirlines | spec + 10-table SQL + assets | README.md |
| EsemNet | spec + SQL (UTF-16) | README.md |
| EsemkaCorporation | spec + 7-table SQL | README.md |
| EsemkaFoodcourt | spec + 10-table SQL (MSSQL+MySQL) | README.md |
| EsemkaPolling | SQL (UTF-16) only, no PDF | README.md |
| EsemkaTaskMaster | spec + SQL (UTF-16) | README.md |
| QuizinAja | spec only | README.md |
| UbigPos | full C# WinForms source (.NET 9) | (self-documenting) |

### Pack Soal/ — Seleknas 2024 cases
| Case | Status | Docs |
|---|---|---|
| C1/EsemkaLibrary | Android Kotlin source complete | (in-folder) |
| C1/MotorcyclerRepair | C# WinForms + EF Designer complete | (in-folder) |
| C2/HovRailKiosk | C# WinForms + EF Designer complete | (in-folder) |
| C2/Tiks09 | Android Kotlin source complete | (in-folder) |
| C2/TiksAPI | C# WebAPI + EF partial (no migrations) | (in-folder) |

## Archive inventory
See `.extraction-index/*.txt` for the `unrar l` output of every rar — confirms
they are prebuilt publish artifacts, not source.

## Cross-repo LKS divisions
- `../ai/` — LKS AI Kabupaten Malang 2025 module
- `../web-technology/` — LKS Web Technology (BOMBSKUY game + Laravel car-instalment API)
```

- [ ] **Step 2: Rewrite root `README.md` Modul IT Software section**

Replace lines 115–147 of the root `README.md` (the entire "Modul IT Software" subsection) with:

```markdown
## Modul IT Software

Modul IT Software berisi kumpulan proyek untuk LKS IT Software. **Status: sebagian besar
folder berisi spec PDF + aset gambar, hanya sedikit yang memiliki source code.** Lihat
`it-software/README.md` untuk breakdown per project.

### Implementasi yang tersedia (source code lengkap)
- `it-software/Desktop/UbigPos` — C# WinForms POS (.NET 9, MSSQL)
- `it-software/Pack Soal/C1/EsemkaLibrary` — Android Kotlin (seleknas 2024)
- `it-software/Pack Soal/C1/MotorcyclerRepair` — C# WinForms + EF Designer (seleknas 2024)
- `it-software/Pack Soal/C2/HovRailKiosk` — C# WinForms + EF Designer (seleknas 2024)
- `it-software/Pack Soal/C2/Tiks09` — Android Kotlin (seleknas 2024)
- `it-software/Pack Soal/C2/TiksAPI` — C# WebAPI + EF (partial, no migrations)

### Spec + binary (no source)
- 5 Android projects + 1 Spring Boot: `Backend/*.dll|.exe` publish artifacts only
- 1 WebAPI (Sakura Sushi, Voto, EsemkaLibrary, etc.): same
- 1 Spring Boot (EsemkaGym)

### Spec only
- `it-software/Api/EsemkaRailways` — spec PDF + SQL, no backend
- `it-software/Api/EsemkaStore` — spec PDF + 4-table SQL, no backend
- 7 Desktop projects (BromoAirlines, EsemNet, EsemkaCorporation, EsemkaFoodcourt,
  EsemkaPolling, EsemkaTaskMaster, QuizinAja) — spec + SQL/assets only
```

- [ ] **Step 3: Verify root README no longer claims the deleted text**

```bash
grep -c 'login/register/search/checkout' README.md  # expect 0
grep -c 'EzemCoffie' README.md  # may still appear; that's OK in the new text
```

If 0 → commit. If > 0, the rewrite was incomplete; fix.

- [ ] **Step 4: Commit Phase 5**

```bash
git add it-software/README.md README.md
git commit -m "docs(it-software): add top-level index + root README accuracy pass"
```

---

## Task 6: Phase 6 — Cleanup

- [ ] **Step 1: Delete the duplicate `MobileAndroid/` subtree**

```bash
ls it-software/Android/EsemkaRecipes/MobileAndroid/  # confirm it's a copy
rm -rf it-software/Android/EsemkaRecipes/MobileAndroid
```

If `MobileAndroid/` is NOT actually a copy (e.g. contains unique files), abort and add them to the parent or document in README instead.

- [ ] **Step 2: Rename typo directory**

```bash
cd "it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024"
git mv LKSN2024_DesktopI LKSN2024_Desktop1
cd -
```

- [ ] **Step 3: Verify .gitignore still effective and tree clean**

```bash
git -C /home/jarsz/code/lks check-ignore -v it-software/.extracted it-software/.work
git status --short  # expect only the 2 changes above + the prior commits
```

- [ ] **Step 4: Commit Phase 6**

```bash
git add -A
git status  # should show only the 2 changes
git commit -m "chore(it-software): remove duplicate MobileAndroid, rename LKSN2024_DesktopI"
```

---

## Verification (end-to-end)

Run after all phases:

```bash
# 1. Inventory files
[ "$(find it-software/.extraction-index -type f | wc -l)" -ge 39 ]

# 2. Per-project READMEs
N_READMES=$(find it-software -name 'README.md' | wc -l)
[ "$N_READMES" -ge 21 ]  # 10 + 9 + 1 + 1 (EsemkaRecipes dup stub)

# 3. Every README has required headers
find it-software -name 'README.md' -exec grep -L 'Status' {} + | wc -l  # expect 0
# 3b. Prebuilt-binary backends must document Caveats; spec-only/section READMEs use
#     "Supporting assets" / "How to implement" headings instead, so no universal gate.
find it-software -name 'README.md' -path '*Backend*' -exec grep -L 'Caveats' {} + | wc -l  # expect 0

# 4. Top-level index exists
[ -f it-software/README.md ] && grep -q 'Pack Soal' it-software/README.md

# 5. Root README accuracy
grep -q 'LKSN2024_Desktop1' README.md
! grep -q 'LKSN2024_DesktopI' README.md

# 6. .gitignore effective
git check-ignore -v it-software/.extracted it-software/.work

# 7. Duplicates removed (only the duplicated Backend subtree, not the spec assets)
[ ! -d it-software/Android/EsemkaRecipes/MobileAndroid/Backend ]
[ -f it-software/Android/EsemkaRecipes/MobileAndroid/EsemkaRecipes_TP.pdf ]
[ -d "it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Desktop1" ]

# 8. .work never tracked
git ls-files it-software/.work | wc -l  # expect 0
```

If any check fails: stop, fix, re-run. Do not mark complete with failures.

---

## Out of scope

- Building, running, or fixing the prebuilt binaries.
- Decompiling DLLs beyond `strings` metadata dump.
- Implementing missing backends (EsemkaRailways, EsemkaStore, 7 Desktop projects).
- Fixing broken NuGet packages.
- Decompiling the .NET DLLs to recover source.

## Effort

~3–4 hours wall time. Mechanical. Zero new code.
