# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trust_pay_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "trust_pay_rails"
  spec.version       = TrustPayRails::VERSION
  spec.authors       = ["Michal Olah"]
  spec.email         = ["olahmichal@gmail.com"]

  spec.summary       = %q{A Ruby client to the TrustPay payment platform.}
  spec.homepage      = "https://github.com/Learn2Codesk/trust_pay_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rails"

  spec.add_dependency 'activesupport'
end
