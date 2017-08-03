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

class ViewController: QuickTableViewController {

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "QuickTableViewController"

    let gear = UIImage(named: "iconmonstr-gear")!
    let globe = UIImage(named: "iconmonstr-globe")!
    let time = UIImage(named: "iconmonstr-time")!

    tableContents = [
      Section(title: "Switch", rows: [
        SwitchRow(title: "Setting 1", switchValue: true, icon: Icon(image: globe), action: weakify(self, type(of: self).printValue)),
        SwitchRow(title: "Setting 2", switchValue: false, icon: Icon(image: time), action: weakify(self, type(of: self).printValue))
      ]),

      Section(title: "Tap Action", rows: [
        TapActionRow(title: "Tap action", action: weakify(self, type(of: self).showAlert))
      ]),

      Section(title: "Cell Styles", rows: [
        NavigationRow(title: "CellStyle.Default", subtitle: .none, icon: Icon(image: gear)),
        NavigationRow(title: "CellStyle", subtitle: .belowTitle(".Subtitle"), icon: Icon(image: globe)),
        NavigationRow(title: "CellStyle", subtitle: .rightAligned(".Value1"), icon: Icon(image: time), action: weakify(self, type(of: self).showDetail)),
        NavigationRow(title: "CellStyle", subtitle: .leftAligned(".Value2"))
      ]),

      Section(title: "Navigation", rows: [
        NavigationRow(title: "Navigation", subtitle: .none, action: weakify(self, type(of: self).showDetail)),
        NavigationRow(title: "Navigation", subtitle: .belowTitle("with subtitle"), action: weakify(self, type(of: self).showDetail)),
        NavigationRow(title: "Navigation", subtitle: .rightAligned("with detail text"), action: weakify(self, type(of: self).showDetail))
      ], footer: "UITableViewCellStyle.Value2 is not listed."),

      Section(title: nil, rows: [
        NavigationRow(title: "Empty section title", subtitle: .none)
      ]),

      Section(title: "Options", rows: {
        let block: (UITableViewCell, Row & RowStyle) -> Void = { cell, row in
          if let option = row as? OptionRow {
            cell.accessoryType = option.isSelected ? .checkmark : .none
          }
        }
        return [
          OptionRow(title: "Option 1", isSelected: true, customization: block, action: weakify(self, type(of: self).toggleSelection)),
          OptionRow(title: "Option 2", customization: block, action: weakify(self, type(of: self).toggleSelection)),
          OptionRow(title: "Option 3", customization: block, action: weakify(self, type(of: self).toggleSelection))
        ]
      }(), footer: "Customized OptionRow")
    ]
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    if tableContents[indexPath.section].title == nil {
      // Alter the cells created by QuickTableViewController
      cell.imageView?.image = UIImage(named: "iconmonstr-x-mark")
    }
    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if var row = tableContents[indexPath.section].rows[indexPath.row] as? OptionRow {
      row.isSelected = !row.isSelected
      row.action?(row)
      tableContents[indexPath.section].rows[indexPath.row] = row
    } else {
      super.tableView(tableView, didSelectRowAt: indexPath)
    }
  }

  // MARK: - Private Methods

  private func showAlert(_ sender: Row) {
    let alert = UIAlertController(title: "Action Triggered", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel) { [unowned self] _ in
      self.dismiss(animated: true, completion: nil)
    })
    present(alert, animated: true, completion: nil)
  }

  private func showDetail(_ sender: Row) {
    let controller = UIViewController()
    controller.view.backgroundColor = UIColor.white
    controller.title = "\(sender.title) " + (sender.subtitle?.text ?? "")
    navigationController?.pushViewController(controller, animated: true)
  }

  private func printValue(_ sender: Row) {
    if let row = sender as? SwitchRow {
      print("\(row.title) = \(row.switchValue)")
    }
  }

  private func toggleSelection(_ sender: Row) {
    if let row = sender as? OptionRow {
      print("\(row.title) is selected = \(row.isSelected)")
    }
  }

}
