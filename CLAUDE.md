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

## Finishing a task: always commit and push

**Standing instruction from the owner — no need to ask each time.** When you finish a piece of work in this repo, commit it and push to `master`:

```bash
git add -A && git commit -m "<what changed>" && git push origin master
```

- Commit **directly to `master`**; do not create a branch or open a PR. This is a single-author materials repo synced with Overleaf, and a branch just strands the files.
- Do this at the end of the task, once the `.tex` compiles — not after every intermediate edit.
- `git add -A` is intended: PDFs and build artifacts are already gitignored, so it picks up sources only. Still, glance at `git status` first — if it sweeps in unrelated half-finished edits the owner was working on, commit only your own paths instead and say so.
- If the push is rejected because `origin/master` moved (an Overleaf sync), `git pull --rebase origin master` and push again. Report a genuine conflict rather than resolving it blind.
- The one thing to ask about first: deleting or moving files the owner did not ask you to touch.

## Output rules

- Output the complete `.tex` file, ready to compile.
- **Always compile it afterwards** with `./0-scripts/compile-one.sh "<filename>"` from the repo root, leaving the PDF in the `pdf/` subfolder next to the `.tex`. Saving the `.tex` without its PDF is an unfinished job. See "Building Documents" in `CLAUDE.md`.

### Live preview inside VS Code

`.vscode/settings.json` (checked in) already configures the **LaTeX Workshop** extension for this repo. It is not a WYSIWYG renderer — it just automates a real compile: on save it runs `pdflatex` (twice, so cross-references settle) from the **workspace root** rather than the file's own folder, because relative asset paths (a shared style file, a shared image folder) only resolve from there; output goes into a `pdf/` subfolder next to the source, nonstopmode so a broken figure/citation doesn't block the build, and it cleans up build artifacts after each build. Open a `.tex` file and press **⌘⌥V** (or the TeX sidebar → *View LaTeX PDF → in a tab*) to open the built-in PDF.js viewer tab; it rebuilds on every ⌘S. SyncTeX is on, so ⌘-click in the PDF jumps to the source line and ⌘⌥J goes the other way.

Do not change the recipe to a plain `pdflatex %DOC%` — LaTeX Workshop would then run it from the file's own folder, where shared assets (style files, image folders) resolving via relative paths from the repo root would not be found. Do not add `-halt-on-error` either, for the same reason the compile scripts avoid it: a single broken problem/figure would otherwise block the whole PDF instead of just leaving a gap.
