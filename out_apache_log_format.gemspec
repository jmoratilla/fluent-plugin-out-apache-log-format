# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'out_apache_log_format/version'

Gem::Specification.new do |spec|
  spec.name          = "out_apache_log_format"
  spec.version       = '0.0.2'
  spec.authors       = ["jorge moratilla"]
  spec.email         = ["jorge.moratilla@kelisto.es"]
  spec.summary       = %q{This output filter generates Combined Common Log Format entries}
  spec.description   = %q{This output filter generates Combined Common Log Format entries}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "fluentd"

end
