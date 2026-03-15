# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Http
      module Helpers
        module Client
          def connection(host:, port: 80, **opts)
            Faraday.new("#{host}:#{port}") do |conn|
              conn.options.open_timeout = opts.fetch(:open_timeout, 5)
              conn.options.read_timeout = opts.fetch(:read_timeout, 10)
              conn.options.timeout      = opts.fetch(:timeout, 10)
              conn.response :json, content_type: /\bjson$/
              conn.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
