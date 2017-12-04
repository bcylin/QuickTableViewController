//
//  ViewController.swift
//  Example
//
//  Created by Ben on 01/09/2015.
//  Copyright (c) 2015 bcylin.
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

internal final class ViewController: QuickTableViewController {

  private final class CustomCell: UITableViewCell {}

  // MARK: - Properties

  private let debugging = Section(title: nil, rows: [])

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "QuickTableViewController"

    let gear = #imageLiteral(resourceName: "iconmonstr-gear")
    let globe = #imageLiteral(resourceName: "iconmonstr-globe")
    let time = #imageLiteral(resourceName: "iconmonstr-time")

    print(String(describing: SwitchCell.self))

    tableContents = [
      Section(title: "Switch", rows: [
        SwitchRow<SwitchCell>(title: "Setting 1", switchValue: true, icon: Icon(image: globe), action: weakify(self, type(of: self).didToggleSwitch)),
        SwitchRow<SwitchCell>(title: "Setting 2", switchValue: false, icon: Icon(image: time), action: weakify(self, type(of: self).didToggleSwitch))
      ]),

      Section(title: "Tap Action", rows: [
        TapActionRow<TapActionCell>(title: "Tap action", action: weakify(self, type(of: self).showAlert))
      ]),

      Section(title: "Navigation", rows: [
        NavigationRow(title: "CellStyle.default", subtitle: .none, icon: Icon(image: gear)),
        NavigationRow(title: "CellStyle", subtitle: .belowTitle(".subtitle"), icon: Icon(image: globe)),
        NavigationRow(title: "CellStyle", subtitle: .rightAligned(".value1"), icon: Icon(image: time), action: weakify(self, type(of: self).showDetail)),
        NavigationRow(title: "CellStyle", subtitle: .leftAligned(".value2"))
      ], footer: "UITableViewCellStyle.Value2 hides the image view."),

      Section(title: nil, rows: [
        NavigationRow<CustomCell>(title: "Empty section title", subtitle: .none, customization: { cell, row in
          cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "iconmonstr-x-mark"))
          print(row.cellReuseIdentifier)
        })
      ]),

      RadioSection(title: "Radio Buttons", options: [
        OptionRow(title: "Option 1", isSelected: true, action: weakify(self, type(of: self).didToggleSelection)),
        OptionRow(title: "Option 2", isSelected: false, action: weakify(self, type(of: self).didToggleSelection)),
        OptionRow(title: "Option 3", isSelected: false, action: weakify(self, type(of: self).didToggleSelection))
      ], footer: "See RadioSection for more details."),

      debugging
    ]
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    // Alter the cells created by QuickTableViewController
    return cell
  }

  // MARK: - Private Methods

  private func didToggleSelection(_ sender: Row) {
    guard let option = sender as? OptionRow else {
      return
    }

    let state = "\(option.title) is " + (option.isSelected ? "selected" : "deselected")
    print(state)
    showDebuggingText(state)
  }

  private func didToggleSwitch(_ sender: Row) {
    if let row = sender as? SwitchRow {
      let state = "\(row.title) = \(row.switchValue)"
      print(state)
      showDebuggingText(state)
    }
  }

  private func showAlert(_ sender: Row) {
    let alert = UIAlertController(title: "Action Triggered", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel) { [unowned self] _ in
      self.dismiss(animated: true, completion: nil)
    })
    present(alert, animated: true, completion: nil)
  }

  private func showDetail(_ sender: Row) {
    let detail = "\(sender.title)\(sender.subtitle?.text ?? "")"
    let controller = UIViewController()
    controller.view.backgroundColor = UIColor.white
    controller.title = detail
    navigationController?.pushViewController(controller, animated: true)
    showDebuggingText(detail + " is selected")
  }

  private func showDebuggingText(_ text: String) {
    debugging.rows = [NavigationRow(title: text, subtitle: .none)]
    let indexSet: IndexSet? = tableContents.index(where: { $0 === debugging }).map { [$0] }
    tableView.reloadSections(indexSet ?? [], with: .none)
  }

}
