# Maintainer SOP

Using RFC 2119 keywords for requirements to avoid ambiguity.

PR - Pull Request

FixPR - A bugfix/spellcheck/qol/internal PR.

TM - Test Merge

DB - Database

## TMs and Merges

- A single maintainer is enough for approval and merging/TMing a PR. They may request more reviews if they deem it necessary.
- With the exception of FixPRs, TMs and Merges must be approved by someone other than the person who created the PR.
- Any PR that isn't a FixPR must not be merged before at least 24 hours have passed since the last major adjustment was made to its player facing features. This is to allow time for secondary reviews and feedback.

## Upstreams

- The playerbase must be informed ahead of time that an upstream will be TMd.
- Backups of player and DB data must be made before each upstream
- An upstream should be TMd first in order to squash all the fixes for it in a single commit under the upstream, and to not bog down our contributors with a buggy mess.
- An upstream must not be squash merged.

## Reviewing PRs

- Reviews should be clear and concise, explaining issues with the changes. Rewiews are not required to provide direct solutions.
- A maintainer may ask the contributor for clarification of their changes

## Closing PRs

- The below doesn't apply for feature freezes and clearly spam/abuse PRs
- A PR may be closed for any reason, but must not be closed before at least 24 hours have passed since it was put up
- A maintainer must provide a reasoning for the closure of a PR
