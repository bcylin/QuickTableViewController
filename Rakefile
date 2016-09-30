namespace :ci do
  desc "Run tests with a specified scheme"
  task :test, [:scheme] do |t, args|
    scheme = args[:scheme]
    unless scheme
      puts "usage: rake ci:test[scheme]"
      next
    end

    sh %(xcodebuild -workspace QuickTableViewController.xcworkspace -scheme #{scheme} -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" clean test | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end

  desc "Build a target of specified scheme"
  task :build, [:scheme] do |t, args|
    scheme = args[:scheme]
    unless scheme
      puts "usage: rake ci:build[scheme]"
      next
    end

    sh %(xcodebuild -workspace QuickTableViewController.xcworkspace -scheme #{scheme} -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" clean build | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end
end
