# lex-http

HTTP client extension for [LegionIO](https://github.com/LegionIO/LegionIO). Makes HTTP requests with support for JSON and XML content types via Faraday.

## Installation

```bash
gem install lex-http
```

## Functions

| Function | Parameters |
|----------|-----------|
| get | host (required), uri, port, params, body, open_timeout, timeout |
| post | host (required), uri, port, params, body, open_timeout, timeout |
| put | host (required), uri, port, params, body, open_timeout, timeout |
| patch | host (required), uri, port, params, body, open_timeout, timeout |
| delete | host (required), uri, port, params, body, open_timeout, timeout |
| options | host (required), uri, port, params, body, open_timeout, timeout |
| head | host (required), uri, port, params, body, open_timeout, timeout |

### Example Payloads

```json
{"host": "https://google.com"}
```

```json
{"host": "http://192.168.1.1", "uri": "/my_custom_api", "port": 8080, "params": {"foo": "bar"}}
```

## Requirements

- Ruby >= 3.4
- [LegionIO](https://github.com/LegionIO/LegionIO) framework

## License

MIT
