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