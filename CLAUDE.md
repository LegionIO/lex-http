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
| `lib/legion/extensions/http.rb` | Entry point, extension registration |
| `lib/legion/extensions/http/runners/http.rb` | HTTP request logic |

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` | HTTP client |
| `faraday_middleware` | HTTP middleware (response parsing, etc.) |
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
