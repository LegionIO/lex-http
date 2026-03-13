# lex-http: HTTP Client Extension for LegionIO

**Repository Level 3 Documentation**
- **Category**: `/Users/miverso2/rubymine/legion/extensions/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to any HTTP source. Provides runners for making HTTP requests with support for multiple content types (JSON, XML) via Faraday.

**GitHub**: https://github.com/LegionIO/lex-http
**License**: MIT

## Architecture

```
Legion::Extensions::Http
└── Runners/
    └── Http               # HTTP request execution (GET, POST, etc.)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/http.rb` | Entry point, extension registration, `default_settings` |
| `lib/legion/extensions/http/runners/http.rb` | HTTP request logic (all verbs) |

## Runner Methods

All methods are in `Runners::Http` and accept `host:` (required), `uri:`, `port:`, `params:`, `body:` as keyword args. Timeouts are read from `settings[:options]` populated by `default_settings`.

| Method | Notes |
|--------|-------|
| `get` | |
| `post` | |
| `put` | |
| `patch` | |
| `delete` | |
| `head` | |
| `options` | |
| `status` | Smoke-test; returns `{ test: true }` |

Response parsing is automatic: JSON content types parse to Hash, XML content types parse to Hash via `multi_xml`. Return value is the Faraday response as a hash (`response.to_hash`).

## Notes

- `default_settings` defines `open_timeout: 5`, `read_timeout: 10`, `timeout: 10`
- There is no standalone `Client` class — this extension is framework-only (runners read `settings` directly)
- `faraday_middleware` is NOT a declared dependency; response parsing is handled by Faraday's built-in middleware (`c.response :json` / `c.response :xml`)

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` | HTTP client (includes built-in JSON/XML response middleware) |
| `multi_json` | JSON parser abstraction |
| `multi_xml` | XML parser abstraction |

## Testing

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
