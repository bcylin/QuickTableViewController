//
//  RootViewController.swift
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

internal final class RootViewController: QuickTableViewController {

  init() {
    if #available(iOS 13.0, *) {
      super.init(style: .insetGrouped)
    } else {
      super.init(style: .grouped)
    }

    let titleLabel = UILabel()
    titleLabel.text = "QuickTableViewController"
    titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    title = " "
    navigationItem.titleView = titleLabel
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    tableContents = [
      Section(title: "Default", rows: [
        NavigationRow(text: "Use default cell types", detailText: .none, action: { [weak self] _ in
          self?.navigationController?.pushViewController(ExampleViewController(), animated: true)
        })
      ]),

      Section(title: "Customization", rows: [
        NavigationRow(text: "Use custom cell types", detailText: .none, action: { [weak self] _ in
          self?.navigationController?.pushViewController(CustomizationViewController(), animated: true)
        })
      ]),

      Section(title: "UIAppearance", rows: [
        NavigationRow(text: "UILabel customization", detailText: .none, action: { [weak self] _ in
          self?.navigationController?.pushViewController(AppearanceViewController(), animated: true)
        })
      ])
    ] + swiftUIExamples()
  }

  func swiftUIExamples() -> [Section] {
    guard #available(iOS 13, *) else {
      return []
    }

    return [
      Section(title: "Dynamic", rows: [
        NavigationRow(text: "Dynamic Rows", detailText: .none, action: { [weak self] _ in
          self?.navigationController?.pushViewController(DynamicViewController(), animated: true)
        })
      ])
    ]
  }

}
