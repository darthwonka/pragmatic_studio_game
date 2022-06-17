# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'studio_game'
  s.version      = '0.86'
  s.author       = 'Michael Belanger'
  s.email        = 'Michael@salusitgroup.com'
  s.homepage     = 'https://www.salusitgroup.com'
  s.summary      = 'Game to demonstrate basic Ruby Programming Concepts'
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir['{bin,lib,spec}/**/*'] + %w[LICENSE README]
  s.test_files    = Dir['spec/**/*']
  s.executables   = ['studio_game']

  s.required_ruby_version = '>=2.5'
  s.add_development_dependency 'rspec', '~> 2.8', '>= 2.8.0'
end
