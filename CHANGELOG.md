# Change Log

## v0.6.1

#### Enhancements

* UI testing
* Change sections and rows from structs to classes
* Allow customized cell classes to implement the `Configurable` method in addition to the default setup

#### Fixes

* UISwitch animation [#9](https://github.com/bcylin/QuickTableViewController/issues/9)

## v0.6.0

#### Breaking

* Deprecate the customization using table view `register(_:forCellReuseIdentifier:)`
* Move the `tableView` configuration from `loadView()` to `viewDidLoad()`

#### Enhancements

* Specify table view cell types to rows during initialization
* Separate `RowStyle` from the original `Row` protocol
* Add an additional cell customization `((UITableViewCell, Row & RowStyle) -> Void)?` for each row [#8](https://github.com/bcylin/QuickTableViewController/issues/8)

## v0.5.3

#### Fixes

* Fix the cell reuse identifier of `SwitchRow` and `TapActionRow` to be compatible with `0.5.x`

Cell Reuse identifier | SwitchRow                            | TapActionRow
--------------------- | ------------------------------------ | ---------------------------------------
`<= 0.5.0`            | `NSStringFromClass(SwitchRow.self)`  | `NSStringFromClass(TapActionRow.self)`
`== 0.5.1`            | `String(describing: SwitchRow.self)` | `String(describing: TapActionRow.self)`
`== 0.5.2`            | `String(describing: SwitchRow.self)` | `String(describing: TapActionRow.self)`
`== 0.5.3`            | `NSStringFromClass(SwitchRow.self)`  | `NSStringFromClass(TapActionRow.self)`

## v0.5.2

#### Enhancements

* Xcode 8.3
* Make the image name and highlighted image name of `Icon` public readonly

## v0.5.1

#### Enhancements

* Specify table view cell reuse identifier for each type of row
* Update Swift syntax

## v0.5.0

#### Breaking

* Swift 3.0

## v0.4.0

#### Enhancements

* Swift 2.3
* Improved documentation
* Make the images of `Icon` readonly

## v0.3.0

#### Enhancements

* Swift 2.2
* Both `NavigationRow` and `SwitchRow` conform to `IconEnabled` [#2](https://github.com/bcylin/QuickTableViewController/issues/2)

## v0.2.0

#### Breaking

* Swift 2.0

#### Enhancements

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
