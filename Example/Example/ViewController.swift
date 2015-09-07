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

    tableContents = [
      Section(title: "Cell Styles", rows: [
        Row(title: "CellStyle.Default", subtitle: nil),
        Row(title: "CellStyle", subtitle: Subtitle.BelowTitle(".Subtitle")),
        Row(title: "CellStyle", subtitle: Subtitle.RightAligned(".Value1")),
        Row(title: "CellStyle", subtitle: Subtitle.LeftAligned(".Value2"))
      ]),
      Section(title: "Tap Action", rows: [
        Row(title: "Tap action", action: Tap(showAlert))
      ], footer: "Subtitles are omitted."),
      Section(title: "Navigation", rows: [
        Row(title: "Navigation", subtitle: nil, action: Navigation(showDetail)),
        Row(title: "Navigation", subtitle: Subtitle.BelowTitle("with subtitle"), action: Navigation(showDetail)),
        Row(title: "Navigation", subtitle: Subtitle.RightAligned("with detail"), action: Navigation(showDetail))
      ], footer: "UITableViewCellStyle.Value2 is not listed here."),
      Section(title: nil, rows: [
        Row(title: "Empty section title", subtitle: nil)
      ])
    ]
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

}
