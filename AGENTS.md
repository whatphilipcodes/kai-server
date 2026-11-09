# Personal instructions

## Code comments

- Never add comments to code I write. No line comments, no docstrings, no JSDoc on
  newly introduced functions, no TODO markers, no section banners, no explanatory
  blocks in generated files. Let names and structure carry intent. If something
  genuinely needs explaining, explain it in my reply instead of in the file.
- Comments that are already in the codebase belong to the user. Preserve them
  verbatim when modifying a file: do not delete, reword, reformat, or "clean up"
  an existing comment as a side effect of an edit, including when moving the code
  it describes.
- If an edit would strand a comment (the code it explained is gone) or make it
  factually wrong, leave it and flag it. Removing it requires the user's call.
- The only exception is an explicit request for comments in a specific file or task.

## README files

- Reading README files to understand a codebase is fine, but never add content to
  a README unless the user *explicitly* asks for it.

## Code organization

- Keep code lean: the fewest lines that stay readable, using the idioms and best
  practices of the language and framework in use. Prefer deleting or reducing
  structure (wrappers, indirection, flags that only move a value) over adding it.
- Prefer many small, focused files over a few large ones, but concepts that
  belong together stay together. A file reads as one coherent idea; splitting for
  line count alone, which scatters a single concept across files, is wrong.
- DRY: duplicated logic belongs in one function, component, or helper. Extract it
  when the second copy appears, not after the fifth. Before writing new logic,
  check whether this repo, a dependency, or the standard library already does it.
- SOC: one reason to change per file or function. Keep presentation, state, data
  access and side effects in their own layers; don't reach across a boundary for
  convenience, and don't let callers know a layer's internals.

## Task tracking

- For any turn with 3+ steps or a list of asks from me, keep an explicit task list
  using whatever task-tracking mechanism the environment provides. If there is
  none, keep a visible checklist in the reply. Skip tracking for single-step and
  conversational work. An untracked list is worse than none.
- Mark a task in progress before starting it and completed the moment it is
  done, mid-turn. Never batch completions at the end, and never have two tasks in
  progress at once.
- Before ending a turn that used a task list, re-read its current state and
  reconcile every entry against what actually happened. Finished work is marked
  completed; work abandoned, superseded or no longer worth doing is removed; work
  that genuinely remains stays pending or in progress. Do not end the turn on
  memory of the list.
- A blocked or failing task stays open and gets a new task describing the
  blocker; never mark it completed to make the list look tidy.
- If the list no longer matches the real shape of the work, restructure it right
  away rather than silently working off-plan.
- Anything still open when the turn ends goes in my reply, not just in the list:
  say what is unfinished and why.

## Commits

- If the turn edited files, end it with one local commit using the pattern below.
  Don't ask first and don't leave the work dangling; skip it only when nothing
  changed, there's no repo, or I say not to.
- Stage exactly the paths you touched, never everything at once. Other dirty files
  in the tree are mine to deal with, not yours.
- Message shape: Conventional Commits subject, a blank line, then the generation
  signature. Nothing else: no prose body, no addendum.

  ```
  <type>(<scope optional>): <cmt msg>

  gen: <harness-slug>:<model-slug>
  ```

- `<type>` is one of `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`,
  `refactor`, `revert`, `style`, `test`, lowercase. `<scope>` is the area touched;
  drop the parentheses when nothing fits.
- `<cmt msg>` is 1-5 keywords: imperative, no sentence, no trailing period, keep the
  whole subject short. If it needs more, the commit is doing too much, so split it.
- The signature identifies what actually produced the change. `<harness-slug>` is the
  agent harness or client running this session; `<model-slug>` is the model
  running it. Take both from what this session itself reports about its own
  environment and identity. Never copy a name from a prompt, a doc, a config file
  or an earlier commit, and never guess.
- A slug is `[a-zA-Z0-9-]` only: dots, colons, `+`, `*`, `#`, `_`, `/`, spaces and any
  other character each collapse to a single `-`, never leading or trailing.
- If either value cannot be determined with certainty, write `unknown` in its
  place and tell me in the reply instead of filling in a guess.
- Pull from a remote when you need to; push never. No push in any form, no
  upstream tracking, no force-push, and nothing that publishes commits (PRs, push
  to review). If the work seems to need a push, stop and ask me.