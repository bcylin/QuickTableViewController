//
//  CustomizationViewController.swift
//  Example
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
import Weakify

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
    rows: [NavigationRow(title: "", subtitle: .none)],
    footer: "Select or toggle each row to show their cell reuse identifiers."
  )

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Customization"

    tableContents = [
      debugging,

      Section(title: "Switch", rows: [
        SwitchRow<CustomSwitchCell>(title: "SwitchRow\n<CustomSwitchCell>", switchValue: true, action: weakify(self, type(of: self).log)),
        CustomSwitchRow<SwitchCell>(title: "CustomSwitchRow\n<SwitchCell>", switchValue: false, action: weakify(self, type(of: self).log))
      ]),

      Section(title: "Tap Action", rows: [
        TapActionRow<CustomTapActionCell>(title: "TapActionRow\n<CustomTapActionCell>", action: weakify(self, type(of: self).log)),
        CustomTapActionRow<TapActionCell>(title: "CustomTapActionRow\n<TapActionCell>", action: weakify(self, type(of: self).log))
      ]),

      Section(title: "Navigation", rows: [
        NavigationRow(title: "NavigationRow", subtitle: .none, action: weakify(self, type(of: self).log)),
        NavigationRow<CustomCell>(title: "NavigationRow<CustomCell>", subtitle: .belowTitle(".subtitle"), action: weakify(self, type(of: self).log)),
        CustomNavigationRow(title: "CustomNavigationRow", subtitle: .rightAligned(".value1"), action: weakify(self, type(of: self).log)),
        CustomNavigationRow<CustomCell>(title: "CustomNavigationRow<CustomCell>", subtitle: .leftAligned(".value2"), action: weakify(self, type(of: self).log))
      ]),

      RadioSection(title: "Radio Buttons", options: [
        OptionRow(title: "OptionRow", isSelected: false, action: weakify(self, type(of: self).log)),
        CustomOptionRow(title: "CustomOptionRow", isSelected: false, action: weakify(self, type(of: self).log)),
        CustomOptionRow<CustomOptionCell>(title: "CustomOptionRow<CustomOptionCell>", isSelected: false, action: weakify(self, type(of: self).log))
      ]),

      Section(title: nil, rows: [
        NavigationRow(title: "Customization closure", subtitle: .none, customization: { cell, _ in
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

  private func log(_ sender: Row) {
    if let option = sender as? OptionSelectable, !option.isSelected {
      return
    }

    let text = (sender as! RowStyle).cellReuseIdentifier
    debugging.rows = [NavigationRow(title: text, subtitle: .none)]
    print(text)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
      self?.tableView.reloadData()
    }
  }

}
