# mo_material.md

Rules for writing `*_Materi.tex` training modules in this repo.
(Read together with `CLAUDE.md`.)

## 1. Every theory block gets a worked example

Each definition, fact list, or theorem must be immediately followed by at
least one worked example (`example` + `proof[Solusi]`) that uses it. No
orphan theory: a student should never finish a theorem without seeing it
in action right below. Place the example directly after the block it
illustrates, not in a single lumped section at the end.

## 2. Stack example-solution equations vertically

In Materi example solutions, derivations go **downwards**, one equation
per display line, in logical order: open with one short lead-in sentence,
then `align*` / `\[...\]` lines, then a short closing line with the
answer. Never chain a derivation inline inside a paragraph; students
find that hard to follow.

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
Hard problems belong in `_Latihan.tex` / `_Ujian.tex`, not in Materi.
