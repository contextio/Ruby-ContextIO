# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'context_io/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '~> 2.0'

  spec.name          = "context_io"
  spec.version       = ContextIO::VERSION
  spec.authors       = ["Dane Carmichael"]
  spec.email         = ["carmichaeldane@gmail.com"]

  spec.summary       = "Provides a Ruby interface to the Context.IO API"
  spec.description   = "Provides a Ruby interface to the Context.IO API"
  spec.license       = "Apache 2.0"
  spec.homepage      = "https://github.com/contextio/Ruby-ContextIO"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"

  spec.add_dependency "faraday", "~> 0.12"
  spec.add_dependency "faraday_middleware", "~> 0.11"
  spec.add_dependency "simple_oauth", "~> 0.3.1"
end
