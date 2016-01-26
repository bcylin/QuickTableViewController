task default: :coverage

desc "Run tests"
task :test do
  sh %(xcodebuild -project QuickTableViewController.xcodeproj -scheme QuickTableViewController-iOS -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" -enableCodeCoverage YES clean test GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty -c)
end

desc "Collect coverage"
task :coverage do
  sh %(bundle exec slather coverage -s --input-format profdata --scheme QuickTableViewController-iOS QuickTableViewController.xcodeproj)
end
