# frozen_string_literal: true

require_relative "lib/khl/version"

Gem::Specification.new do |spec|
  spec.name = "KHL"
  spec.version = KHL::VERSION
  spec.summary = "Ruby SDK for 开黑啦"
  spec.description = "Ruby SDK for 开黑啦"
  spec.homepage = "https://github.com/DessertShop/KHL"

  spec.authors = ["Dounx"]
  spec.email = ["imdounx@gmail.com"]

  spec.license = "MIT"

  spec.required_ruby_version = ">= 2.7.0"
  spec.require_paths = ["lib"]
  spec.files = Dir["CHANGELOG.md", "LICENSE", "README.md", "lib/**/*"]

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "documentation_uri" => "#{spec.homepage}/blob/master/README.md",
    "source_code_uri" => spec.homepage
  }

  spec.add_dependency "activesupport", "~> 7.0", ">= 7.0.2.3"
  spec.add_dependency "faye-websocket", "~> 0.11.1"
end
