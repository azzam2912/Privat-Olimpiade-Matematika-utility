# CLAUDE.md

Guidance for Claude Code (and humans) working in this repository.

## What this repo is

A personal teaching archive for **Olimpiade Matematika** (Indonesian math
olympiad) coaching — LaTeX handouts, problem packs, answer keys, figures, and
Asymptote diagrams. It is **content, not a software project**: there is no build
pipeline, test suite, or application. Each `.tex` file is a standalone document
(`\documentclass … \begin{document}`), compiled individually to PDF.

## Directory layout

Top-level folders are numbered so they sort in a deliberate order:

| Folder | Contents |
|--------|----------|
| `0Figure/` | Shared/reused figures referenced as `\includegraphics{0Figure/...}` (repo-root-relative) |
| `1 Aljabar/` | Algebra |
| `2 Teori Bilangan/` | Number theory |
| `3 Geometri/` | Geometry |
| `4 Kombinatorika/` | Combinatorics |
| `5 Campur/` | **Only** genuinely multi-topic material (mixed exams, cross-topic handouts) |
| `6 Test dan Simulasi/` | Dated exams, tryouts, and simulation packs |
| `7 Paket Soal dan Solusi/` | Curated problem packs with solutions (`Pembahasan`) |
| `_Template/` | Starter `.tex` templates (not referenced by other files) |

Shared LaTeX/Asymptote assets live at the **repo root** so `\usepackage{...}` and
asy `import` resolve them: `azzam.sty`, `azzam-light.sty`, `evan.sty`,
`geometry.asy`, `olympiad.asy`.

Within a topic folder, a subtopic that has a full course unit gets its own
subfolder using the graded triad below (e.g. `2 Teori Bilangan/LTE/`,
`3 Geometri/OrtikEx/`, `4 Kombinatorika/PHP-MVP/`).

## Naming conventions

Keep the **structure** consistent; the **words** may be Indonesian or English,
whichever reads naturally for the topic (e.g. `Ketaksamaan`, `Functional
Equation`, `Length Bashing`). Use **Title Case**, spaces allowed.

**Graded-unit triad** (reuse this pattern for new units):
- `<Subtopik>_Materi.tex` — material / theory
- `<Subtopik>_Latihan.tex` — practice problems
- `<Subtopik>_Ujian.tex` — exam
- `<Subtopik>_Solusi.tex` — solutions

**One-off handouts:** clean Title-Case name, no suffix (e.g. `Ceva vs Menelaus.tex`).

**Exams / simulations:** prefer `YYYY MM DD - <Deskripsi>.tex` when dated;
otherwise `<Seri> NN.tex` with **zero-padded** numbers so `01` sorts before `10`
(e.g. `Simulasi Mini KSK 07.tex`, `Paket Soal KSP 03.tex`). Answer keys:
`<Nama> - Kunci.txt`.

**Figures:** lowercase `kebab-case`, descriptive (no joke/placeholder names).
Place a figure in the **same folder** as the handout that uses it and reference it
by **bare filename** (`\includegraphics{figure.png}`) so it resolves regardless of
compile directory. Only truly shared figures go in `0Figure/` and are referenced
with the `0Figure/` prefix.

Avoid in filenames: leading lowercase, stray-spaced letters (`a l j a b a r`),
colons `:`, parentheses, and ambiguous abbreviations.

## Compiling

Each document is standalone. Custom packages (`azzam`, `evan`) must be findable —
they live at the repo root and are assumed to also be installed in the user's
local `texmf` tree (some deeply-nested handouts `\usepackage{evan}` without a local
copy). If a compile fails to find a style, either compile from the repo root or
add the root to `TEXINPUTS`.

Handouts that embed diagrams use inline Asymptote (`\begin{asy} … \end{asy}`) via
Evan Chen's `olympiad.asy` / `geometry.asy`. Compiling regenerates
`<jobname>-N.asy` / `<jobname>-N.pdf` intermediates — these are **build artifacts**,
already covered by `.gitignore`; do not commit them.

## House rules for edits

- **Never commit build artifacts** (`.aux`, `.log`, `.fls`, `.fdb_latexmk`, `.out`,
  `.pre`, generated `<job>-N.asy/.pdf`). They are gitignored.
- Use `git mv` when moving/renaming so history is preserved.
- When you move a figure or handout, **update its references**
  (`\includegraphics` / `\input` / `\usepackage`) and grep the basename to catch
  every referrer.
- Put single-topic material in folders `1–4`; reserve `5 Campur/` for content that
  genuinely spans two or more topics.
- Don't duplicate a handout across folders; keep one canonical copy.
