# -*- encoding: utf-8 -*-
require File.expand_path('../lib/super_zombies_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ecavazos"]
  gem.email         = ["ejcavazos@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "super_zombies_api"
  gem.require_paths = ["lib"]
  gem.version       = SuperZombiesApi::VERSION

  gem.add_dependency 'rest-client', '>= 0'
  gem.add_dependency 'yajl-ruby', '>= 0'

  gem.add_development_dependency 'rspec', '~> 2.9.0'
  gem.add_development_dependency 'webmock', '>= 0'
  gem.add_development_dependency 'vcr', '>= 0'
end
