#!/usr/bin/env ruby

version = Legion::Extensions::Http::VERSION
name = 'http'

require "./lib/legion/extensions/#{name}/version"
puts "Building docker image for Legion v#{version}"
system("docker build --tag legionio/lex-#{name}:v#{version} .")
puts 'Pushing to hub.docker.com'
system("docker push legionio/lex-#{name}:v#{version}")
system("docker push legionio/lex-#{name}:latest")
puts 'completed'
