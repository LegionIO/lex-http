require_relative 'lib/legion/extensions/http/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-http'
  spec.version       = Legion::Extensions::Http::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX HTTP'
  spec.description   = 'Connections LegionIO to any HTTP source'
  spec.homepage      = 'https://github.com/LegionIO/lex-http'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/LegionIO/lex-http'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-http'
  spec.metadata['changelog_uri'] = 'https://github.com/LegionIO/lex-http'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/LegionIO/lex-http/issues'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'multi_json'
  spec.add_dependency 'multi_xml'
end
