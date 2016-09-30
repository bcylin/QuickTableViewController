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
        NavigationRow(title: "CellStyle.Default", subtitle: .None, icon: Icon(image: gear)),
        NavigationRow(title: "CellStyle", subtitle: .BelowTitle(".Subtitle"), icon: Icon(image: globe)),
        NavigationRow(title: "CellStyle", subtitle: .RightAligned(".Value1"), icon: Icon(image: time), action: showDetail),
        NavigationRow(title: "CellStyle", subtitle: .LeftAligned(".Value2"))
      ]),

      Section(title: "Navigation", rows: [
        NavigationRow(title: "Navigation", subtitle: .None, action: showDetail),
        NavigationRow(title: "Navigation", subtitle: .BelowTitle("with subtitle"), action: showDetail),
        NavigationRow(title: "Navigation", subtitle: .RightAligned("with detail text"), action: showDetail)
      ], footer: "UITableViewCellStyle.Value2 is not listed."),

      Section(title: nil, rows: [
        NavigationRow(title: "Empty section title", subtitle: .None)
      ])
    ]
  }

  // MARK: - UITableViewDataSource

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    if tableContents[indexPath.section].title == nil {
      // Alter the cells created by QuickTableViewController
      cell.imageView?.image = UIImage(named: "iconmonstr-x-mark")
    }
    return cell
  }

  // MARK: - Private Methods

  private func showAlert(sender: Row) {
    let alert = UIAlertController(title: "Action Triggered", message: nil, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Cancel) { [unowned self] _ in
      self.dismissViewControllerAnimated(true, completion: nil)
    })
    presentViewController(alert, animated: true, completion: nil)
  }

  private func showDetail(sender: Row) {
    let controller = UIViewController()
    controller.view.backgroundColor = UIColor.whiteColor()
    controller.title = "\(sender.title) " + (sender.subtitle?.text ?? "")
    navigationController?.pushViewController(controller, animated: true)
  }

  private func printValue(sender: Row) {
    if let row = sender as? SwitchRow {
      print("\(row.title) = \(row.switchValue)")
    }
  }

}
