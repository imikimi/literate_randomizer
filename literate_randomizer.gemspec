# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'literate_randomizer/version'

Gem::Specification.new do |gem|
  gem.name          = "literate_randomizer"
  gem.version       = LiterateRandomizer::VERSION
  gem.authors       = ["Shane Brinkman-Davis"]
  gem.email         = ["shanebdavis@gmail.com"]
  gem.description   = %q{A random sentence and paragraph generator gem. Using Markov chains, this generates near-english prose.}
  gem.summary       = %q{A random sentence and paragraph generator gem. Using Markov chains, this generates near-english prose.}
  gem.homepage      = "https://github.com/Imikimi-LLC/literate_randomizer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec', '~> 2.6.0'  
end
