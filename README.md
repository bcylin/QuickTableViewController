# QuickTableViewController

[![Build Status](https://travis-ci.org/bcylin/QuickTableViewController.svg)](https://travis-ci.org/bcylin/QuickTableViewController)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/QuickTableViewController.svg)](https://cocoapods.org/pods/QuickTableViewController)
![Platform](https://img.shields.io/cocoapods/p/QuickTableViewController.svg)
[![codecov](https://codecov.io/gh/bcylin/QuickTableViewController/branch/develop/graph/badge.svg)](https://codecov.io/gh/bcylin/QuickTableViewController)
![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)

A simple way to create a table view for settings, including:

* Table view cells with `UISwitch`
* Table view cells with center aligned text for tap actions
* A section that provides mutually exclusive options
* Actions performed when the row reacts to the user interaction
* Customizable table view cell image, cell style and cell accessory type

<img src="https://bcylin.github.io/QuickTableViewController/img/screenshots.png" width="80%"></img>

## Usage

Set up `tableContents` in `viewDidLoad`:

```swift
import QuickTableViewController

class ViewController: QuickTableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    tableContents = [
      Section(title: "Switch", rows: [
        SwitchRow(title: "Setting 1", switchValue: true, action: { _ in }),
        SwitchRow(title: "Setting 2", switchValue: false, action: { _ in }),
      ]),

      Section(title: "Tap Action", rows: [
        TapActionRow(title: "Tap action", action: { [weak self] in self?.showAlert($0) })
      ]),

      Section(title: "Navigation", rows: [
        NavigationRow(title: "CellStyle.default", subtitle: .none, icon: Icon(image: UIImage(named: "globe"), highlightedImage: UIImage(named: "globe-highlighted"))),
        NavigationRow(title: "CellStyle", subtitle: .belowTitle(".subtitle"), icon: Icon(image: UIImage(named: "gear"))),
        NavigationRow(title: "CellStyle", subtitle: .rightAligned(".value1"), icon: Icon(imageName: "time"), action: { [weak self] in self?.showDetail($0) }),
        NavigationRow(title: "CellStyle", subtitle: .leftAligned(".value2"))
      ]),

      RadioSection(title: "Radio Buttons", options: [
        OptionRow(title: "Option 1", isSelected: true, action: nil),
        OptionRow(title: "Option 2", isSelected: false, action: nil),
        OptionRow(title: "Option 3", isSelected: false, action: nil)
      ], footer: "See RadioSection for more details.")
    ]
  }

  // MARK: - Actions

  private func showAlert(_ sender: Row) {
    // ...
  }

  private func showDetail(_ sender: Row) {
    // ...
  }

}
```

### NavigationRow

#### Subtitle Styles

```swift
NavigationRow(title: "UITableViewCellStyle.Default", subtitle: .none)
NavigationRow(title: "UITableViewCellStyle", subtitle: .belowTitle(".subtitle")
NavigationRow(title: "UITableViewCellStyle", subtitle: .rightAligned(".value1")
NavigationRow(title: "UITableViewCellStyle", subtitle: .leftAligned(".value2"))
```

#### Images

* Images in table view cells can be set by specifying the `icon` of each row.
* The `Icon` struct carries info about images for both normal and highlighted states.
* Table view cells in `UITableViewCellStyle.value2` will not show the image view.

```swift
NavigationRow(title: "Cell with image", subtitle: .none, icon: Icon(imageName: "icon"))
```

#### Disclosure Indicator

* A `NavigationRow` with an `action` will be displayed in a table view cell whose `accessoryType` is `.disclosureIndicator`.
* The `action` will be invoked when the related table view cell is selected.

```swift
NavigationRow(title: "Navigation cell", subtitle: .None, action: { (sender: Row) in })
```

### SwitchRow

* A `SwitchRow` is representing a table view cell with a `UISwitch` as its `accessoryView`.
* The `action` will be invoked when the switch value changes.
* The subtitle is disabled in `SwitchRow `.

```swift
SwitchRow(title: "Switch", switchValue: true, action: { (sender: Row) in }),
```

### TapActionRow

* A `TapActionRow` is representing a button-like table view cell.
* The `action` will be invoked when the related table view cell is selected.
* `Icon` is disabled in `TapActionRow`.

```swift
TapActionRow(title: "Tap action", action: { (sender: Row) in })
```

### OptionRow & RadioSection

* An `OptionRow` is representing a selectable table view cell.
* When the row `isSelected`, the table view cell shows `.checkmark` as its `accessoryType`.
* The `action` will be invoked when the selection is toggled.
* The subtitle is disabled in `OptionRow`.

```swift
OptionRow(title: "Option", isSelected: true, action: { (sender: Row) in })
```

* `OptionRow` can be used with or without `RadioSection`, which guarantees that there's only one option is selected.
* `RadioSection` allows all options unselected by default. Setting `alwaysSelectsOneOption` to true will preserve one selected option.
* `selectedOption` is available as the result of selection in `RadioSection`.

## Customization

### Rows

All rows must conform to [`Row`](https://github.com/bcylin/QuickTableViewController/blob/develop/Source/Protocol/Row.swift) and [`RowStyle`](https://github.com/bcylin/QuickTableViewController/blob/develop/Source/Protocol/RowStyle.swift). Addtional interface to work with specific types of rows are represented as different protocols:

* `Switchable`
* `Tappable`
* `OptionSelectable`

### Cell Classes

A customized table view cell type can be specified to rows during initialization.

```swift
// NavigationRow, using UITableViewCell if not specified.
NavigationRow<CustomCell>(title: "Navigation", subtitle: .none)

// SwitchRow, using SwitchCell if not specified.
SwitchRow<CustomSwitchCell>(title: "Switch", switchValue: true, action: { _ in })

// TapActionRow, using TapActionCell if not specified.
TapActionRow<CustomTapActionCell>(title: "Tap", action: { _ in })

// OptionRow, using UITableViewCell if not specified.
OptionRow<CustomOptionCell>(title: "Option", isSelected: true, action: { _ in })
```

Since the rows carry different cell types, they can be matched using either the concrete types or the related protocol:

```swift
let action: (Row) -> Void = {
  switch $0 {
  case let option as OptionRow<CustomOptionCell>:
    // only matches the option rows with a specific cell type
  case let option as OptionSelectable:
    // matches all option rows
  default:
    break
  }
}
```

### Overwrite Default Configuration

Table view cell classes that conform to `Configurable` can implement additional configuration to set up the cell during `tableView(_:cellForRowAt:)`:

```swift
protocol Configurable {
  func configure(with row: Row & RowStyle)
}
```

Other setups can also be added to each row using the `customize` closure:

```swift
protocol RowStyle {
  var customize: ((UITableViewCell, Row & RowStyle) -> Void)? { get }
}
```

You can also use `register(_:forCellReuseIdentifier:)` to specify custom cell types for the [table view]((https://github.com/bcylin/QuickTableViewController/blob/develop/Source/QuickTableViewController.swift#L104)) to use. See [CustomizationViewController](https://github.com/bcylin/QuickTableViewController/blob/develop/Example/ViewControllers/CustomizationViewController.swift) for the cell reuse identifiers of different rows.

### UIAppearance

As discussed in issue [#12](https://github.com/bcylin/QuickTableViewController/issues/12), UIAppearance customization works when the cell is dequeued from the storyboard. One way to work around this is to register nib objects to the table view. Check out [AppearanceViewController](https://github.com/bcylin/QuickTableViewController/blob/develop/Example/ViewControllers/AppearanceViewController.swift) for the setups.

## Limitation

> When to use **QuickTableViewController**?

QuickTableViewController is good for presenting static table contents, where the sections and rows don't need to change dynamically after `viewDidLoad`.

It's possible to update the table contents by replacing a specific section or row. Using different styles on each row requires additional configuration as described in the [Customization](#customization) section.

> When **not** to use it?

QuickTableViewController is not designed for inserting and deleting rows. It doesn't handle table view reload animation either. If your table view needs to update dynamically, you might want to consider other solutions such as [IGListKit](https://github.com/Instagram/IGListKit).

## Documentation

* [QuickTableViewController Reference](https://bcylin.github.io/QuickTableViewController)
* [Example Project](https://github.com/bcylin/QuickTableViewController/tree/develop/Example)

## Requirements

QuickTableViewController | iOS  | Xcode | Swift
------------------------ | :--: | :---: | :---:
`~> 0.1.0`               | 8.0+ | 6.4   | ![Swift 1.2](https://img.shields.io/badge/Swift-1.2-orange.svg)
`~> 0.2.0`               | 8.0+ | 7.0   | ![Swift 2.0](https://img.shields.io/badge/Swift-2.0-orange.svg)
`~> 0.3.0`               | 8.0+ | 7.3   | ![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg)
`~> 0.4.0`               | 8.0+ | 8.0   | ![Swift 2.3](https://img.shields.io/badge/Swift-2.3-orange.svg)
`~> 0.5.0`               | 8.0+ | 8.0   | ![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)
`~> 0.6.0`               | 8.0+ | 8.3   | ![Swift 3.1](https://img.shields.io/badge/Swift-3.1-orange.svg)
`~> 0.7.0`               | 8.0+ | 9.0   | ![Swift 3.2](https://img.shields.io/badge/Swift-3.2-orange.svg)
`~> 0.8.0`               | 8.0+ | 9.1   | ![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)

## Installation

### Use [CocoaPods](http://guides.cocoapods.org/)

Create a `Podfile` with the following specification and run `pod install`.

```rb
platform :ios, '8.0'
use_frameworks!

pod 'QuickTableViewController'
```

### Use [Carthage](https://github.com/Carthage/Carthage)

Create a `Cartfile` with the following specification and run `carthage update QuickTableViewController`.
Follow the [instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to add the framework to your project.

```
github "bcylin/QuickTableViewController"
```

### Use Git Submodule

```
git submodule add -b master git@github.com:bcylin/QuickTableViewController.git Dependencies/QuickTableViewController
```

* Drag **QuickTableViewController.xcodeproj** to your app project as a subproject.
* On your application target's **Build Phases** settings tab, add **QuickTableViewController-iOS** to **Target Dependencies**.

## Contact

[![Twitter](https://img.shields.io/badge/twitter-@bcylin-blue.svg?style=flat)](https://twitter.com/bcylin)

## License

QuickTableViewController is released under the MIT license.
See [LICENSE](https://github.com/bcylin/QuickTableViewController/blob/master/LICENSE) for more details.
Image source: [iconmonstr](http://iconmonstr.com/license/).
