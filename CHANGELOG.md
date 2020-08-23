# Change Log

## Next release

* Use SF Symbols as icon images, [#41](https://github.com/bcylin/QuickTableViewController/pull/41) by [@ezfe](https://github.com/ezfe)
* Make `init(style:)` a designated initializer

## v1.2.4

* Fix an issue where the same identifier is used for different cell types [#50](https://github.com/bcylin/QuickTableViewController/issues/50)

## v1.2.3

* Fix Swift version in podspec

## v1.2.2

#### Fixes

* Fix `SwitchRow` subtitles, [#45](https://github.com/bcylin/QuickTableViewController/pull/45) by [@dnicolson](https://github.com/dnicolson)

#### Project Updates

* Add an example of dynamic table, [#42](https://github.com/bcylin/QuickTableViewController/pull/42) by [@twodayslate](https://github.com/twodayslate)
* Convert specs to XCTests
* Move tests to GitHub Actions

## v1.2.1

* Support Swift Package

## v1.2.0

* Swift 5, [#38](https://github.com/bcylin/QuickTableViewController/pull/38) by [@getaaron](https://github.com/getaaron)

## v1.1.1

#### Fixes

* Fix the animated `OptionRow` deselection
* Invoke `accessoryButtonAction` asynchronously to match the behaviour of row `action`
* Remove `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES` from build settings

## v1.1.0

#### Enhancements

* Swift 4.2, [#20](https://github.com/bcylin/QuickTableViewController/pull/20) by [@getaaron](https://github.com/getaaron) and [#28](https://github.com/bcylin/QuickTableViewController/pull/28) by [@ mttcrsp](https://github.com/mttcrsp)
* tvOS UI tests, [#27](https://github.com/bcylin/QuickTableViewController/pull/27) by [@FraDeliro](https://github.com/FraDeliro)
* `Subtitle` is deprecated and will be removed in [**v2.0.0**](https://github.com/bcylin/QuickTableViewController/releases/tag/v2.0.0)
* Rename `Row`'s title and subtitle to text and detail text to align with `UITableViewCell`'s naming
* Enable **detailText** in `OptionRow` and `SwitchRow`
* Add **accessoryButtonAction** to `NavigationRow`

## v1.0.0

#### Enhancements

* Support tvOS

## v0.9.1

#### Fixes

* Fix the property setter in `RadioSection` and change `Row` to a class protocol, [#14](https://github.com/bcylin/QuickTableViewController/pull/14) by [@z3bi](https://github.com/z3bi)

## v0.9.0

#### Breaking

* Change the `Icon` type (since [v0.2.0](#v020)) from struct to enum:

  ```swift
  enum Icon {
    case named(String)
    case image(UIImage)
    case images(normal: UIImage, highlighted: UIImage)
  }
  ```

* Rename the protocols (introduced in [v0.8.1](#v081)) that define specific rows regardless of their associated cell types:

  * `NavigationRowCompatible`
  * `OptionSelectable` → `OptionRowCompatible`
  * `Switchable` → `SwitchRowCompatible`
  * `Tappable` → `TapActionRowCompatible`

## v0.8.4

#### Fixes

* Use `TapActionCell`'s `tintColor` as its label `textColor`, [#13](https://github.com/bcylin/QuickTableViewController/pull/13) by [@sanekgusev](https://github.com/sanekgusev)

## v0.8.3

#### Fixes

* Avoid some unwanted animation when the row action also involves table view reload

## v0.8.2

#### Fixes

* Fix the `SwitchCell` configuration with custom row classes

## v0.8.1

#### Fixes

* Unhighlight the selected row in the radio section when it's tapped with `alwaysSelectsOneOption` set to true
* Fix the empty image name that causes **CUICatalog: Invalid asset name supplied: ''**
* Allow `OptionRow` to be used with custom table view cells
* Fix the actions that are not invoked in rows with custom table view cells

## v0.8.0

#### Enhancements

* Swift 4

## v0.7.1

#### Enhancements

* Allow predefined `NavigationRow`, `SwitchRow`, `TapActionRow`, and `OptionRow` to be subclassable

## v0.7.0

#### Breaking

* Remove the accessory view from the `AccessoryEnabled` protocol
* Merge `IconEnabled` and `AccessoryEnabled` properties into the `RowStyle` protocol

#### Enhancements

* Add `OptionRow` and `RadioSection` to support mutually exclusive options

#### Fixes

* Use both cell type and cell style as the reuse identifiers for navigation rows to distinguish customized cell classes

## v0.6.2

#### Enhancements

* Mark properties and methods open in the open classes
* Improve the documentation

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

#### Project Updates

* CocoaPods 1.3.0

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

* Make the image name and highlighted image name of `Icon` public readonly

#### Project Updates

* Xcode 8.3
* CocoaPods 1.2.1

## v0.5.1

#### Enhancements

* Specify table view cell reuse identifier for each type of row
* Update Swift syntax

## v0.5.0

#### Breaking

* Swift 3.0

#### Project Updates

* Auto generated docs
* Move the example to the project root directory

## v0.4.0

#### Enhancements

* Swift 2.3
* Improved documentation
* Make the images of `Icon` readonly

#### Project Updates

* CocoaPods 1.1.0.rc.2
* Run tests with fastlane scan
* Integrate with [danger.systems](https://github.com/danger/danger)

## v0.3.0

#### Enhancements

* Swift 2.2
* Both `NavigationRow` and `SwitchRow` conform to `IconEnabled` [#2](https://github.com/bcylin/QuickTableViewController/issues/2)

#### Project Updates

* CocoaPods 1.0.1
* Calculate code coverage
* SwiftLint with Hound CI

## v0.2.0

#### Breaking

* Swift 2.0

#### Enhancements

* `Row` and `Subtitle` now conform to `Equatable`
* Specify table view cell images with `Icon`, which includes highlighted image
* Separate self.view from self.tableView in QuickTableViewController

#### Fixes

* Fix the access control on the overridden initializer

#### Project Updates

* Run tests on Travis CI
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
