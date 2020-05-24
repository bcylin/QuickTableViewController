//
//  QuickTableViewControllerTests.swift
//  QuickTableViewControllerTests
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

@testable import QuickTableViewController
import XCTest

internal final class QuickTableViewControllerTests: XCTestCase {

  func testInitialization() {
    // When
    let controller = QuickTableViewController()

    // Then it should set up table view with style
    XCTAssertEqual(controller.tableView.style, .grouped)
  }

  func testInitialization_withStyle() {
    // When
    let controller = QuickTableViewController(style: .plain)

    // Then it should set up table view with style
    XCTAssertEqual(controller.tableView.style, .plain)
  }

  func testViewConfiguration() {
    // Given
    let controller = QuickTableViewController(style: .grouped)

    // When
    let view = controller.view
    let tableView = controller.tableView

    // Than it should set up table view
    XCTAssert(try XCTUnwrap(view?.subviews.contains(tableView)))
    XCTAssertEqual(tableView.dataSource as? QuickTableViewController, controller)
    XCTAssertEqual(tableView.delegate as? QuickTableViewController, controller)
  }

}
