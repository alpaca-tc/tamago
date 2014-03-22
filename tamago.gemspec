$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'tamago/version'

Gem::Specification.new do |s|
  s.name      = 'tamago'
  s.version   = Tamago::VERSION
  s.date      = Time.now.strftime('%Y-%m-%d')

  s.authors   = ['alpaca-tc']
  s.email     = 'alpaca-tc@alpaca.tc'
  s.homepage  = 'https://github.com/alpaca-tc/tamago'

  s.summary     = ''
  s.description = ''

  s.license     = 'MIT'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {spec}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'parallel'
  s.add_development_dependency 'comment_extractor', '~> 1.0.2'
end
