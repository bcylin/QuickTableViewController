//
//  QuickTableViewControllerSpec.swift
//  QuickTableViewController
//
//  Created by Ben on 21/01/2016.
//  Copyright © 2016 bcylin.
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

import Nimble
import Quick
import QuickTableViewController

class QuickTableViewControllerSpec: QuickSpec {

  override func spec() {

    // MARK: - UITableViewDataSource

    describe("numberOfSectionsInTableView(_:)") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: []),
        Section(title: nil, rows: []),
        Section(title: nil, rows: [])
      ]
      it("should return the number of sections") {
        expect(controller.numberOfSectionsInTableView(controller.tableView)) == 3
      }
    }

    describe("tableView(_:numberOfRowsInsection:)") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: []),
        Section(title: nil, rows: [
          NavigationRow(title: "", subtitle: .None),
          NavigationRow(title: "", subtitle: .None)
        ])
      ]
      it("should return the number of sections") {
        expect(controller.tableView(controller.tableView, numberOfRowsInSection: 0)) == 0
        expect(controller.tableView(controller.tableView, numberOfRowsInSection: 1)) == 2
      }
    }
  }

}
