
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nyc_subway_status/version"

Gem::Specification.new do |spec|
  spec.name          = "nyc_subway_status"
  spec.version       = NycSubwayStatus::VERSION
  spec.authors       = ["Chrissy Gonzalez"]
  spec.email         = ["chrissygonzalez@gmail.com"]

  spec.summary       = "A command line interface for checking alert.mta.info"
  spec.description   = "I built this gem for the Learn.co CLI gem project. Install and enter 'nyc-subway-status' to run."
  spec.homepage      = "https://github.com/chrissygonzalez/nyc-subway-status"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["nyc-subway-status"]
  # spec.executables   = [spec.files.grep(%r{^exe/}) { |f| File.basename(f) }]
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.8"
  spec.add_dependency "watir", "~> 6.10"
  spec.add_dependency "webdrivers", "~>3.2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
