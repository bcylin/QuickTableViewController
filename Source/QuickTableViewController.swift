//
//  QuickTableViewController.swift
//  QuickTableViewController
//
//  Created by Ben on 25/08/2015.
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

public class QuickTableViewController: UITableViewController {

  public var tableContents: [Section] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  // MARK: - Initializer

  convenience init() {
    self.init(style: .Grouped)
  }

  // MARK: - UIViewController

  override public func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerClass(TapActionCell.self, forCellReuseIdentifier: NSStringFromClass(TapActionCell.self))
    tableView.registerClass(SwitchCell.self, forCellReuseIdentifier: NSStringFromClass(SwitchCell.self))
  }

  // MARK: - UITableViewDataSource

  public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return tableContents.count
  }

  public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableContents[section].rows.count
  }

  public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return tableContents[section].title
  }

  public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let row = tableContents[indexPath.section].rows[indexPath.row]
    var cell: UITableViewCell!

    switch (row, row.subtitle, row.action) {
    case (let row, .Some(let subtitle), let action) where row is NavigationRow:
      cell = tableView.dequeueReusableCellWithIdentifier(subtitle.style)

      // Match UITableViewCellStyle to each Subtitle.style
      switch subtitle {
      case .None:
        cell = cell ?? UITableViewCell(style: .Default, reuseIdentifier: subtitle.style)
      case .BelowTitle(_):
        cell = cell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: subtitle.style)
      case .RightAligned(_):
        cell = cell ?? UITableViewCell(style: .Value1, reuseIdentifier: subtitle.style)
      case .LeftAligned(_):
        cell = cell ?? UITableViewCell(style: .Value2, reuseIdentifier: subtitle.style)
      }

      cell.imageView?.image = (row as! NavigationRow).icon
      cell.detailTextLabel?.text = subtitle.text
      cell.accessoryType = (action == nil) ? .None : .DisclosureIndicator

    case (let row, _, _) where row is SwitchRow:
      cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(SwitchCell.self)) as? SwitchCell
      cell = cell ?? SwitchCell(style: .Default, reuseIdentifier: NSStringFromClass(SwitchCell.self))
      cell.textLabel?.text = row.title

      let switchControl = (cell as! SwitchCell).switchControl
      switchControl.on = (row as! SwitchRow).switchValue

      if switchControl.actionsForTarget(self, forControlEvent: .ValueChanged) == nil {
        switchControl.addTarget(self, action: Selector("didToggleSwitch:"), forControlEvents: UIControlEvents.ValueChanged)
      }

    case (let row, _, _) where row is TapActionRow:
      cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(TapActionCell.self))
      cell = cell ?? TapActionCell(style: .Default, reuseIdentifier: NSStringFromClass(TapActionCell.self))

    default:
      cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self))
      cell = cell ?? UITableViewCell(style: .Default, reuseIdentifier: NSStringFromClass(UITableViewCell.self))
    }

    cell.textLabel?.text = row.title
    return cell
  }

  public override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return tableContents[section].footer
  }

  // MARK: - UITableViewDelegate

  public override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    let row = tableContents[indexPath.section].rows[indexPath.row]
    return (row is TapActionRow || row is NavigationRow) && (row.action != nil)
  }

  public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let row = tableContents[indexPath.section].rows[indexPath.row]

    switch (row, row.action) {
    case (let row, let navigation) where row is NavigationRow:
      navigation?(row)
    case (let row, let tap) where row is TapActionRow:
      tap?(row)
      fallthrough
    default:
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
  }

  // MARK: - UIResponder Callbacks

  @objc
  private func didToggleSwitch(sender: UISwitch) {
    if let cell = sender.containerCell, let indexPath = tableView.indexPathForCell(cell) {
      var row = tableContents[indexPath.section].rows[indexPath.row] as! SwitchRow
      row.switchValue = sender.on

      // Replace the original row in tableContents
      tableContents[indexPath.section].rows[indexPath.row] = row
    }
  }

}


// MARK: -


private extension UIView {

  var containerCell: UITableViewCell? {
    get {
      if let superview = superview as? UITableViewCell {
        return superview
      } else {
        return superview?.containerCell
      }
    }
  }

}
