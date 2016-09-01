# Change Log

## Next Release

#### Changes

* Run tests with fastlane scan
* Integrate with [danger.systems](https://github.com/danger/danger)
* Improve documentation
* Make the images of `Icon` readonly

## v0.3.0

#### Changes

* Swift 2.2
* CocoaPods 1.0.1
* Calculate code coverage
* SwiftLint with Hound CI
* Both `NavigationRow` and `SwitchRow` conform to `IconEnabled`.

## v0.2.0

#### Changes

* Swift 2
* `Row` and `Subtitle` now conform to `Equatable`
* Run tests on Travis CI
* Specify table view cell images with `Icon`, which includes highlighted image
* Separate self.view from self.tableView in QuickTableViewController

#### Fixes

* Fix the access control on the overridden initializer
* Clean up syntax with SwiftLint

## v0.1.1

#### Fixes

* Change the deployment target from iOS 8.4 to 8.0

## v0.1.0

* Initial release written in Swift 1.2
* Basic layout:
  * `Section`
  * `NavigationRow` with `Subtitle`
  * `SwitchRow`
  * `TapActionRow`
