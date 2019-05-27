#!/usr/local/env ruby

swiftlint_installed = system "which swiftlint >/dev/null"
not_ci = !ENV["TRAVIS"] || ENV["TRAVIS"]&.empty?

if not_ci and swiftlint_installed
  system "swiftlint --config .swiftlint.yml"
else
  puts "Skip SwiftLint"
end
