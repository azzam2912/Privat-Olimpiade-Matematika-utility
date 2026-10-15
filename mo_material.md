# mo_material.md

Rules for writing training material in this repo: `*_Modul.tex` units
(Materi and Soal Latihan combined in one file) first of all, plus the
prose inside `_Ujian` and `_Solusi` files. Read together with `CLAUDE.md`.
(Older units keep separate `*_Materi.tex` / `*_Latihan.tex` files; the same
rules apply to each part.)

## 0. Document format (Modul)

- Preamble: `\documentclass[12pt]{scrartcl}` with
  `\usepackage[hagavi]{azzam}`, then `\title`, `\date`, `\maketitle`.
- Environments come from `azzam.sty` (repo root, declared with
  thmtools, numbering shared): `definition`, `fact`, `theorem`,
  `lemma`, `example`, `proof[Solusi]`, plus `exercise`, `problem`,
  `claim`, `remark` when needed.
- Skeleton: short intro paragraph after `\maketitle`; `\part*{Materi}`
  with one `\section` per subtopic (inside each section, every theory
  block is immediately followed by the worked example(s) illustrating
  it); then `\part*{Soal Latihan}` with the practice problems grouped
  by `\section`; `\section{Referensi}` at the very end listing the
  source modules.

## 1. Every theory block gets a worked example

Each definition, fact list, or theorem must be immediately followed by at
least one worked example (`example` + `proof[Solusi]`) that uses it. No
orphan theory: a student should never finish a theorem without seeing it
in action right below. Place the example directly after the block it
illustrates, not in a single lumped section at the end.

## 2. Stack solution equations vertically (Materi and Solusi)

In Materi example solutions AND in every `_Solusi.tex` pembahasan,
derivations go **downwards**, one equation per display line, in logical
order: open with one short lead-in sentence, then `align*` / `\[...\]`
lines, then a short closing line with the answer. Never chain a
derivation inline inside a paragraph; students find that hard to follow.
For proof-type solutions with few equations, break the argument into
short paragraphs or steps with the key claims displayed; never leave a
solution as one dense paragraph.

Good:

```latex
\begin{proof}[Solusi]
Bagi pangkatnya:
\[ 100 = 12 \cdot 8 + 4. \]
Maka
\begin{align*}
2^{100} &= (2^{12})^8 \cdot 2^4 \\
&\equiv 1^8 \cdot 16 \\
&\equiv 3 \pmod{13}.
\end{align*}
Sisanya $3$.
\end{proof}
```

Bad (do not do this):

```latex
\begin{proof}[Solusi]
Tulis $100 = 12 \cdot 8 + 4$, sehingga
$2^{100} = (2^{12})^8 \cdot 2^4 \equiv 1^8 \cdot 16 \equiv 3 \pmod{13}$.
Sisanya adalah $3$.
\end{proof}
```

Inline math stays allowed for naming symbols or stating facts
("sisa $r$", "faktor $100$"); only multi-step derivations must stack.

## 3. Keep Materi examples illustrative

Materi examples demonstrate the theory at easy to medium difficulty.
Hard problems belong in the Latihan part / `_Ujian.tex`, not in Materi.

## 4. Geometry and pictures: always inline TikZ

- Every diagram or figure in new material must be inline TikZ code
  (`tikzpicture` environment), never an external PNG/JPG include.
  The `.tex` stays self-contained and editable.
- No extra preamble needed: `azzam.sty` already loads `pgfplots`,
  `tkz-euclide`, and the `arrows` TikZ library.
- Keep coordinates simple, label the points, and always compile to
  check the picture.
- Existing files that use Asymptote stay as they are; TikZ is the
  standard for new material.

Minimal shape:

```latex
\begin{center}
\begin{tikzpicture}[scale=1.2]
    \coordinate (A) at (0,0);
    \coordinate (B) at (3,0);
    \coordinate (C) at (1,2);
    \draw[thick] (A) -- (B) -- (C) -- cycle;
    \node[below] at (A) {$A$};
    \node[below] at (B) {$B$};
    \node[above] at (C) {$C$};
\end{tikzpicture}
\end{center}
```

## 5. Language and voice

Solutions are written in Indonesian, in the owner's own voice: direct,
concise, one idea per sentence. Define notation before using it.
Hunt down these machine-written signals in every prose passage
(the same list as in `CLAUDE.md`, it bears repeating here):

| Signal | Sounds like AI | Write this instead |
|---|---|---|
| The em dash | "...isosceles—and that is the trick." | Comma, colon, or full stop. Never the long dash. |
| Hyphenated compounds | "angle-chasing shortcut" | "angle chasing shortcut" |
| AI vocabulary | "delve into this robust approach" | Plain words for the same idea. |
| The "not X but Y" move | "Not just about angles, it is about..." | Say what it is, directly. |
| Reflexive lists of three | "sides, angles, and symmetry" | Two is enough when two is enough. |
| Hedging pile-up | "might perhaps be one possible way" | "Here is one way." |
| Uniform rhythm | Every sentence the same shape. | Vary it. Short sentence. Then a longer one. |
| "It is worth noting" | "It is worth noting that..." | "Note that..." |
| Empty summary closer | "In conclusion, we solved it." | Cut it. The proof box already says so. |

## 6. Sourcing and correctness

- Problem sources (contest, year, number) go in `%` comments only,
  never in the PDF, for the Latihan part and Ujian files. Materi
  examples may cite sources inline since they are teaching material.
- Record the answer in a `% Jawaban:` comment on every Latihan problem.
- Verify every numeric answer independently (a second hand computation
  or a brute-force script). Never trust a source answer key blindly;
  this repo has already caught wrong keys and wrong statements
  in its source files.
- Fix a wrong source statement instead of propagating it, and note the
  fix in a `%` comment. Drop a problem that is false as stated and
  report it to the owner rather than silently keeping or mangling it.

## 7. LaTeX conventions

- Display math for derivations (rule 2); inline math only for symbols
  and short references.
- Notation: `\pmod{n}` for congruences, `\mid` for divisibility,
  `FPB` / `KPK` upright, `\dots` for ellipsis.
- Keep the source ASCII: ``...'' quotes, `\dots`, `--` for ranges.
  No unicode punctuation, no emojis.
- Compile every file after writing with
  `bash 0-scripts/compile-one.sh "<filename>"` from the repo root.
  The `pdf/` output is gitignored local proof that the file builds,
  not something to commit.

## 8. Scope hygiene

- One canonical copy of each handout; never duplicate across folders.
- Single-topic material goes in folders `1`--`4`; `5 Campur/` is only
  for genuinely multi-topic content.
- When adapting from another file (e.g. outsource modules), keep what
  fits the unit's topic and level; leave the rest where it is.
