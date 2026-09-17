# Changelog

All notable changes to Skyblue Asterisk are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/).
Versioning follows [SemVer](https://semver.org/). Upstream Asterisk pin: [`.version`](.version).

## [1.0.0] — 2026-09-17

### Added

- Product line on Certified Asterisk `certified-22.8-cert4`
- Upstream policy, conventional commits, SemVer bump CI

## v1.0.3 (2026-09-17)

### Fix

- push annotated SemVer tags from release CI

## v1.0.2 (2026-09-17)

### Fix

- ignore upstream tags in commitizen

## v1.0.1 (2026-09-17)

### Fix

- ignore no-op cz bump exit in release CI

## v1.0.0 (2026-09-17)

### Feat

- ARI "ChannelToneDetected" event
- AudioSocket channel, application, and ARI support.

### Fix

- Correct default flag for tcp_keepalive_enable option
- memory leaks, resource leaks, out of bounds and bugs
