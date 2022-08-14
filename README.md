# QuickTableViewController

[![GitHub Actions](https://github.com/bcylin/QuickTableViewController/workflows/CI/badge.svg)](https://github.com/bcylin/QuickTableViewController/actions)
[![Codecov](https://img.shields.io/codecov/c/github/bcylin/QuickTableViewController)](https://codecov.io/gh/bcylin/QuickTableViewController)
[![Carthage compatible](https://img.shields.io/badge/carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/QuickTableViewController.svg)](https://cocoapods.org/pods/QuickTableViewController)
[![Platform](https://img.shields.io/cocoapods/p/QuickTableViewController?label=docs)](https://bcylin.github.io/QuickTableViewController)
![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg)

A simple way to create a table view for settings.

<img src="https://raw.githubusercontent.com/bcylin/QuickTableViewController/develop/Documentation/Screenshot.png" width="320"></img>

## Sunsetting

ℹ️ If your deployment target is iOS 13 or above, please consider using [SwiftUI](#SwiftUI).

QuickTableViewController was designed to show static table contents when it was around iOS 8 and Swift 1.2. Over the past few iterations, a couple more controls were added but it still has its [limitations](https://github.com/bcylin/QuickTableViewController/tree/develop/Documentation/README.md#limitations). After the introduction of [List](https://developer.apple.com/documentation/swiftui/list) and [Form](https://developer.apple.com/documentation/swiftui/form) in iOS 13, SwiftUI has become a better solution for both static and dynamic table views.

QuickTableViewController will stay at the latest released version [`v1.3.1`](https://github.com/bcylin/QuickTableViewController/tree/v1.3.1) from now on. Future updates will be mostly experimental. To use QuickTableViewController in UIKit, please see:

- [QuickTableViewController documentation](https://bcylin.github.io/QuickTableViewController)
- [Pre-release version](https://github.com/bcylin/QuickTableViewController/tree/develop/Documentation)

## SwiftUI

The same settings layout can be implemented in SwiftUI and integrated into UIKit using UIHostingController. For more, please see [Example-iOS/SwiftUI](https://github.com/bcylin/QuickTableViewController/tree/develop/Example-iOS/SwiftUI).

```swift
var body: some View {
    Form {
        Section(header: Text("Switch")) {
            Toggle(isOn: $viewModel.flag1) {
                subtitleCellStyle(title: "Setting 1", subtitle: "Example subtitle")
                    .leadingIcon("globe")
            }
            Toggle(isOn: $viewModel.flag2) {
                subtitleCellStyle(title: "Setting 2", subtitle: nil)
                    .leadingIcon("clock.arrow.circlepath")
            }
        }

        Section(header: Text("Tap Action")) {
            Button {
                viewModel.performTapAction()
            } label: {
                Text("Tap action").frame(maxWidth: .infinity)
            }
        }

        Section(header: Text("Cell Style"), footer: Text("CellStyle.value2 is not implemented")) {
            subtitleCellStyle(title: "CellStyle.default", subtitle: nil)
                .leadingIcon("gear")
            subtitleCellStyle(title: "CellStyle.default", subtitle: ".subtitle")
                .leadingIcon("globe")
            value1CellStyle(title: "CellStyle", detailText: ".value1")
                .leadingIcon("clock.arrow.circlepath")
        }

        Section(header: Text("Radio Button")) {
            ForEach(SettingsViewModel.Option.allCases) { option in
                checkmarkCellStyle(with: option, isSelected: viewModel.isOptionSelected(option))
            }
        }
    }
}
```
## License

QuickTableViewController is released under the [MIT license](https://github.com/bcylin/QuickTableViewController/tree/master/LICENSE). Image source: [iconmonstr](https://iconmonstr.com/license)
