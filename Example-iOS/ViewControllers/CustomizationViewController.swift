//
//  CustomizationViewController.swift
//  Example-iOS
//
//  Created by Ben on 30/01/2018.
//  Copyright © 2018 bcylin.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import QuickTableViewController

private final class CustomCell: UITableViewCell {}
private final class CustomSwitchCell: SwitchCell {}
private final class CustomTapActionCell: TapActionCell {}
private final class CustomOptionCell: UITableViewCell {}

private final class CustomSwitchRow<T: SwitchCell>: SwitchRow<T> {}
private final class CustomTapActionRow<T: TapActionCell>: TapActionRow<T> {}
private final class CustomNavigationRow<T: UITableViewCell>: NavigationRow<T> {}
private final class CustomOptionRow<T: UITableViewCell>: OptionRow<T> {}

internal final class CustomizationViewController: QuickTableViewController {

  private let debugging = Section(
    title: nil,
    rows: [NavigationRow(text: "", detailText: .none)],
    footer: "Select or toggle each row to show their cell reuse identifiers."
  )

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Customization"

    tableContents = [
      debugging,

      Section(title: "Switch", rows: [
        SwitchRow<CustomSwitchCell>(
          text: "SwitchRow\n<CustomSwitchCell>",
          switchValue: true,
          customization: set(label: "0-0"),
          action: showLog()
        ),
        CustomSwitchRow<SwitchCell>(
          text: "CustomSwitchRow\n<SwitchCell>",
          switchValue: false,
          customization: set(label: "0-1"),
          action: showLog()
        )
      ]),

      Section(title: "Tap Action", rows: [
        TapActionRow<CustomTapActionCell>(
          text: "TapActionRow\n<CustomTapActionCell>",
          customization: set(label: "1-0"),
          action: showLog()
        ),
        CustomTapActionRow<TapActionCell>(
          text: "CustomTapActionRow\n<TapActionCell>",
          customization: set(label: "1-1"),
          action: showLog()
        )
      ]),

      Section(title: "Navigation", rows: [
        NavigationRow(
          text: "NavigationRow",
          detailText: .none,
          customization: set(label: "2-0"),
          action: showLog()
        ),
        NavigationRow<CustomCell>(
          text: "NavigationRow<CustomCell>",
          detailText: .subtitle(".subtitle"),
          customization: set(label: "2-1"),
          action: showLog()
        ),
        CustomNavigationRow(
          text: "CustomNavigationRow",
          detailText: .value1(".value1"),
          customization: set(label: "2-2"),
          action: showLog()
        ),
        CustomNavigationRow<CustomCell>(
          text: "CustomNavigationRow<CustomCell>",
          detailText: .value2(".value2"),
          customization: set(label: "2-3"),
          action: showLog()
        )
      ]),

      RadioSection(title: "Radio Buttons", options: [
        OptionRow(
          text: "OptionRow",
          isSelected: false,
          customization: set(label: "3-0"),
          action: showLog()
        ),
        CustomOptionRow(
          text: "CustomOptionRow",
          isSelected: false,
          customization: set(label: "3-1"),
          action: showLog()
        ),
        CustomOptionRow<CustomOptionCell>(
          text: "CustomOptionRow<CustomOptionCell>",
          isSelected: false,
          customization: set(label: "3-2"),
          action: showLog()
        )
      ]),

      Section(title: nil, rows: [
        NavigationRow(text: "Customization closure", detailText: .none, customization: { cell, _ in
          cell.accessibilityLabel = "4-0"
          cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "iconmonstr-x-mark"))
        })
      ])
    ]

  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    super.tableView(tableView, didSelectRowAt: indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }

  // MARK: - Private

  private func set(label: String) -> ((UITableViewCell, Row & RowStyle) -> Void) {
    return { cell, _ in
      cell.accessibilityLabel = label
    }
  }

  private func showLog() -> (Row) -> Void {
    return { [weak self] in
      if let option = $0 as? OptionRowCompatible, !option.isSelected {
        return
      }
      let identifier = ($0 as! RowStyle).cellReuseIdentifier
      self?.debugging.rows = [
        NavigationRow(text: identifier, detailText: .none, customization: self?.set(label: "debug"))
      ]
      print(identifier)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
        self?.tableView.reloadData()
      }
    }
  }

}
