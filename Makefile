default: test

test: unit-test ui-test

unit-test:
	bundle exec fastlane ios unit_tests
	bundle exec fastlane tvos unit_tests

ui-test:
	bundle exec fastlane ios ui_tests
	bundle exec fastlane tvos ui_tests

ci-test: unit-test ui-test
	make -B carthage
	make -B docs

swift-package-project:
	rm -rf Package/Package.xcproj
	mint run yonaskolb/XcodeGen xcodegen generate --project Package --spec Package/Package.yml
	open Package/Package.xcodeproj

bump:
ifeq (,$(strip $(version)))
	# Usage: make bump version=<number>
else
	ruby -pi -e "gsub(%r{\d+\.\d+\.\d+}, %{"$(version)"})" QuickTableViewController.podspec
	ruby -pi -e "gsub(%r{\d+\.\d+\.\d+}, %{"$(version)"})" .jazzy.yml
	xcrun agvtool new-marketing-version $(version)
endif

carthage:
	set -o pipefail && mint run carthage build --use-xcframeworks --no-skip-current --verbose | bundle exec xcpretty -c

docs:
	test -d docs || git clone -b gh-pages --single-branch https://github.com/bcylin/QuickTableViewController.git docs
	cd docs && git fetch origin gh-pages && git clean -f -d
	cd docs && git checkout gh-pages && git reset --hard origin/gh-pages
	bundle exec jazzy --config .jazzy.yml

	for file in "html" "css" "js" "json"; do \
		echo "Cleaning whitespace in *."$$file ; \
		find docs/output -name "*."$$file -exec sed -E -i "" -e "s/[[:blank:]]*$$//" {} \; ; \
	done
	find docs -type f -execdir chmod 644 {} \;

	cp -rfv docs/output/* docs
	cd docs && \
	git add . && \
	git diff-index --quiet HEAD || \
	git commit -m "[CI] Update documentation at $(shell date +'%Y-%m-%d %H:%M:%S %z')"

preview-docs:
	make -B docs
	open docs/index.html

update-docs:
	make -B docs
	cd docs && git push origin HEAD:gh-pages
