# Changelog

## [0.2.3] - 2026-03-30

### Changed
- update to rubocop-legion 0.1.7, resolve all offenses
- remove Faraday XML middleware (removed in Faraday >= 2.0)

## [0.2.2] - 2026-03-22

### Changed
- Add runtime dependencies on all 7 legion sub-gems (legion-cache, legion-crypt, legion-data,
  legion-json, legion-logging, legion-settings, legion-transport) to gemspec
- Replace Helpers::Lex stub in spec_helper with real sub-gem helper version (all 7 includes);
  add actor stubs for Every and Once

## [0.2.1] - 2026-03-18

### Changed
- deleted gemfile.lock

## [0.2.0] - 2026-03-15

### Added
- `Helpers::Client` module for building Faraday connections with configurable timeouts
- Standalone `Client` class including all runner modules
- `Client#initialize` accepts `open_timeout:`, `read_timeout:`, `timeout:`, `port:` stored as defaults
- `Client#settings` exposes stored options for runner compatibility without the full framework
- Specs for `Client`: initialize defaults, custom options, `#connection`, `#settings`, runner method availability

### Changed
- `lib/legion/extensions/http.rb` now requires `helpers/client`, `runners/http`, and `client`

## [0.1.3] - 2026-03-13

### Added
- Initial release
