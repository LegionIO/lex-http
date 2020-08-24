require 'legion/extensions/http/version'
require 'legion/extensions'

module Legion
  module Extensions
    module Http
      extend Legion::Extensions::Core

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
