lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailx_ruby/version'

Gem::Specification.new do |s|
  s.name        = 'mailx_ruby'
  s.version     = MailxRuby::VERSION
  s.date        = '2017-02-27'
  s.summary     = "Ruby wrapper for mailx command"
  s.description = "Ruby wrapper for mailx command"
  s.authors     = ["Eric Griffis"]
  s.email       = 'eric.griffis@nyu.edu'
  s.files       = %w[lib/mailx_ruby.rb lib/mailx_ruby/body.rb lib/mailx_ruby/version.rb lib/mailx_ruby/command_generator.rb]
  s.test_files  = %w[spec/lib/mailx_ruby_spec.rb spec/lib/mailx_ruby/body_spec.rb spec/lib/mailx_ruby/command_generator_spec.rb spec/lib/mailx_ruby/version_spec.rb]
  s.homepage    = 'https://github.com/NYULibraries/mailx_ruby'
  s.license     = 'MIT'

  s.add_dependency 'premailer', '>= 1.8'
  s.add_dependency 'nokogiri', '>= 1.7'

  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'coveralls', '~> 0.8.17'
end
