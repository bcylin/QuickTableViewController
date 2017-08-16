require "fileutils"

namespace :ci do
  desc "Run tests with a specified scheme"
  task :test, [:scheme] do |t, args|
    scheme = args[:scheme]
    unless scheme
      puts "Usage: rake ci:test[scheme]"
      next
    end

    sh [
      %(xcodebuild),
      %(-workspace QuickTableViewController.xcworkspace),
      %(-scheme #{scheme}),
      %(-sdk iphonesimulator),
      %(-destination "name=iPhone 7,OS=latest"),
      %(clean test | xcpretty -c && exit ${PIPESTATUS[0]})
    ].join " "
    exit $?.exitstatus if not $?.success?
  end

  desc "Build a target of specified scheme"
  task :build, [:scheme] do |t, args|
    scheme = args[:scheme]
    unless scheme
      puts "usage: rake ci:build[scheme]"
      next
    end

    sh [
      %(xcodebuild -workspace),
      %(QuickTableViewController.xcworkspace),
      %(-scheme #{scheme}),
      %(-sdk iphonesimulator),
      %(-destination "name=iPhone 7,OS=latest"),
      %(clean build | xcpretty -c && exit ${PIPESTATUS[0]})
    ].join " "
    exit $?.exitstatus if not $?.success?
  end
end


desc "Bump versions"
task :bump, [:version] do |t, args|
  version = args[:version]
  unless version
    puts "Usage: rake bump[version]"
    next
  end

  sh %(xcrun agvtool new-marketing-version #{version})

  podspec = "QuickTableViewController.podspec"
  text = File.read podspec
  File.write podspec, text.gsub(%r(\"\d+\.\d+\.\d+\"), "\"#{version}\"")
  puts "Updated #{podspec} to #{version}"

  jazzy = ".jazzy.yml"
  text = File.read jazzy
  File.write jazzy, text.gsub(%r(:\s\d+\.\d+\.\d+), ": #{version}")
  puts "Updated #{jazzy} to #{version}"
end
