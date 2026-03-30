# frozen_string_literal: true

require 'legion/extensions/http/version'
require 'legion/extensions/http/helpers/client'
require 'legion/extensions/http/runners/http'
require 'legion/extensions/http/client'

module Legion
  module Extensions
    module Http
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core, false

      def self.default_settings
        {
          options: {
            open_timeout: 5,
            read_timeout: 10,
            timeout:      10
          }
        }
      end
    end
  end
end
