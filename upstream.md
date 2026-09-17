# Upstream

This repo is a product line on top of [asterisk/asterisk](https://github.com/asterisk/asterisk).
Our SemVer (`vX.Y.Z`) is independent of the Asterisk pin in [`.version`](.version).

## Remotes

| Remote | URL |
|--------|-----|
| `origin` | `git@github.com:skyblue-one/asterisk.git` |
| `upstream` | `https://github.com/asterisk/asterisk.git` |

## Branches and tags

| Ref | Role |
|-----|------|
| Tag in `.version` | Pinned Certified Asterisk base |
| `skyblue/v1` | Product line: pin + our commits |
| `vX.Y.Z` | Our SemVer release tags |
| `probe/*` | CI throwaways; never ship |

## Pin

Current base: contents of `.version` (Certified Asterisk tag).

Start or reset a line:

```bash
git fetch upstream --tags
git checkout -B skyblue/v1 "$(cat .version)"
```

## Selective uptake

Do not merge `upstream/master` into `skyblue/v1` on a schedule.
Choose a Certified tag, then rebase our commits onto it:

```bash
git fetch upstream --tags
OLD=$(cat .version)
NEW=certified-22.8-cert5   # example: tag you chose
git checkout skyblue/v1
git rebase --onto "$NEW" "$OLD" skyblue/v1
echo "$NEW" > .version
git add .version
git commit -m "chore: move base to $NEW"
```

Single upstream commit:

```bash
git cherry-pick <upstream-sha>
```

Stay on the same Certified series until you intentionally change major line.

## Commits

Conventional Commits only. Use Commitizen:

```bash
cz commit
```

Local guard: `./scripts/setup-dev.sh` then commit-msg hook runs `cz check`.
Remote guard: workflow `ci` on PRs to `skyblue/v1`.

## SemVer and changelog

Product version lives in `.cz.toml` (`version`).
On push to `skyblue/v1`, workflow `release` runs [commitizen-action](https://github.com/commitizen-tools/commitizen-action) (`cz bump`), updates `CHANGELOG.md`, tags `v$version`, and creates a GitHub Release.

Asterisk pin stays only in `.version`.

## CI layout

| Workflow | Trigger | Role |
|----------|---------|------|
| `ci` | PR → `skyblue/v1` | Conventional commit check |
| `release` | push → `skyblue/v1` | SemVer bump + changelog + GitHub Release |
| `upstream-probe` | weekly / manual | Probe newer Certified tags; issue on failure |

Upstream Asterisk workflows stay in-tree but only run when `github.repository == 'asterisk/asterisk'`.

## Upstream probe CI

Scheduled workflow `upstream-probe` fetches newer Certified tags on the same series,
rebases onto a throwaway `probe/*` branch, and builds.
Failure opens a GitHub issue with label `upstream-probe`.
Success does not promote anything into `skyblue/v1`.

## Release rule

Probe ≠ promote. Ship only after a manual rebase (or cherry-pick), build, and SemVer bump on `skyblue/v1`.
