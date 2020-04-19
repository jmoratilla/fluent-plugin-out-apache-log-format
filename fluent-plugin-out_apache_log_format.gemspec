# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-out_apache_log_format"
  spec.version       = '0.0.7'
  spec.authors       = ["jorge moratilla"]
  spec.email         = ["jorge@moratilla.com"]
  spec.summary       = %q{This output filter generates Combined Common Log Format entries}
  spec.description   = %q{This output filter generates Combined Common Log Format entries}
  spec.homepage      = "https://bitbucket.org/jmoratilla/fluent-plugin-out_apache_log_format"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_dependency "fluentd"

end
