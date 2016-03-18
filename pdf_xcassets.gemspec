# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdf_xcassets/version'

Gem::Specification.new do |spec|
  spec.name          = PdfXcassets::PROJECT_NAME
  spec.version       = PdfXcassets::VERSION
  spec.authors       = ["dkhamsing"]
  spec.email         = ["dkhamsing8@gmail.com"]

  spec.summary       = PdfXcassets::PROJECT_DESCRIPTION
  spec.description   = spec.summary
  spec.homepage      = PdfXcassets::PROJECT_URL
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = [spec.name]
  spec.require_paths = ['lib']
end
