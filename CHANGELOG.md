# Change Log

## v0.2.0

#### Added

* Support Swift 2
* `Row` and `Subtitle` now conform to `Equatable`
* Run tests on Travis CI
* Specify table view cell images with `Icon`, which includes highlighted image
* Separate self.view from self.tableView in QuickTableViewController

#### Fixed

* Fix the access control on the overridden initializer
* Clean up syntax with SwiftLint

## v0.1.1

#### Fixed

* Change the deployment target from iOS 8.4 to 8.0

## v0.1.0

#### Added

* Initial release written in Swift 1.2
* Basic layout:
  * `Section`
  * `NavigationRow` with `Subtitle`
  * `SwitchRow`
  * `TapActionRow`
