# Change Log

## v0.5.2

#### Changes

* Xcode 8.3
* Make the image name and highlighted image name of `Icon` public readonly

## v0.5.1

#### Changes

* Specify table view cell reuse identifier on each type of row
* Update Swift syntax

## v0.5.0

#### Changes

* Swift 3.0

## v0.4.0

#### Changes

* Swift 2.3
* Improved documentation
* Make the images of `Icon` readonly

## v0.3.0

#### Changes

* Swift 2.2
* Both `NavigationRow` and `SwitchRow` conform to `IconEnabled`.

## v0.2.0

#### Changes

* Swift 2.0
* `Row` and `Subtitle` now conform to `Equatable`
* Specify table view cell images with `Icon`, which includes highlighted image
* Separate self.view from self.tableView in QuickTableViewController

#### Fixes

* Fix the access control on the overridden initializer

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
