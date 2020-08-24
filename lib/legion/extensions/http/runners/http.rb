require 'faraday'
require 'faraday_middleware'

module Legion
  module Extensions
    module Http
      module Runners
        module Http
          def get(host:, uri: '', port: 80, **opts)
            conn = Faraday.new(host) do |c|
              c.options[:open_timeout] = settings[:options][:open_timeout]
              c.options[:timeout] = settings[:options][:timeout]
              c.port = port
              c.response :xml,  content_type: /\bxml$/
              c.response :json, content_type: /\bjson$/
            end

            conn.get(uri) do |req|
              req.params = opts[:params] unless opts[:params].nil?
              req.body = opts[:body] if opts.key?(:body)
            end.to_hash
          end

          def post(host:, uri: '', port: 80, **opts)
            conn = Faraday.new(host) do |c|
              c.options[:open_timeout] = settings[:options][:open_timeout]
              c.options[:timeout] = settings[:options][:timeout]
              c.port = port
              c.response :xml,  content_type: /\bxml$/
              c.response :json, content_type: /\bjson$/
            end
            conn.post(uri) do |req|
              req.params = opts[:params] unless opts[:params].nil?
              req.body = opts[:body] if opts.key?(:body)
              req.url uri
            end.to_hash
          end

          def patch(host:, uri: '', port: 80, **opts)
            conn = Faraday.new(host) do |c|
              c.options[:open_timeout] = settings[:options][:open_timeout]
              c.options[:timeout] = settings[:options][:timeout]
              c.port = port
              c.response :xml,  content_type: /\bxml$/
              c.response :json, content_type: /\bjson$/
            end

            conn.patch(uri) do |req|
              req.params = opts[:params] unless opts[:params].nil?
              req.body = opts[:body] if opts.key?(:body)
              req.url uri
            end.to_hash
          end

          def put(host:, uri: '/', port: 80, **opts)
            conn = Faraday.new(host) do |c|
              c.options[:open_timeout] = settings[:options][:open_timeout]
              c.options[:timeout] = settings[:options][:timeout]
              c.port = port
              c.response :xml,  content_type: /\bxml$/
              c.response :json, content_type: /\bjson$/
            end

            conn.put(uri) do |req|
              req.params = opts[:params] unless opts[:params].nil?
              req.body = opts[:body] if opts.key?(:body)
              req.url uri
            end.to_hash
          end

          def delete(host:, uri: '/', port: 80, **opts)
            conn = Faraday.new(host) do |c|
              c.options[:open_timeout] = settings[:options][:open_timeout]
              c.options[:timeout] = settings[:options][:timeout]
              c.port = port
              c.response :xml,  content_type: /\bxml$/
              c.response :json, content_type: /\bjson$/
            end

            conn.delete(uri) do |req|
              req.params = opts[:params] unless opts[:params].nil?
              req.body = opts[:body] if opts.key?(:body)
              req.url uri
            end.to_hash
          end

          def head(host:, uri: '/', port: 80, **opts)
            conn = Faraday.new(host) do |c|
              c.options[:open_timeout] = settings[:options][:open_timeout]
              c.options[:timeout] = settings[:options][:timeout]
              c.port = port
              c.response :xml,  content_type: /\bxml$/
              c.response :json, content_type: /\bjson$/
            end

            conn.head(uri) do |req|
              req.params = opts[:params] unless opts[:params].nil?
              req.body = opts[:body] if opts.key?(:body)
              req.url uri
            end.to_hash
          end

          def options(host:, uri: '/', port: 80, **opts)
            conn = Faraday.new(host) do |c|
              c.options[:open_timeout] = settings[:options][:open_timeout]
              c.options[:timeout] = settings[:options][:timeout]
              c.port = port
              c.response :xml,  content_type: /\bxml$/
              c.response :json, content_type: /\bjson$/
            end

            conn.options(uri) do |req|
              req.params = opts[:params] unless opts[:params].nil?
              req.body = opts[:body] if opts.key?(:body)
              req.url uri
            end.to_hash
          end

          include Legion::Extensions::Helpers::Lex
        end
      end
    end
  end
end
