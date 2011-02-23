# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spreadsheetkit/version"

Gem::Specification.new do |s|
  s.name = "spreadsheetkit"
  s.summary = "HTML+CSS to XLS"
  s.description = "Create XLSs using HTML+CSS. The objective is the same of PDKKit, but for spreadsheets."
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = Spreadsheetkit::VERSION
  s.homepage = "http://github.com/voraz/spreadsheetkit"
end
