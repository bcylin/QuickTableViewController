default: test

carthage-update:
	carthage update --no-use-binaries --platform ios

coverage:
	bundle exec slather coverage -s --input-format profdata --workspace QuickTableViewController.xcworkspace --scheme QuickTableViewController-iOS QuickTableViewController.xcodeproj

test:
	xcodebuild -project QuickTableViewController.xcodeproj -scheme QuickTableViewController-iOS -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" -enableCodeCoverage YES clean test GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty -c
