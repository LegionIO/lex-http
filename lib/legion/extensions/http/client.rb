# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/http'

module Legion
  module Extensions
    module Http
      class Client
        include Helpers::Client
        include Runners::Http

        attr_reader :opts

        def initialize(open_timeout: 5, read_timeout: 10, timeout: 10, port: 80, **extra)
          @opts = { open_timeout: open_timeout, read_timeout: read_timeout, timeout: timeout, port: port, **extra }
        end

        def connection(**override)
          super(**@opts.merge(override))
        end

        def settings
          { options: @opts }
        end
      end
    end
  end
end
