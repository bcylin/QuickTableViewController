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

  // MARK: - Properties

  let debuggingSection = Section(title: nil, rows: [])

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "QuickTableViewController"

    let gear = #imageLiteral(resourceName: "iconmonstr-gear")
    let globe = #imageLiteral(resourceName: "iconmonstr-globe")
    let time = #imageLiteral(resourceName: "iconmonstr-time")

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
        NavigationRow(title: "Empty section title", subtitle: .none)
      ]),

      Section(title: "Customized", rows: [
        OptionRow(title: "Option 1", isSelected: true, action: weakify(self, type(of: self).didToggleSelection)),
        OptionRow(title: "Option 2", action: weakify(self, type(of: self).didToggleSelection)),
        OptionRow(title: "Option 3", action: weakify(self, type(of: self).didToggleSelection))
      ], footer: "See OptionRow for more details."),

      debuggingSection
    ]
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    let row = tableContents[indexPath.section].rows[indexPath.row]
    if row.title == "Empty section title" {
      // Alter the cells created by QuickTableViewController
      cell.imageView?.image = #imageLiteral(resourceName: "iconmonstr-x-mark")
    }
    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let row = tableContents[indexPath.section].rows[indexPath.row] as? OptionRow {
      row.isSelected = !row.isSelected
      row.action?(row)
      tableView.reloadRows(at: [indexPath], with: .automatic)
      tableView.deselectRow(at: indexPath, animated: true)
    } else {
      super.tableView(tableView, didSelectRowAt: indexPath)
    }
  }

  // MARK: - Private Methods

  private func didToggleSelection(_ sender: Row) {
    if let row = sender as? OptionRow {
      let state = "\(row.title) is toggled = \(row.isSelected)"
      print(state)
      showDebuggingText(state)
    }
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
    debuggingSection.footer = text
    tableView.reloadSections([tableContents.count - 1], with: .automatic)
  }

}
