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
        Row(title: "Title", subtitle: nil),
        Row(title: "Title", subtitle: "Subtitle")
      ]),
      Section(title: "Actions", rows: [
        Row(title: "Tap action", tapAction: showAlert),
        Row(title: "Navigation", subtitle: nil, navigation: showDetail)
      ]),
      Section(title: nil, rows: [
        Row(title: "Empty section title", subtitle: nil)
      ])
    ]
  }

  // MARK: - Private Methods

  private func showAlert() {
    let alert = UIAlertController(title: "Action Triggered", message: nil, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Cancel) { [unowned self] _ in
      self.dismissViewControllerAnimated(true, completion: nil)
    })
    presentViewController(alert, animated: true, completion: nil)
  }

  private func showDetail() {
    let controller = UIViewController()
    controller.view.backgroundColor = UIColor.whiteColor()
    navigationController?.pushViewController(controller, animated: true)
  }

}
