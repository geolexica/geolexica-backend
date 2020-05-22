# (c) Copyright 2020 Ribose Inc.
#

require_relative "lib/jekyll/geolexica/version"

all_files_in_git = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

ribose_url = "https://open.ribose.com/"
github_url = "https://github.com/geolexica/geolexica-server"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-geolexica"
  spec.version       = Jekyll::Geolexica::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]

  spec.summary       = "Geolexica plugin for Jekyll"
  spec.homepage      = ribose_url
  spec.license       = "MIT"

  spec.metadata      = {
    "bug_tracker_uri"   => (github_url + "/issues"),
    "homepage_uri"      => ribose_url,
    "source_code_uri"   => github_url,
  }

  spec.files         = all_files_in_git.reject do |f|
    [
      f.match(%r{^(test|spec|features|.github)/}),
      f.match(%r{^\.}),
    ].any?
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jekyll", ">= 3.8.5", "< 4.1"
  spec.add_runtime_dependency "jekyll-asciidoc"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", ">= 10"
  spec.add_development_dependency "rspec", "~> 3.9"
end
