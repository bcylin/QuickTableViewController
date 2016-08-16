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
        SwitchRow(title: "Setting 1", switchValue: true, icon: Icon(image: globe), action: printValue),
        SwitchRow(title: "Setting 2", switchValue: false, icon: Icon(image: time), action: printValue)
      ]),

      Section(title: "Tap Action", rows: [
        TapActionRow(title: "Tap action", action: showAlert)
      ]),

      Section(title: "Cell Styles", rows: [
        NavigationRow(title: "CellStyle.Default", subtitle: .none, icon: Icon(image: gear)),
        NavigationRow(title: "CellStyle", subtitle: .belowTitle(".Subtitle"), icon: Icon(image: globe)),
        NavigationRow(title: "CellStyle", subtitle: .rightAligned(".Value1"), icon: Icon(image: time), action: showDetail),
        NavigationRow(title: "CellStyle", subtitle: .leftAligned(".Value2"))
      ]),

      Section(title: "Navigation", rows: [
        NavigationRow(title: "Navigation", subtitle: .none, action: showDetail),
        NavigationRow(title: "Navigation", subtitle: .belowTitle("with subtitle"), action: showDetail),
        NavigationRow(title: "Navigation", subtitle: .rightAligned("with detail text"), action: showDetail)
      ], footer: "UITableViewCellStyle.Value2 is not listed."),

      Section(title: nil, rows: [
        NavigationRow(title: "Empty section title", subtitle: .none)
      ])
    ]
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    if tableContents[(indexPath as NSIndexPath).section].title == nil {
      // Alter the cells created by QuickTableViewController
      cell.imageView?.image = UIImage(named: "iconmonstr-x-mark")
    }
    return cell
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

}
