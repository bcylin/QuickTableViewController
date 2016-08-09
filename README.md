# QuickTableViewController

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/bcylin/QuickTableViewController.svg?branch=develop)](https://travis-ci.org/bcylin/QuickTableViewController)
[![codecov.io](https://codecov.io/github/bcylin/QuickTableViewController/coverage.svg?branch=develop)](https://codecov.io/github/bcylin/QuickTableViewController?branch=develop)

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
        TapActionRow(title: "Tap action", action: showAlert)
      ]),

      Section(title: "Cell Styles", rows: [
        NavigationRow(title: "CellStyle.Default", subtitle: .None, icon: Icon(image: UIImage(named: "exit"), highlightedImage: UIImage(named: "exit-highlighted"))),
        NavigationRow(title: "CellStyle", subtitle: .BelowTitle(".Subtitle"), icon: Icon(image: UIImage(named: "language"))),
        NavigationRow(title: "CellStyle", subtitle: .RightAligned(".Value1"), icon: Icon(imageName: "timeMachine"), action: showDetail),
        NavigationRow(title: "CellStyle", subtitle: .LeftAligned(".Value2"))
      ])
    ]
  }

  // MARK: - Actions

  private func showAlert(sender: Row) {
    // ...
  }

  private func showDetail(sender: Row) {
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

## Requirements

QuickTableViewController | iOS  | Xcode | Swift
------------------------ | :--: | :---: | -----
`~> v0.1.0`              | 8.0+ | 6.4   | ![Swift 1.2](https://img.shields.io/badge/Swift-1.2-orange.svg)
`~> v0.2.0`              | 8.0+ | 7.0   | ![Swift 2.0](https://img.shields.io/badge/Swift-2.0-orange.svg)
`~> v0.3.0`              | 8.0+ | 7.3   | ![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg)

## Installation

### Install via [Carthage](https://github.com/Carthage/Carthage)

* Create a `Cartfile` with the following specification and run `carthage bootstrap`.

  ```
  github "bcylin/QuickTableViewController"
  ```

* On your application targets' **General** settings tab, in the **Linked Frameworks and Libraries** section, drag and drop `QuickTableViewController.framework` from the Carthage/Build folder.

* On your application targets’ **Build Phases** settings tab, click the **+** icon and choose **New Run Script Phase**. Create a Run Script with the following contents:

  ```
  /usr/local/bin/carthage copy-frameworks
  ```

  and add the following path to **Input Files**:

  ```
  $(SRCROOT)/Carthage/Build/iOS/QuickTableViewController.framework
  ```

* For more information, please check out the [Carthage Documentation](https://github.com/Carthage/Carthage#if-youre-building-for-ios).

### Install via [CocoaPods](http://guides.cocoapods.org/)

* Create a `Podfile` with the following specification and run `pod install`.

  ```rb
  platform :ios, '8.0'
  use_frameworks!

  pod 'QuickTableViewController', git: 'https://github.com/bcylin/QuickTableViewController.git'
  ```

### Install Manually

* Copy `*.swift` files in the `Source` directory to an iOS project.

## License

QuickTableViewController is released under the MIT license.
See [LICENSE](https://github.com/bcylin/QuickTableViewController/blob/master/LICENSE) for more details.
Image source: [iconmonstr](http://iconmonstr.com/license/).
