# QuickTableViewController

[![Build Status](https://travis-ci.org/bcylin/QuickTableViewController.svg)](https://travis-ci.org/bcylin/QuickTableViewController)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/QuickTableViewController.svg)](https://cocoapods.org/pods/QuickTableViewController)
![Platform](https://img.shields.io/cocoapods/p/QuickTableViewController.svg)
[![CocoaDocs](https://img.shields.io/cocoapods/metrics/doc-percent/QuickTableViewController.svg)](http://cocoadocs.org/docsets/QuickTableViewController)
[![codecov.io](https://codecov.io/github/bcylin/QuickTableViewController/coverage.svg)](https://codecov.io/github/bcylin/QuickTableViewController)
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)

A simple way to create a table view for settings, providing table view cells with:

* UISwitch
* Center aligned text
* Table view cell image
* Disclosure indicator
* Specified UITableViewCellStyle

<img src="https://bcylin.github.io/QuickTableViewController/img/screenshot.png" width="50%"></img>

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

      Section(title: "Cell Styles", rows: [
        NavigationRow(title: "CellStyle.Default", subtitle: .None, icon: Icon(image: UIImage(named: "exit"), highlightedImage: UIImage(named: "exit-highlighted"))),
        NavigationRow(title: "CellStyle", subtitle: .BelowTitle(".Subtitle"), icon: Icon(image: UIImage(named: "language"))),
        NavigationRow(title: "CellStyle", subtitle: .RightAligned(".Value1"), icon: Icon(imageName: "timeMachine"), action: { [weak self] in self?.showDetail($0) }),
        NavigationRow(title: "CellStyle", subtitle: .LeftAligned(".Value2"))
      ])
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
NavigationRow(title: "UITableViewCellStyle.Default", subtitle: .None)
NavigationRow(title: "UITableViewCellStyle", subtitle: .BelowTitle(".Subtitle")
NavigationRow(title: "UITableViewCellStyle", subtitle: .RightAligned(".Value1")
NavigationRow(title: "UITableViewCellStyle", subtitle: .LeftAligned(".Value2"))
```

#### IconEnabled

* Images in table view cells can be set by specifying the `icon` of each `IconEnabled` row.
* The `Icon` struct carries info about images for both normal and highlighted states.
* Table view cells in `UITableViewCellStyle.Value2` will hide images.

```swift
NavigationRow(title: "Cell with image", subtitle: .None, icon: Icon(imageName: "icon"))
```

#### Disclosure Indicator

* A `NavigationRow` with an `action` will be displayed in a table view cell whose `accessoryType` is `.DisclosureIndicator`.
* The `action` will be invoked when the related table view cell is selected.

```swift
NavigationRow(title: "Navigation cell", subtitle: .None, action: { (sender: Row) in })
```

### SwitchRow

* A `SwitchRow` is associated to a table view cell with a `UISwitch` as its `
accessoryView`.
* The optional `action` will be invoked when the `switchValue` changes.
* It also conforms to `IconEnabled`.

```swift
SwitchRow(title: "Switch", switchValue: true, action: { (sender: Row) in }),
```

> The original `SwitchRow` in the `tableContents` will be replaced by an updated one after the `switchValue` changed.

### TapActionRow

* A `TapActionRow` is associated to a button-like table view cell.
* The `action` will be invoked when the related table view cell is selected.

```swift
TapActionRow(title: "Tap action", action: { (sender: Row) in })
```

### Use Custom Cell Classes

```swift
// NavigationRow
tableView.register(CustomCell.self, forCellReuseIdentifier: "Subtitle.None")
tableView.register(CustomSubtitleCell.self, forCellReuseIdentifier: "Subtitle.BelowTitle")
tableView.register(CustomValue1StyleCell.self, forCellReuseIdentifier: "Subtitle.RightAligned")
tableView.register(CustomValue2StyleCell.self, forCellReuseIdentifier: "Subtitle.LeftAligned")
```

```swift
// SwitchRow
tableView.register(CustomSwitchCell.self, forCellReuseIdentifier: NSStringFromClass(SwitchCell.self))

// TapActionRow
tableView.register(CustomTapActionCell.self, forCellReuseIdentifier: NSStringFromClass(TapActionCell.self))
```

> Note: in `0.5.1` & `0.5.2`, **SwitchRow** and **TapActionRow** were using `String(describing: SwitchCell.self)` and `String(describing: TapActionCell.self)` as reuse identifiers. Fixed in `0.5.3` for backward compatibility.

### Full Documentation

<https://bcylin.github.io/QuickTableViewController>

## Requirements

QuickTableViewController | iOS  | Xcode | Swift
------------------------ | :--: | :---: | :---:
`~> 0.1.0`               | 8.0+ | 6.4   | ![Swift 1.2](https://img.shields.io/badge/Swift-1.2-orange.svg)
`~> 0.2.0`               | 8.0+ | 7.0   | ![Swift 2.0](https://img.shields.io/badge/Swift-2.0-orange.svg)
`~> 0.3.0`               | 8.0+ | 7.3   | ![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg)
`~> 0.4.0`               | 8.0+ | 8.0   | ![Swift 2.3](https://img.shields.io/badge/Swift-2.3-orange.svg)
`~> 0.5.0`               | 8.0+ | 8.0   | ![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)

## Installation

### Use [CocoaPods](http://guides.cocoapods.org/)

Create a `Podfile` with the following specification and run `pod install`.

```rb
platform :ios, '8.0'
use_frameworks!

pod 'QuickTableViewController', '~> 0.5.0'
```

### Use [Carthage](https://github.com/Carthage/Carthage)

Create a `Cartfile` with the following specification and run `carthage update QuickTableViewController`.
Follow the [instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to add the framework to your project.

```
github "bcylin/QuickTableViewController" ~> 0.5.0
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
