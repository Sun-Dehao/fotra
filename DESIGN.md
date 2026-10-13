# fotra — the design constitution

Anti-slop, pro-craft. Every pixel answers to these rules; the slop gate (`scripts/slop-gate.sh`) enforces the machine-checkable ones.

## Principles

1. **One orb, one thread.** A single instrument. The orb is the conversation's heartbeat — it never rotates, it breathes (pulse scale + glow), and its state is always legible: idle, listening, thinking, speaking, working, error.
2. **Hairlines, not boxes.** Separation comes from 1px rules and whitespace, never from nested cards or drop shadows. Borders are quiet; color is meaning.
3. **Green or red, nothing else.** Verdant (phosphor green) is default — green reads "alive / listening." Ember is the alternative, not a dark mode. Accent color is *data* color: it marks live things (glow, pins, receipts), never decorates.
4. **Type carries the design.** Space Grotesk display, Geist body, Geist Mono for data. Numbers are always `tabular-nums`. Labels are smallcaps-style microcopy, sentence case, low opacity — quiet until you look for them.
5. **Motion is meaning.** Motion vocabulary: fade (existence), rise (arrival), bloom (identity change), pulse (liveness). Nothing else moves. Reduced-motion removes amplitude, not information.
6. **Say it in one line.** Status is a single honest line under the orb ("steering…", "read example.com", "grounding: dropped 2 rows with no source this turn"). Never a toast, never a modal, never confetti.
7. **Screens build, they don't pop.** Typed cards assemble progressively while fotra speaks — that's the product's signature. A card that fails grounding says so in plain language and degrades, never silently drops.
8. **Honesty over polish.** The capability matrix names what doesn't work. Missing keys get named-variable errors. v2 seams are labeled as seams.
9. **Asymmetry is a feature.** The workbench is 60/40 — transcript left, orb stage right — collapsing to one column on mobile with the orb docking into the composer.
10. **44px targets, AA contrast, both themes.** Focus rings never animate in. Every orb state has an aria-label ("Fotra is listening…").

## Machine-checked rules (slop gate)

- No emoji in `src/` — one-emoji-max is a *persona* rule for fotra's speech, and even that lives in PERSONA.md, not the UI.
- No `#hex` colors in components — tokens only (`bg-paper`, `text-ink`, `border-rule`, `text-glow`, `text-danger`…).
- No `linear-gradient(` in components — the orb's depth is a radial highlight in globals.css, the only place gradients live.
- Banned copy: "Certainly!", "I'd be happy to", "Oops", "Something went wrong", exclamation-stacked error strings.
- `console.log` is forbidden in components; telemetry lines are real values only (latency in ms, turns, notes).

## Token quick-reference

Defined in `globals.css` as CSS variables per `[data-theme]`; mapped into Tailwind via `@theme inline`.

| Token | Meaning |
|---|---|
| `paper / paper-2 / paper-3` | page / raised / hover surfaces |
| `ink / ink-2 / dim` | primary / secondary / tertiary text |
| `rule` | hairline borders |
| `glow` | the live accent (green in verdant, red-family in ember) |
| `danger` | destructive / warn |

## The face (v5 — the mascot revamp)

The orb grew a face. Four of them, one persona: **dot** (the plush one, OpenDots' favicon geometry), **blob** (Muse's soft framing — squat, tiny ears, calm eyes, boxy snout), **π** (oh-my-pi's OmpMark path + their magenta→iris→cyan stops, verbatim), **bot** (a quiet slab with an accent-tipped antenna).

- **The mascot is the orb.** The button keeps its semantics (talk / interrupt / dismiss); the character carries the state. The mic affordance is a corner chip, never over the face.
- **State-as-CSS-class** (OpenDots' pattern): `.f-mascot[data-state]` drives motion in globals.css — `f-m-bob` (working, 2s/−5px, their constant), `f-m-listen`/`f-m-speak` (amplitude-reactive via `--mic-level`/`--spk-level`), blink every 5.4s, eyes drift up while thinking, mouth opens while speaking, shake+desaturate on error.
- **Stable identity** (their `characterFor`, hash×31 %4): the coat color derives from the persona *name*. Rename the agent and it re-marks itself. Coat 0 follows the locked theme (verdant green / ember red); coats 1–3 are fixed (sky, gold, orchid).
- **Geometry in `Mascot.tsx`, all raw colors in `globals.css`** — the constitution holds: no hex in components, gradients only in globals.
- **The working row** (omp's working-row steal): live dot · mm:ss elapsed · shimmering intent (statusLine) · stop — under the mascot while it works.
- **Every surface wears the face**: stage orb, header persona chip, thread avatars, empty state, settings previews, the composer's compact circle (where the whole mascot is the affordance — mic chip hidden at 44px).
- **Reduced motion kills every mascot animation** (the a11y contract from day one, extended).

## v5 — show what is happening, then get out of the way

The stage-and-rails cockpit is retired. Principles 1, 3 and 9 above are superseded by these:

1. **One column.** Idle is the mascot, a line and the composer. Talking is the thread and the composer. Nothing else is on screen unless the moment calls for it; the library (threads, files, routines, tools, memory) and settings are one button or `⌘K` away.
2. **Work is shown live, then folded.** Every tool call is a step in the thread at the point it happened. While it runs its surface is live (the search types, sources fly in, code prints); a beat after it lands the group folds to one line that reopens to everything. Screens are for results the user asked for — never for narrating a tool.
3. **The browser is a window, not a screenshot.** Computer use pops up beside the thread with a cursor that wears the agent's name; it tucks away when the work is done. It never covers the thread on a wide screen — the column makes room.
4. **A tapback can be the whole reply.** When a message needs no words back, the agent reacts and says nothing. No bubble is rendered for it.
5. **Changes to itself are visible and reversible.** A self-edit shows exactly what changed (from → to, instruction added or dropped) with an undo that always works.
6. **The coat is the theme** (six of them, night or day) — "green or red, nothing else" no longer holds.

Machine-checked rule, amended: **no emoji in `src/` except as escaped code points in `src/lib/fotra/reactions.ts`** — reactions are data, never decoration. The gate greps for literal emoji, so the escapes pass and a stray emoji in a component still fails.
