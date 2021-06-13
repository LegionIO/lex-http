require 'legion/extensions/http/version'

module Legion
  module Extensions
    module Http
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core

      def self.default_settings
        {
          options: {
            open_timeout: 5,
            read_timeout: 10,
            timeout: 10
          }
        }
      end
    end
  end
end
