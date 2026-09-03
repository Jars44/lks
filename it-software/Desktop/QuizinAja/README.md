# QuizinAja

## Status
Spec + style guide PDFs provided. No SQL script, no `Resources/` folder, no source, no implementation. Note: the test project lists `QuizinAja_MSSQL.sql` / `QuizinAja_MySQL.sql` and a `Resources` folder as part of the package, but only the two PDFs are present in this repo.

## Tech stack (per spec)
Desktop application per spec (C# / .NET + MSSQL or MySQL inferred from sibling `it-software/Desktop/` projects; the TP mentions both `QuizinAja_MSSQL.sql` and `QuizinAja_MySQL.sql` but neither is shipped here). Two roles:
- **Registered user** — create account, log in, create quizzes, add questions, view quiz report (avg time, avg correct %, total participants, per-participant detail).
- **Guest** — join a quiz by code + nickname, answer questions, submit.

Quiz code: uppercase letters and digits only, must be unique. Password: minimum 4 characters. Username: must be unique. Average time format: `hour:minute:second`. Correct percentage = `correct answer count / total questions count * 100%`. Project name on submission: `DESKTOP_II_[XX]` (XX = PC number).

## Database
No SQL file is provided in this repo. The implementer must derive the schema from the TP — an Entity-Relationship Diagram is included in `QuizinAja_TP.pdf` (page 4) and describes the data model directly. Once a real `QuizinAja_MSSQL.sql` / `QuizinAja_MySQL.sql` is sourced, document the tables here. Schema is fixed; competitors are prohibited from changing it.

## Supporting assets
- `QuizinAja_TP.pdf` — test project instructions, 7 screens: Login, Create Account, User Main, Add Quiz, View Quiz Report, Enter Quiz Code (dialog), Quiz (guest play). Includes the ERD on page 4.
- `QuizinAja_Style.pdf` — style guide. Color palette: Quiz Blue `#156545` (RGB 21,101,69), Quiz Light Blue `#37765D` (RGB 55,118,93), Quiz Light Gray `#C8C8C8` (RGB 200,200,200), Quiz Gray `#969696` (RGB 150,150,150), Quiz Black `#000000`, Quiz White `#FFFFFF`. Apply consistently across all screens.

## How to implement
Build a WinForms desktop app (C# / .NET) from the TP spec: username/password login with show-password toggle and "Create Account" / "Join quiz as guest" links; registered users manage quizzes (add with min one question, delete with confirm) and view a per-quiz report; guests enter a code + nickname and play a timed quiz with a left-side question navigator (max 5 buttons per row, scrollbar when overflowing, gray=unanswered / green=answered), real-time elapsed clock, and a `Finish` button that enforces all-answered before saving. Source or recreate the database from the ERD in `QuizinAja_TP.pdf`, then wire the connection string. Match the style guide colors and the provided wireframes.
