namespace :ci do
  desc "Run tests on Travis CI with a specified scheme"
  task :test, [:scheme] do |t, args|
    scheme = args[:scheme]
    unless scheme
      puts "usage: rake ci:test[scheme]"
      next
    end

    sh %(xcodebuild -workspace QuickTableViewController.xcworkspace -scheme #{scheme} -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" clean test | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end
end
