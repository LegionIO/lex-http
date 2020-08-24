# Legion::Extensions::Http

A Legion Extension designed to make HTTP requests

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lex-http'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lex-http

## Adding to Legion
You can manually install with a `gem install lex-http` command or by adding it into your settings with something like this
```json
{
  "extensions": {
    "http": {
      "enabled": true, "workers": 1
    }
  }
}
```

## Usage

There is only a single runner in this LEX. It can make the following calls 
##### Functions
|function|open_timeout|timeout|Port|Params|Body|Host|URI|
|---|---|---|---|---|---|---|---|
|get    |Optional|Optional|80|Optional|Optional|Required|\|
|post   |Optional|Optional|80|Optional|Optional|Required|\|
|patch  |Optional|Optional|80|Optional|Optional|Required|\|
|put    |Optional|Optional|80|Optional|Optional|Required|\|
|delete |Optional|Optional|80|Optional|Optional|Required|\|
|options|Optional|Optional|80|Optional|Optional|Required|\|
|head   |Optional|Optional|80|Optional|Optional|Required|\|

#### Example Payloads
```json
{"host": "https://google.com"}
```

```json
{"host": "https://google.com", "uri": "/", "port": 443}
```

```json
{"host": "http://192.168.1.1", "uri": "/my_custom_api", "port": 8080, "params": {"foo": "bar"} }
```

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://bitbucket.org/legion-io/lex-http.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

