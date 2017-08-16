default: test

test:
	bundle exec rake 'ci:test[QuickTableViewController-iOS]'
	bundle exec rake 'ci:test[Example]'
	make -B carthage
	make -B docs

bump:
ifeq (,$(strip $(version)))
	# Usage: make bump version=<number>
else
	ruby -pi -e "gsub(/\d+\.\d+\.\d+/i, \""$(version)"\")" QuickTableViewController.podspec
	ruby -pi -e "gsub(/:\s\d+\.\d+\.\d+/i, \": "$(version)"\")" .jazzy.yml
	xcrun agvtool new-marketing-version $(version)
endif

carthage:
	set -o pipefail && carthage build --no-skip-current --verbose | bundle exec xcpretty -c

coverage:
	bundle exec slather coverage -s --input-format profdata --workspace QuickTableViewController.xcworkspace --scheme QuickTableViewController-iOS QuickTableViewController.xcodeproj

test-framework:
	bundle exec fastlane scan

build-example:
	xcodebuild -workspace QuickTableViewController.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 6s,OS=latest" clean build | xcpretty -c && exit ${PIPESTATUS[0]}

docs:
	test -d docs || git clone -b gh-pages --single-branch https://github.com/bcylin/QuickTableViewController.git docs
	cd docs && git fetch origin gh-pages && git clean -f -d
	cd docs && git checkout gh-pages && git reset --hard origin/gh-pages
	bundle exec jazzy --config .jazzy.yml

	for file in "html" "css" "js" "json"; do \
		echo "Cleaning whitespace in *."$$file ; \
		find docs/output -name "*."$$file -exec sed -E -i '' -e 's/[[:blank:]]*$///' {} \; ; \
	done

	cp -rfv docs/output/* docs
	cd docs && \
	git add . && \
	git diff-index --quiet HEAD || \
	git commit -m "[CI] Update documentation at $(shell date +'%Y-%m-%d %H:%M:%S %z')"

update-docs:
	make -B docs
	cd docs && git push origin HEAD:gh-pages
