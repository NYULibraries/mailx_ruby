lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailx_ruby/version'

Gem::Specification.new do |s|
  s.name        = 'mailx_ruby'
  s.version     = MailxRuby::VERSION
  s.date        = '2016-05-17'
  s.summary     = "Ruby wrapper for mailx command"
  s.description = "Ruby wrapper for mailx command"
  s.authors     = ["Eric Griffis"]
  s.email       = 'eric.griffis@nyu.edu'
  s.files       = %w[lib/mailx_ruby.rb lib/mailx_ruby/version.rb lib/mailx_ruby/command_generator.rb]
  s.homepage    = 'https://github.com/NYULibraries/mailx_ruby'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'coveralls', '~> 0.8.17'
end
