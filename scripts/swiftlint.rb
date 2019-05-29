#!/usr/local/env ruby

not_ci = !ENV["TRAVIS"] || ENV["TRAVIS"]&.empty?

if not_ci
  system "${PODS_ROOT}/SwiftLint/swiftlint --config .swiftlint.yml"
else
  puts "Skip SwiftLint"
end
