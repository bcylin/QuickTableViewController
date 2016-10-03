default: test
test: test-framework

bump:
ifeq (,$(strip $(version)))
	# Usage: make bump version=<number>
else
	mv QuickTableViewController.xcodeproj QuickTableViewController.tmp
	xcrun agvtool new-marketing-version $(version)
	mv QuickTableViewController.tmp QuickTableViewController.xcodeproj

	mv Example.xcodeproj Example.tmp
	xcrun agvtool new-marketing-version $(version)
	mv Example.tmp Example.xcodeproj
endif

carthage:
	set -o pipefail && carthage build --no-skip-current --verbose | xcpretty -c

coverage:
	bundle exec slather coverage -s --input-format profdata --workspace QuickTableViewController.xcworkspace --scheme QuickTableViewController-iOS QuickTableViewController.xcodeproj

test-framework:
	bundle exec scan

build-example:
	xcodebuild -workspace QuickTableViewController.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 6s,OS=latest" clean build | xcpretty -c && exit ${PIPESTATUS[0]}

docs:
	rm -rfv docs
	git clone -b gh-pages --single-branch https://github.com/bcylin/QuickTableViewController.git docs
	bundle exec jazzy --config .jazzy.yml
