# -*- encoding: utf-8 -*-
require File.expand_path('../lib/git_feed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alon Becker"]
  gem.email         = ["alon@alonbecker.com"]
  gem.description   = %q{Feeds git commit information to Redis}
  gem.summary       = %q{Feeds git commit information to Redis}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "git_feed"
  gem.require_paths = ["lib"]
  gem.version       = GitFeed::VERSION
  gem.add_development_dependency "redis"
  gem.add_development_dependency "git"
  gem.add_development_dependency "json"
  gem.add_development_dependency "yaml"
end
