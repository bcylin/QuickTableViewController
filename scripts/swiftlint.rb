#!/usr/local/env ruby

is_ci = !!ENV["CI"]

if is_ci
  puts "Skip SwiftLint"
else
  system "./Pods/SwiftLint/swiftlint --config .swiftlint.yml"
end
