# lex-http

HTTP client extension for [LegionIO](https://github.com/LegionIO/LegionIO). Makes HTTP requests with support for JSON and XML content types via Faraday. Responses are automatically parsed based on the `Content-Type` header.

## Installation

```bash
gem install lex-http
```

## Functions

All functions are in the `Http` runner and accept the following parameters:

| Function | Required | Optional |
|----------|----------|---------|
| `get` | `host` | `uri`, `port`, `params`, `body` |
| `post` | `host` | `uri`, `port`, `params`, `body` |
| `put` | `host` | `uri`, `port`, `params`, `body` |
| `patch` | `host` | `uri`, `port`, `params`, `body` |
| `delete` | `host` | `uri`, `port`, `params`, `body` |
| `head` | `host` | `uri`, `port`, `params`, `body` |
| `options` | `host` | `uri`, `port`, `params`, `body` |
| `status` | (none) | - |

**Parameters:**
- `host` - Full base URL (e.g. `https://api.example.com`)
- `uri` - Path component (default: `''`)
- `port` - Override port (default: `80`)
- `params` - Query string parameters as a hash
- `body` - Request body

**Default timeouts** (configured via `default_settings`):
- `open_timeout`: 5 seconds
- `read_timeout`: 10 seconds
- `timeout`: 10 seconds

### Example Task Payloads

```json
{"host": "https://api.example.com"}
```

```json
{"host": "http://192.168.1.1", "uri": "/api/v1/status", "port": 8080, "params": {"format": "json"}}
```

```json
{"host": "https://api.example.com", "uri": "/users", "body": {"name": "Alice"}}
```

## Requirements

- Ruby >= 3.4
- [LegionIO](https://github.com/LegionIO/LegionIO) framework

## License

MIT
