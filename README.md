# QuickTableViewController

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A simple way to create a table view for settings, providing table view cells with:

* UISwitch
* Center aligned text
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
      Section(title: "Section title", rows: [
        NavigationRow(title: "Cell title", subtitle: .RightAligned("detail text"))
      ], footer: "Section footer"),

      Section(title: nil, rows: [
        NavigationRow(title: "Navigation", subtitle: .None, action: aNavigation),
        SwitchRow(title: "Switch cell", switchValue: true, action: anOptionalAction),
        TapActionRow(title: "Tap action", action: anAction),
      ])
    ]
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

* iOS 8.0+
* Xcode 6.4
* Currently QuickTableViewController is written in Swift 1.2, soon will be updated to Swift 2.0.

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

QuickTableViewController is released under the MIT license. See [LICENSE](https://github.com/bcylin/QuickTableViewController/blob/master/LICENSE) for more info.
